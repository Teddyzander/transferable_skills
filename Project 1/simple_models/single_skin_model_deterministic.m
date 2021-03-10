% script simulates a simple deterministic model of a particle
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
m = rho_g * A .* r; % mass of the particle

%% create functions to model the final distance travelled

dist_v = @(v) (m./(c_D.*rho_s.*A)) * ...
    log(1 + (c_D.*rho_s.*v.^2)/(2*c .* sig_s)); %function of velocity

dist_m = @(mass, area) (mass./(c_D.*rho_s.*area)) * ...
    log(1 + (c_D.*rho_s.*v_0.^2)/(2*c .* sig_s));

%% run a simulation for each acceptable initial velocity and mass
v = [400:(600-400)/100:600]; % 101 data points between bounds
final_dist_v = dist_v(v);
radius = [0.5:(2.5-0.5)/100:2.5]; % 101 data points between bounds
area = pi * radius.^2;
mass = rho_g .* area .* radius;
final_dist_m = dist_m(mass, area);

%% plot a data 
% plot curve that shows initial velocity against distance travelled
figure(1);
subplot(1,2,1);
plot(v, final_dist_v, '-b');
xlabel('Initial Velocity on Entry');
ylabel('Final Distance Travelled');
title('How Initial Velocity effects penetration, all other things being equals');
ylim([0, 1.2]);

% plot curve that shows mass against distance travelled
subplot(1,2,2);
plot(mass, final_dist_m, '-b');
xlabel('mass');
ylabel('Final Distance Travelled');
title('How Area effects penetration, all other things being equals');
ylim([0, 1.2]);

