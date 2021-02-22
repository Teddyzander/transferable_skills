%% define all parameters
N = 10000; %how many simulations we want
depth_L = 10; % depth of the Langerhan cells from dermis
r_LC = 4; % radius of Langerhan cells's nucleus
depth_SC = 20 + (30 - 20) * rand(1, N); % thickness of stratum corneum uniform
% depth_SC = normrnd((30 + 20)/2, ((30+20)/2)*0.025, [1, N]); % normal dist mu=25, sd=2.5%
depth_VE = 50 + (100 - 50) * rand(1, N); % thickness of viable epidermis uniform
% depth_VE = normrnd((50 + 100)/2, ((50+100)/2)*0.025, [1, N]); % normal dist mu=75, sd=2.5%
rho_LC = 1000; % 1000 Langherhan cells per mm
rho_SC = 1500; % density of stratum corneum kg/m^3
rho_VE = 1200; % density of viable epidermis kg/m^3
% sig_SC = 13.5;
sig_SC = 2 + (25 - 2) * rand(1, N); % average yield stress for stratum corneum in MPA uniform
% sig_SC = normrnd((25 + 2)/2, ((250+2)/2)*0.025, [1, N]); %normal distribution
sig_VE = 2; % yield stress for viable epidermis in MPA
mu = 0.89; % water viscosity in micropascals per second
ymod_SC = 4; % youngs modulus of stratum corneum in gigapascals
ymod_VE = 3; % youngs modulus of viable epidermis in gigapascals
% v_0 = 500;
v_0 = 400 + (600-400) * rand(1, N);
% v_0 = normrnd((400 + 600)/2, ((400+600)/2)*0.025, [1, N]); %normal dist
r = 0.5 + (2.5 - 0.5) * rand(1, N); % typical particle radius
% r = [0.5:(2.5-0.5)/(N-1):2.5];
% r = normrnd((0.5 + 2.5)/2, ((0.5+2.5)/2)*0.025, [1, N]); %normal dist
rho_g = 19.32; % density of gold kg/m^3
c_D = 0.5; % drag coeffecient
c = 3; % yield constant

% calculate some parameters from others
A = pi .* r.^2; % area of the particle
rho_s = (rho_SC+rho_VE)./2; % average density for one skin system
sig_s = (sig_SC + sig_VE)/2; % average yield constant for one skin system
m = rho_g .* A .*r; % mass of the particle
final_dist = zeros(N, 1);

% from calculations, define some constantsa
alpha = (c * A .* sig_s)./(0.5*c_D * A .* rho_s);
beta = 1./(0.5*c_D * A .* rho_s);
gamma = sqrt(c*c_D*rho_s*sig_s);

%% define velocity as a function of time
v = @(t) tan(((-t .* sqrt(alpha))/(m .* beta)) + ...
    atan(v_0./sqrt(alpha))).*sqrt(alpha);

% define velocity as a function of time
v1 = @(t) (tan(-t./(sqrt(2).*rho_g .* r).*gamma + ...
    atan((v_0.*c_D.*rho_s)./(sqrt(2).*gamma))) .* ...
    sqrt(2) .* gamma) ./ ...
    (c_D .* rho_s);

% these should almost equal v_0
a = v(zeros(1, N));
if abs(a-v_0) > 0.0000000001
    disp('bad model')
    return
end

%% run the simulation for each step for large radius
step_size = 0.00001;
time = [0:step_size:0.55];
speed = zeros(N, length(time));
speed(:, 1) = v_0;
dist = zeros(N, length(time));
stop = 0;

for i=2:length(time)
    speed(:, i)=v1(time(i));
    for j=1:N
        if speed(j, i) < 0
            speed(j, i) = 0;
        end
    end
    dist(:, i) = dist(:, i-1) + speed(:, i-1) * step_size;
end

%% plot results

figure(1)
plot(1:N, dist(:, length(time)), '.')
xlabel('Simulation')
ylabel('Final depth')
ylim([0,1.2])
title('effect of large radius variation on final depth')
figure(2)
plot(r, dist(:, length(time)), '.b')
xlabel('radius')
ylabel('Final depth')
ylim([0,1.2])
title('effect radius variation on final depth')
figure(4)
plot(m, dist(:, length(time)), '.b')
xlabel('mass')
ylabel('Final depth')
ylim([0,1.2])
title('effect mass variation on final depth')
figure(5)
plot(A, dist(:, length(time)), '.b')
xlabel('area')
ylabel('Final depth')
ylim([0,1.2])
title('effect area variation on final depth')

%% run for more controlled radius and initial velocity
% r = normrnd((1.2 + 1.8)/2, ((1.2+1.8)/2)*0.025, [1, N]);
r = 1.2 + (1.8 - 1.2) * rand(1, N); % typical particle radius
v_0 = 450 + (550-450) * rand(1, N);
A = pi .* r.^2; % area of the particle
m = rho_g .* A .*r; % mass of the particle
% from calculations, define some constants
alpha = (c * A .* sig_s)./(0.5*c_D * A .* rho_s);
beta = 1./(0.5*c_D * A .* rho_s);
gamma = sqrt(c*c_D*rho_s*sig_s);

% define velocity as a function of time
v = @(t) tan(((-t .* sqrt(alpha))/(m .* beta)) + ...
    atan(v_0./sqrt(alpha))).*sqrt(alpha);
v1 = @(t) (tan(-t./(sqrt(2).*m).*A.*gamma + ...
    atan((v_0.*c_D.*rho_s)./(sqrt(2).*gamma))) .* ...
    sqrt(2) .* gamma) ./ ...
    (c_D .* rho_s);

step_size = 0.00001;
time = [0:step_size:0.55];
speed = zeros(N, length(time));
speed(:, 1) = v_0;
dist = zeros(N, length(time));
stop = 0;

for i=2:length(time)
    speed(:, i)=v1(time(i));
    for j=1:N
        if speed(j, i) < 0
            speed(j, i) = 0;
        end
    end
    dist(:, i) = dist(:, i-1) + speed(:, i-1) * step_size;
end

% plot results

figure(3)
plot(1:N, dist(:, length(time)), '.')
xlabel('Simulation')
ylabel('Final depth')
ylim([0,1.2])
title('effect of small radius variation on final depth')