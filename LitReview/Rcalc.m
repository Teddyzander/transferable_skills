%% Preallocate vectors for population changes
steps = 150; % Number of time steps
time = [1:1:steps]; % Time steps
pop_size = 10000;
n = length(time);

%% Variables
gamma = 0.5; % Recovery rate
betas = [0.45, 0.6, 0.7, 0.8, 0.9, 1]; % Contacts per person


%% Run similation
for i=1:length(betas)
    beta=betas(i);
    S = zeros(1, n); % Susceptible population changes
    I = zeros(1, n); % Infected population changes
    R = zeros(1, n); % Recovered population changes
    S(1) = 9999; %  Initial susceptible population
    I(1)= 1; % Initial infected population
    R(1) = 0; % Initial recovered population
    % Convert to proportion of population (closed system)
    S(1) = S(1)/pop_size;
    I(1) = I(1)/pop_size;
    R(1) = R(1)/pop_size;
    for t=2:n
        % Calculate changes in populations
        dS = -beta*I(t-1)*S(t-1);
        dR = gamma*I(t-1);
        dI = -dS - dR;
    
        % Apply changes
        S(t) = S(t-1) + dS;
        I(t) = I(t-1) + dI;
        R(t) = R(t-1) + dR;
    end
    %% plot data
    figure(2)
    plot(time, I)
    hold on
end


%% Beautify plot
figure(2)
title('The Effect of the Basic Reproduction Number')
ylabel('Infected Population $I(t)$', 'interpreter','latex')
xlabel('time $t$', 'interpreter','latex')
legend('$R_0 < 1$', '$R_0 =  1.2$', '$R_0 = 1.4$', '$R_0 = 1.6$', 'interpreter','latex')