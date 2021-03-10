function [v] = vel(t, v_0, rho_p, r, sigma_y, rho_s, c_D, c)
% vel calculate velocity of a particle with given parameters at a certain
% time

%{ 
INPUTS:
t: positve float - time
v_0: float - initial velocity of the particle
rho_p: postivie float - density of the particle
r_p: positive float - radius of the particle
sigma_y: postive float - yield strength of the substance
rho_s: positive float - density of the substance
c_D: positive float - drag coeffecient
c: positive float - yield constant

OUTPUTS:
x: float - position at time = t
%}

% calculate some constants we will need
A = pi * r ^2; % area of particle
m = rho_p * A *r; % mass of the particle
a = (2 * c * sigma_y) / (c_D * rho_s);
b = 2 / ( c_D * rho_s * A);
C = atan(v_0/sqrt(a)); % constant after integrating F=ma

v = sqrt(a) * tan( ...
    -(t * sqrt(a))/(m * b) + C);
    
end

