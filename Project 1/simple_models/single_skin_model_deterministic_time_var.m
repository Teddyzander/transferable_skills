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
a = v(0);
b = t_test(0);
c = t_test2(0);
if abs(a-v_0) > 0.0000000001 || ...
    abs(b-v_0) > 0.0000000001 || ...
    abs(c-v_0) > 0.0000000001
    disp('bad model')
    return
end

%% run the simulation for each step
step_size = 0.0001;
time = [0:step_size:1];
speed = zeros(1, length(time));
speed(1) = v_0;
dist = zeros(1, length(time));
stop = 0

for i=2:length(time)
    speed(i) = v(time(i));
    if speed(i) < 0 
        speed(i) = 0;
        if stop == 0
            stop = i;
        end
    end
    dist(i) = dist(i-1) + speed(i-1) * step_size;
end

%% plot results

figure(1)
subplot(1, 2, 1)
plot(time, speed, '-r')
title('v(t)')
xlim([0, step_size * stop])
xlabel('time')
ylabel('velocity')

subplot(1, 2, 2)
plot(time, dist, '-r')
title('numerical x(t)')
xlabel('time')
ylabel('depth')
xlim([0, step_size * stop])

%% testing some values of time to see strange behaviour
%{
time(5056:5058)
testa = (-time(5056:5058)./(sqrt(2)*m)*A*gamma)
testb = atan((sqrt(c_D)*sqrt(rho_s) * v_0)/(sqrt(2) * sqrt(c) * sqrt(sig_s)))

tan(testa + testb)
%}







