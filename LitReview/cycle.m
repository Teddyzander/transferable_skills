%% Preallocate vectors for population changes
n = 500; % Number of time steps
time = [1:1:n]; % Time steps
S = zeros(1, n); % Susceptible population changes
I = zeros(1, n); % Infected population changes
R = zeros(1, n); % Recovered population changes
dS = zeros(1, n); % Susceptible population changes
dI = zeros(1, n); % Infected population changes
dR = zeros(1, n); % Recovered population changes


%% Variables
beta = 0.3; % Contacts per person
gamma = 0.1; % Recovery rate
mu = 0.01; % A natural birth and death rate (births = deaths)
nu=0.05;
N=10000; %population size
Sic = [2000:750:9500]; % initial conditions for S population

% simulate many different initial conditions to show equilibrium
for i =1:length(Sic)
    S(1) = Sic(i); %  Initial susceptible population
    I(1)= N-Sic(i); % Initial infected population
    R(1) = 0; % Initial recovered population
    % Convert to proportion of population (closed system)
    S(1) = S(1)/N;
    I(1) = I(1)/N;
    R(1) = R(1)/N;

    %% Run similation
    for t=2:n
    % Calculate changes in populations
       dS(t-1) = -beta*I(t-1)*S(t-1) + mu - mu*S(t-1) + R(t-1)*nu;
      dI(t-1) = beta*I(t-1)*S(t-1) - (gamma + mu)*I(t-1);
       dR(t-1) = gamma*I(t-1) - mu*R(t-1) - R(t-1)*nu;
    
       % Apply changes
        S(t) = S(t-1) + dS(t-1);
       I(t) = I(t-1) + dI(t-1);
       R(t) = R(t-1) + dR(t-1);
    end

    %% plot data
    figure(1)
    subplot(1, 2, 2)
    hold on
    plot(S,I)
end


%% Beautify plot
figure(1)
subplot(1, 2, 1)
hold on
plot(time, S, '-b')
hold on
plot(time, I, '-r')
plot(time, R, '-g')
title('Example of an endemic using a SIR model')
ylabel('Proportion of population $\frac{x}{N}$', 'interpreter','latex')
xlabel('time $t$', 'interpreter','latex')
legend('$S$','$I$','$R$', 'interpreter','latex')
xlim([0,500])

figure(1)
subplot(1, 2, 2)
plot([0:0.01:1], flip([0:0.01:1]), '--k')
xlim([0, 1])
ylim([0,1])
title('Steady State for Different Inital Conditions')
ylabel('Infected poulation $I(t)$', 'interpreter','latex')
xlabel('Susceptible Population $S(t)$', 'interpreter','latex')