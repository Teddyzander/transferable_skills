function [d] = max_depth(v_0, rho_p, r, sigma_y, rho_s, c_D, c, ang)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% calculate some constants we will need
A = pi * r ^2; % area of particle
m = rho_p * A *r; % mass of the particle
v_0 = v_0 * ang;

d = m / (c_D * rho_s * A) * ...
    log(1 + (c_D * rho_s * v_0^2) / (2 * c * sigma_y));
end

