%% define all parameters
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

% from calculations, define some constantsa
alpha = (c * A * sig_s)/(0.5*c_D * A * rho_s);
beta = 1/(0.5*c_D * A * rho_s);
gamma = sqrt(c*c_D*rho_s*sig_s);

%% define velocity as a function of time
v = @(t) tan(((-t * sqrt(alpha))/(m * beta)) + ...
    atan(v_0/sqrt(alpha)))*sqrt(alpha);

t_test = @(t) ((sqrt(2) * sqrt(c) * sqrt(sig_s)) * ...
    tan((-t/m * sqrt(2)) * A * sqrt(c) * sqrt(rho_s) * sqrt(sig_s) + ...
    atan((sqrt(c_D)*sqrt(rho_s) * v_0)/(sqrt(2) * sqrt(c) * sqrt(sig_s))))) / ...
    (sqrt(c_D) * sqrt(rho_s));

t_test2 = @(t) (tan(-t/(sqrt(2)*m)*A*gamma + ...
    atan((v_0*c_D*rho_s)/(sqrt(2)*gamma))) * ...
    sqrt(2) * gamma) / ...
    (c_D * rho_s);

% these should equal v_0
v(0)
t_test(0)
t_test2(0)

%% run the simulation for each step
time = [0:0.0001:1];
speed1 = zeros(1, length(time));
speed2 = zeros(1, length(time));
speed3 = zeros(1, length(time));
under0 = zeros(1, length(time));

for i=1:length(time)
    speed1(i) = v(time(i));
    speed2(i) = t_test(time(i));
    speed3(i) = t_test2(time(i));
    if speed3(i) < 0 
        under0(i) = speed3(i);
    else
        under0(i) = inf;
    end
end

%% plot results

figure(1)
subplot(2, 2, 1)
plot(time, speed1, '-r')
title('velocity profile for Ruslans integration')
xlim([0, 0.05])
xlabel('time')
ylabel('velocity')

subplot(2, 2, 2)
plot(time, speed2, '-b')
title('bad integration')
xlim([0, 0.05])
xlabel('time')
ylabel('velocity')

subplot(2, 2, 3)
plot(time, speed3, '-k')
title('Another integration (agrees with ruslan)')
xlim([0, 0.05])
xlabel('time')
ylabel('velocity')

subplot(2, 2, 4)
plot(time, under0, '-g')
xlim([0,1])
ylim([-10, 10])
title('velocity values that fall below 0')
xlabel('time')
ylabel('velocity')

%% testing some values of time to see strange behaviour
time(5056:5058)
testa = (-time(5056:5058)./(sqrt(2)*m)*A*gamma)
testb = atan((sqrt(c_D)*sqrt(rho_s) * v_0)/(sqrt(2) * sqrt(c) * sqrt(sig_s)))

tan(testa + testb)








