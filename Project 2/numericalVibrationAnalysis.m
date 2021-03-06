%% define constants
T = 6.29 * 10^(-4); % tension in Nm
rho = 6.5 * 10^(-7); % density in kgm^2
omega = 500; % frequency in kilohertz
p_0 = 4 * 10^(-2); % pressure wave amplitude
L = 50; % length of membrane
elements = 100; % splitting up the membrane
step = 1/10000; % step size
t_length = 0.0001*1000; % final time

%% define functions for pressure and vibration

p = @(t) p_0*exp(1i*omega*t); %% applied pressure

w_dashdash = @(w1, w2, w3, t, x) 1/rho * ((T/2) * ...
((w3 - w2) - (w2 - w1)) - p(t));

%% set up variables for membrane
% set up variables for  time
time = [0:step:t_length];

%set up variables for membrane
mem = [0:1/elements:L];

% set up membrane with boundary conditions
mesh_mem_time = zeros(length(time), length(mem));

% set boundary conditions that mem(t, 0) = mem(t, L) = 0
mesh_mem_time(:,1) = 0;
mesh_mem_time(:,length(mem)) = 0;

%% run analysis
for i=2:length(time)
    for j=2:length(mem)-1
        mesh_mem_time(i, j) = mesh_mem_time(i-1, j) + ...
            w_dashdash(mesh_mem_time(i-1, j-1), ...
            mesh_mem_time(i-1, j), ...
            mesh_mem_time(i-1, j+1), time(i-1), mem(i)) * step^2;
    end
end

%% plot membrane at different points in time
figure(3)
subplot(2, 2, 1)
plot(mem, mesh_mem_time(1, :))
subplot(2, 2, 2)
plot(mem, mesh_mem_time(round(length(time)/3), :))
subplot(2, 2, 3)
plot(mem, mesh_mem_time(round(length(time)*2/3), :))
subplot(2, 2, 4)
plot(mem, mesh_mem_time(round(length(time)), :))
xlim([0, L])

%% plot results for full time
figure(4)
[X, Y] = meshgrid(mem, time);
h = surf(X, Y, real(mesh_mem_time));
set(h,'LineStyle','none')
c = colorbar
c.Label.String = "Displacement"
xlabel('spatial x')
ylabel('time (steps)')
zlabel('Displacement')
title('Change in height of a membrane in 1D over time')
