% script simulates a simple model of a particle
% penetrating a single layered model of skin

%% define all parameters
% want everything in meters/kg
depth_L = 10*10^(-6); % depth of the Langerhan cells 
r_LC = 4*10^(-6); % radius of Langerhan cells 
depth_SC = ((20+30)/2)*10^(-6); % thickness of stratum corneum 
depth_VE = ((50+100)/2)*10^(-6); % thickness of viable epidermis 
rho_LC = 1000; % 1000 Langherhan cells per mm
rho_SC = 1500; % density of stratum corneum kg/m^3
rho_VE = 1200; % density of viable epidermis kg/m^3
sig_SC = (3+25)/2; % average yield stress for stratum corneum in MPA
sig_VE = 2; % yield stress for viable epidermis in MPA
mu = 0.89; % water viscosity in micropascals per second
ymod_SC = 4; % youngs modulus of stratum corneum in gigapascals
ymod_VE = 3; % youngs modulus of viable epidermis in gigapascals
v_0 = (400+600)/2; % typical entry velocity of particle
r = ((0.5+2.5)*10^(-6))/2; % typical particle radius
rho_g = 19.32 * 10^3; % density of gold kg/m^3
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

% define step size and preallocate vectors to hold calculated values
steps = [1:1:10000000];
factor = 1/1000000;
velocity = zeros(length(steps), 1);
pos = zeros(length(steps), 1);
velocity(1) = v_0;
pos(1) = 0;

%% run a simulation
% use the velocity equation to estimate the velocity at each time step
% then use the velocty to estimate the position of the particle
for i=2:length(steps)
    change = a(velocity(i-1));
    velocity(i) = velocity(i-1) + change * factor;
    pos(i) = pos(i - 1) + (velocity(i-1)+ velocity(i))/2 * factor;
end

%% plot the data
% velocity profile through time
figure(1)
plot(steps, velocity);
% position of the particle through time
figure(2)
plot(steps, pos);
    
    
    
    
    
    
    