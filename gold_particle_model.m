% script simulates a simple model of a particle
% penetrating a single layered model of skin

%% define all parameters
% want everything in meters/kg
depth_L = 10; % depth of the Langerhan cells 
r_LC = 4; % radius of Langerhan cells 
depth_SC = ((20+30)/2); % thickness of stratum corneum 
depth_VE = ((50+100)/2); % thickness of viable epidermis 
rho_LC = 1000; % 1000 Langherhan cells per mm
rho_SC = 1500; % density of stratum corneum kg/m^3
rho_VE = 1200; % density of viable epidermis kg/m^3
sig_SC = (3+25)/2; % average yield stress for stratum corneum in MPA
sig_VE = 2; % yield stress for viable epidermis in MPA
mu = 0.89; % water viscosity in micropascals per second
ymod_SC = 4; % youngs modulus of stratum corneum in gigapascals
ymod_VE = 3; % youngs modulus of viable epidermis in gigapascals
v_0 = (400+600)/2; % typical entry velocity of particle
r = (0.5+2.5)/2; % typical particle radius
rho_g = 19.32; % density of gold kg/m^3
c_D = 0.5; % drag coeffecient
c = 3; % yield constant

% calculate some parameters from others
A = pi * r^2; % area of the particle
rho_s = (rho_SC+rho_VE)/2; % average density for one skin system
sig_s = (sig_SC + sig_VE)/2; % average yield constant for one skin system
m = rho_g * A; % mass of the particle

%% create the function to model the change in velocity
% define acceleration as function of velocity
a = @(v) (1/m) * (-0.5 * c_D * rho_s * A * v^2 - c * A * sig_s);
c * A * sig_s

% define step size and preallocate vectors to hold calculated values
steps = [1:1:30000];
factor = 1/100000;
velocity = zeros(length(steps), 1);
pos = zeros(length(steps), 1);
velocity(1) = v_0;
pos(1) = 0;

%% run a simulation
% use the velocity equation to estimate the velocity at each time step
% then use the velocty to estimate the position of the particle
for i=2:length(steps)
    change = a(velocity(i-1));
    if change < 0
        velocity(i) = velocity(i-1) + change * factor;
        pos(i) = pos(i - 1) + ((velocity(i-1)+ velocity(i))/2) * factor;
    end
end

%% plot the data
% velocity profile through time
%figure(1)
%plot(steps, velocity);
% position of the particle through time
%figure(2)
%plot(steps, pos);

%% define all parameters
% want everything in meters/kg
N = 5000 %how many simulations we want
depth_L = 10; % depth of the Langerhan cells 
r_LC = 4; % radius of Langerhan cells 
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
mass = rho_g .* area; % mass of the particle
final_dist = zeros(N, 1);

dist = @(v, m, A, sig) (m./(c_D.*rho_s.*A)) * log(1 + (c_D.*rho_s.*v.^2)/(2*c .* sig));
for i=1:N
    final_dist(i) = dist(v_0(i), mass(i), area(i), sig_s(i));
end

figure(1)
plot(v_0, final_dist, '.')
ylabel('final distance')
xlabel('velocity')
figure(2)
plot(mass, final_dist, '.')
ylabel('final distance')
xlabel('mass')
figure(3)
plot3(mass, v_0, final_dist, '.')

    
    
    
    
    
    
    