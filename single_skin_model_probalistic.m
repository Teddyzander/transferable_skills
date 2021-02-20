%% define all parameters
N = 10000 %how many simulations we want
depth_L = 10; % depth of the Langerhan cells from dermis
r_LC = 4; % radius of Langerhan cells's nucleus
%depth_SC = 20 + (30 - 20) * rand(N, 1); % thickness of stratum corneum uniform
depth_SC = normrnd((30 + 20)/2, ((30+20)/2)*0.025, [1, N]); % normal dist mu=25, sd=2.5%
%depth_VE = 50 + (100 - 50) * rand(N, 1); % thickness of viable epidermis uniform
depth_VE = normrnd((50 + 100)/2, ((50+100)/2)*0.025, [1, N]); % normal dist mu=75, sd=2.5%
rho_LC = 1000; % 1000 Langherhan cells per mm
rho_SC = 1500; % density of stratum corneum kg/m^3
rho_VE = 1200; % density of viable epidermis kg/m^3
% sig_SC = 2 + (25 - 2) * rand(N, 1); % average yield stress for stratum corneum in MPA uniform
sig_SC = normrnd((25 + 2)/2, ((250+2)/2)*0.025, [1, N]); %normal distribution
sig_VE = 2; % yield stress for viable epidermis in MPA
mu = 0.89; % water viscosity in micropascals per second
ymod_SC = 4; % youngs modulus of stratum corneum in gigapascals
ymod_VE = 3; % youngs modulus of viable epidermis in gigapascals
% v_0 = 400 + (600-400) * rand(N, 1);
v_0 = normrnd((400 + 600)/2, ((400+600)/2)*0.025, [1, N]); %normal dist
% r = 0.5 + (2.5 - 0.5) * rand(N, 1); % typical particle radius
r = normrnd((0.5 + 2.5)/2, ((0.5+2.5)/2)*0.025, [1, N]); %normal dist
rho_g = 19.32; % density of gold kg/m^3
c_D = 0.5; % drag coeffecient
c = 3; % yield constant

% calculate some parameters from others
area = pi .* r.^2; % area of the particle
rho_s = (rho_SC+rho_VE)./2; % average density for one skin system
sig_s = (sig_SC + sig_VE)/2; % average yield constant for one skin system
mass = rho_g .* area .*r; % mass of the particle
final_dist = zeros(N, 1);

%% define equation for calculating distance
dist = @(v, m, A, sig) (m./(c_D.*rho_s.*A)) * log(1 + (c_D.*rho_s.*v.^2)/(2*c .* sig));

%% run N simulations

for i=1:N
    final_dist(i) = dist(v_0(i), mass(i), area(i), sig_s(i));
end

%% plot the results
figure(1)
plot(v_0, final_dist, '.')
ylabel('final distance')
xlabel('initial velocity')
figure(2)
plot(r, final_dist, '.')
ylabel('final distance')
xlabel('radius')
    
    
    
    
    
    
    