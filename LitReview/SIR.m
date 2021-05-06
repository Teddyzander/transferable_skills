%% Preallocate vectors for population changes
n = 100; % Number of time steps
time = [1:1:n]; % Time steps
S = zeros(1, n); % Susceptible population changes
I = zeros(1, n); % Infected population changes
R = zeros(1, n); % Recovered population changes

%% Variables
beta = 0.4; % Contacts per person
gamma = 0.09; % Recovery rate
S(1) = 9999; %  Initial susceptible population
I(1)= 1; % Initial infected population
R(1) = 0; % Initial recovered population
N = S(1)+I(1)+R(1); % Population size
% Convert to proportion of population (closed system)
S(1) = S(1)/N;
I(1) = I(1)/N;
R(1) = R(1)/N;

%% Run similation
for t=2:100
    % Calculate changes in populations
    dS = -beta*I(t-1)*S(t-1)
    dR = gamma*I(t-1);
    dI = -dS - dR;
    
    % Apply changes
    S(t) = S(t-1) + dS;
    I(t) = I(t-1) + dI;
    R(t) = R(t-1) + dR;
    
    
end

%% plot data
plot(time, S, '-b')
hold on
plot(time, I, '-r')
plot(time, R, '-g')

%% Beautify plot
title('Shape of an epidemic using a SIR model')
ylabel('Proportion of population $\frac{x}{N}$', 'interpreter','latex')
xlabel('time $t$', 'interpreter','latex')
legend('$S$','$I$','$R$', 'interpreter','latex')