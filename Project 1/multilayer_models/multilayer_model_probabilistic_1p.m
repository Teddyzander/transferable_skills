%% define all parameter
N = 100000; %number of particles fired
step_size = 0.0001; %step size for each particle
depth_L = 10; % depth of the Langerhan cells 
r_LC = 4; % radius of Langerhan cells 
depth_SC = normrnd(25,2.6,[1,N]); % thickness of stratum corneum 
depth_VE = normrnd(75,13,[1,N]); % thickness of viable epidermis 
rho_LC = 1000; % 1000 Langherhan cells per mm
rho_SC = 1500; % density of stratum corneum kg/m^3
rho_VE = 1200; % density of viable epidermis kg/m^3
sig_SC = normrnd(14,6,[1,N]); % average yield stress for stratum corneum in MPA
sig_VE = 2; % yield stress for viable epidermis in MPA
mu = 0.89; % water viscosity in micropascals per second
ymod_SC = 4; % youngs modulus of stratum corneum in gigapascals
ymod_VE = 3; % youngs modulus of viable epidermis in gigapascals
v_0 = normrnd(500,51,[1,N]); % typical entry velocity of particle
ang = cos(normrnd(0,0.01,[1,N])); % angle of entry 
r = normrnd(1.9,0.3,[1,N]); % normally distributed radius for particles
rho_g = 19.32; % density of gold kg/m^3
c_D = 0.5; % drag coeffecient
c = 3; % yield constant

% fix the parameters that are distributed to a range
for j=1:N
   % check radius
    if r(j) > 2.9
        r(j) = 2.9;
    elseif r(j) < 0.9
        r(j) = 0.9;
    end
    % check entry velocity
    if v_0(j) > 600
        v_0(j) = 600;
    elseif v_0(j) < 400
        v_0(j) = 400;
    end
    % check skin thickness levels
    if depth_SC(j) > 30
        depth_SC(j) = 30;
    elseif depth_SC(j) < 20
        depth_SC(j) = 20;
    end
    if depth_VE(j) > 100
        depth_VE(j) = 100;
    elseif depth_VE(j) < 50
        depth_VE(j) = 50;
    end
    % check yield stress
    if sig_SC(j) > 25
        sig_SC(j) = 25;
    elseif sig_SC(j) < 3
        sig_SC(j) = 3;
    end
end

% depths for the cells we want to hit
good_depth_upper = depth_SC+depth_VE-depth_L + r_LC/2;
good_depth_lower = depth_SC+depth_VE-depth_L - r_LC/2;

% preallocate memory for matrices
time = [0:step_size:0.75];
x = zeros(1, length(time));
pend = 0;
layer2 = 0;
d = zeros(1, N);
good = 0;
short = 0;
long = 0;
for j=1:N
    for i=2:length(time)
        % check if we are in layer 2
        if d(j) >= depth_SC(j)/100
             v_1 = vel(time(i-1), v_0(j), rho_g, r(j), sig_SC(j), rho_SC, c_D, c);
             d(j) = d(j) + max_depth(v_1, rho_g, r(j), sig_VE, rho_VE, c_D, c, ang(j));
             if d(j) >= good_depth_lower(j)/100
                 good = good + 1;
             elseif d(j) > good_depth_upper(j)/100
                 long = long + 1;
             elseif d(j) < good_depth_lower(j)/100
                 short = short + 1;
             end
             break;
        else
            % in layer 1, so use layer 1 parameters
            temp = d(j);
            d(j) = depth(time(i), v_0(j), rho_g, r(j), sig_SC(j), rho_SC, c_D, c, ang(j));
            % we cannot move backwards
            if temp > d(j)
                d(j) = temp;
            end
        end
    end
end

% check how many particles landed where
disp('Particles that landed in the LC zone')
(good/N*100)
disp('Particles that landed short of the LC zone')
short/N*100
disp('Particles that over shot the LC zone')
long/N*100

%% plotting routine
figure(1)
mean = sum(d*100)/N
sd_d = std(d*100)
plot([1:N], d*100, '.')
hold on 
plot([1:N], ones(1, N) * (25 + 75 - 10), '-r', 'linewidth', 2)
plot([1:N], ones(1, N) * (25 + 75 - 10 + 13 + 2.6), '-g', 'linewidth', 2)
plot([1:N], ones(1, N) * mean, '-y', 'linewidth', 2)
plot([1:N], ones(1, N) * mean+sd_d, '-k', 'linewidth', 2)
plot([1:N], ones(1, N) * (25 + 75 - 10 - 13 - 2.6), '-g', 'linewidth', 2)
plot([1:N], ones(1, N) * mean-sd_d, '-k', 'linewidth', 2)


legend('particle', '$\mu_{LC}$ depth', '$\mu_{LC}\pm\sigma_{LC}$ depth', ... 
    '$\mu_{particle}$ depth', '$\mu_{particle}\pm\sigma_{particle}$ depth', ...
    'interpreter','latex','FontSize',10, 'Location', 'southeast');
title('Depth in the skin where a particle comes to rest ($\mu_r = 1.9, \sigma_r = 0.3$)', ...
    'interpreter','latex','FontSize',12)
xlabel('Simulated Particle, $1:N$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('Depth of the skin, $\mu{m}$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylim([0, 150])
    
%%

logA = @(x) log(x)/log(.846)
logA(0.05)

8955/0.6107
    
    
    
    
    
    
    
