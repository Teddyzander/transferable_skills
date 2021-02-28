%% define all parameters
step_size = 0.000001;
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
v_0 = 500; % typical entry velocity of particle
ang = cos(0); % angle of entry 
r = 1.8; % typical particle radius
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

hold on
plot(time, x, '-b')
hold on
plotter = ones(1, length(time)) * d;
plot(time, plotter, '--r')
title('depth of particle for different initial velocity')
xlabel('time')
ylabel('depth in um')
legend('x(t)', 'max depth function', 'Location', 'southeast')
ylim([0,1.5])
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
