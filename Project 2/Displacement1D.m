%% define constants
T = 6.29 * 10^(-4); % tension in Nm
rho = 6.5 * 10^(-7); % density in kgm^2
pr = 0.456; % poisson's ratio of graphene 0.448-0.464
E = 383; % Young's modulus of graphene 381-385
th = 0.335; % thickness of a graphene membrane
omega = 500; % frequency in kilohertz
p_0 = 4 * 10^(-2); % pressure wave amplitude
L = 20; % length of membrane
elements = 100; % splitting up the membrane
step = 1/100; % step size
t_length = 0.01*12; % final time

%% define functions for pressure and vibration

p = @(t) p_0*exp(1i*omega*t); % applied pressure
D = (E * th^3)/(12*(1 - pr)); % flexural rigidity
w = @ (x, t) ((p(t)*(L/2)^4)/(64*D))*(1-(x^2)/(L/2)^2)^2

x = [-L/2:0.1:L/2];

d = zeros(1, length(x));

figure(1)
for j=0:step:t_length
    for i=1:length(d)
        d(i) = w(x(i), j);
    end
    plot(x, d)
    hold on
end
ylim([-25,25])

