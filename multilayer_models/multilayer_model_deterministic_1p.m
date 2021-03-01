%% define all parameters
step_size = 0.000001;
depth_L = 10; % depth of the Langerhan cells 
r_LC = 4; % radius of Langerhan cells 
depth_SC = 30; % thickness of stratum corneum 
depth_VE = 100; % thickness of viable epidermis 
rho_LC = 1000; % 1000 Langherhan cells per mm
rho_SC = 1500; % density of stratum corneum kg/m^3
rho_VE = 1200; % density of viable epidermis kg/m^3
sig_SC = 3; % average yield stress for stratum corneum in MPA
sig_VE = 2; % yield stress for viable epidermis in MPA
mu = 0.89; % water viscosity in micropascals per second
ymod_SC = 4; % youngs modulus of stratum corneum in gigapascals
ymod_VE = 3; % youngs modulus of viable epidermis in gigapascals
v_0 = 600; % typical entry velocity of particle
ang = cos(0); % angle of entry 
r = 1.5; % typical particle radius
rho_g = 19.32; % density of gold kg/m^3
c_D = 0.5; % drag coeffecient
c = 3; % yield constant

% depths for the cells we want to hit
good_depth_upper = depth_SC+depth_VE-depth_L + r_LC/2;
good_depth_lower = depth_SC+depth_VE-depth_L - r_LC/2;

% preallocate memory for matrices
time = [0:step_size:1.5];
x = zeros(1, length(time));
pend = 0;
layer2 = 0;

for j=1:3
    for i=2:length(time)
        % check if we are in layer 2
        if x(i-1) >= depth_SC/100
             % this is our first entry, so get velocity at this point
             if layer2 == 0
                t=i-1;
                pend = x(i-1);
                layer2 = 1;
                v_1 = vel(time(i-1), v_0, rho_g, r, sig_SC, rho_SC, c_D, c);
                d = pend + max_depth(v_1, rho_g, r, sig_VE, rho_VE, c_D, c, ang);
             end
             d_1 = pend + depth(time(i-t), v_1, rho_g, r, sig_VE, rho_VE, c_D, c, ang);
             if d_1 < x(i-1)
                 x(i) = x(i-1);
             else
                 x(i) = d_1;
             end
        else
            % in layer 1, so use layer 1 parameters
            x(i) = depth(time(i), v_0, rho_g, r, sig_SC, rho_SC, c_D, c, ang);
            if x(i) < x(i-1)
                 x(i) = x(i-1);
                 d = max_depth(v_0, rho_g, r, sig_SC, rho_SC, c_D, c, ang);
            end
        end
    end
end
d3 = d;
x3 = x;

%%

hold on
test1 = plot(time, x1, '-b')
test2 = plot(time, x2, '-g')
test3 = plot(time, x3, '-k')
hold on
plotter1 = ones(1, length(time)) * d1;
plotter2 = ones(1, length(time)) * d2;
plotter3 = ones(1, length(time)) * d3;
depth1 = ones(1, length(time)) * good_depth_upper/100;
depth2 = ones(1, length(time)) * good_depth_lower/100;
plot(time, plotter1, '--r')
plot(time, plotter2, '--r')
plot(time, plotter3, '--r')
hold on
title('depth of particle for different radius')
xlabel('time')
ylabel('depth in um')
ylim([0,1.5])

%%
grid on
legend([test1, test2, test3], '$v_0 = 400$', '$v_0 = 500$', '$v_0 = 600$','interpreter','latex','FontSize',10);
title('Depth in the skin where a particle comes to rest','interpreter','latex','FontSize',12)
xlabel('Time, $t$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('Depth of the skin, $\mu{m}$','interpreter','latex','FontSize',12,'FontWeight', 'bold')

%xlabel('Sparsity $k/n$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
%ylabel('Number of equations $m/n$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
