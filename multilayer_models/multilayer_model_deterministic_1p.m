format long

%% define all parameters
step_size = 0.00001;
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
ang = cos(0); % angle of entry 
r = (0.5+2.5)/2; % typical particle radius
rho_g = 19.32; % density of gold kg/m^3
c_D = 0.5; % drag coeffecient
c = 3; % yield constant

% depths for the cells we want to hit
good_depth_upper = depth_SC+depth_VE-depth_L + r_LC/2;
good_depth_lower = depth_SC+depth_VE-depth_L - r_LC/2;

% preallocate memory for matrices
time = [0:step_size:0.6];
x = zeros(1, length(time));
layer2 = 0; % flag to check velocity on first entry into layer 2
v_1 = -999999; % bad number for entry velocity into layer 2 (bug checking)

for i=2:length(time)
    % check if we are in layer 2
    if x(i-1) >= depth_SC/100
        % check if this is first entry into layer 2
        if layer2 == 0
            % this is our first entry, so get velocity at this point
            layer2 = 1;
            v_1 = vel(time(i-1), v_0, rho_g, r, sigma_y, rho_s, c_D, c);
        end
        % calculate depth in layer 2 using layer 2 parameters
        x(i) = depth(time(i), v_1, rho_g, r, sig_SC, rho_SC, c_D, c, ang);
    else
        % in layer 1, so use layer 1 parameters
        x(i) = depth(time(i), v_0, rho_g, r, sig_VE, rho_VE, c_D, c, ang);
    end
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
