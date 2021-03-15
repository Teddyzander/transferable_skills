%% define variables for state of membrane
P = 4;
D = 2.206;
L=12.5;
h=50;
epsilon = 8.85*10^(-12);
interval = [-L/2:0.01:L/2];

%% define the function for 1/d at peak

w = @(x) ((P*(L/2)^4)/(64*D))*(1-(x.^2)/(L/2)^2).^2;

%% plots of first set of length
def = w(interval)
y = 1./(h - def);

figure(1)
subplot(2, 2, 1)
plot(interval, -def)
grid on
legend('$\frac{1}{d(x)}$','interpreter','latex','FontSize',10);
title('Shape of the membrane at maximum displacement for h=50, L=12.5','interpreter','latex','FontSize',12)
xlabel('spatial $x$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('Displacement w','interpreter','latex','FontSize',12,'FontWeight', 'bold')
xlim([-L/2, L/2])
ylim([-50, 0])

subplot(2,2,2)
plot(interval, epsilon * y)
grid on
legend('$\frac{\epsilon}{d(x)}$','interpreter','latex','FontSize',10);
title('Capacitence for h=50, L=12.5 at maximum displacement','interpreter','latex','FontSize',12)
xlabel('spatial $x$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('Displacement w','interpreter','latex','FontSize',12,'FontWeight', 'bold')
xlim([-L/2, L/2])
ylim([0, 4*10^(-12)])

%% get capacitence
func = @(x)epislon./(h - (((P*(L/2)^4)./(64*D))*(1-(x.^2)/(L/2)^2).^2));
C1 = integral(func, -L/2, L/2);


%% plots of first second set of length
L = 12.8;
% define the function for 1/d at peak
w = @(x) ((P*(L/2)^4)/(64*D))*(1-(x.^2)/(L/2)^2).^2;

def = w(interval)
y = 1./(h - def);

subplot(2, 2, 3)
plot(interval, -def)
grid on
legend('$\frac{1}{d(x)}$','interpreter','latex','FontSize',10);
title('Shape of the membrane at maximum displacement for h=50, L=12.8','interpreter','latex','FontSize',12)
xlabel('spatial $x$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('Displacement w','interpreter','latex','FontSize',12,'FontWeight', 'bold')
xlim([-L/2, L/2])
ylim([-50, 0])

subplot(2,2,4)
plot(interval, epsilon * y)
grid on
legend('$\frac{\epsilon}{d(x)}$','interpreter','latex','FontSize',10);
title('Capacitence for h=50, L=12.8 at maximum displacement','interpreter','latex','FontSize',12)
xlabel('spatial $x$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('Displacement w','interpreter','latex','FontSize',12,'FontWeight', 'bold')
xlim([-L/2, L/2])
ylim([0, 4*10^(-12)])

%% get capacitence
func = @(x)epislon./(h - (((P*(L/2)^4)./(64*D))*(1-(x.^2)/(L/2)^2).^2));
C2 = integral(func, -L/2, L/2);


