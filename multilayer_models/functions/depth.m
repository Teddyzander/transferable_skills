function [x] = depth(t, v_0, rho_p, r, sigma_y, rho_s, c_D, c, ang)
% DEPTH calculate depth of a particle with given parameters at a certain
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
v_0 = v_0 * ang;

x = (2 * m) / (c_D * rho_s * A) * ...
    (0.5 * log( 1 + (c_D * rho_s * v_0^2)/(2 * c * sigma_y)) + ...
    log(abs(cos((-sqrt(a)*t)/(m*b) + atan(v_0/sqrt(a))))));
    
end

