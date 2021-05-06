%% define variables for state of membrane
P = 4;
D = 2.206;
L=[3:0.001:12.98];
h=50;
epsilon = 8.85*10^(-12);
C = zeros(1, length(L));

%% get capacitence
for i=1:length(L)
    func = @(x)epsilon./(h - (((P*(L(i)/2)^4)./(64*D))*(1-(x.^2)/(L(i)/2)^2).^2));
    C(i) = integral(func, -L(i)/2, L(i)/2);
end

%% plots
subplot(2, 1, 1)
plot(L, C, 'r')
grid on
legend('Capacitence','interpreter','latex','FontSize',10, 'Location', 'northeast');
title('Capacitence for h=50, $L\in[12,13]$ at maximum displacement','interpreter','latex','FontSize',12)
xlabel('$L$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('$C$','interpreter','latex','FontSize',12,'FontWeight', 'bold')

subplot(2, 1, 2)
loglog(L, C, 'r')
grid on
legend('Capacitence','interpreter','latex','FontSize',10, 'Location', 'northeast');
title('Log of Capacitence for h=50, $L\in[12,13]$ at maximum displacement','interpreter','latex','FontSize',12)
xlabel('$L$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('$C$','interpreter','latex','FontSize',12,'FontWeight', 'bold')

figure(2)
loglog(L, C, 'r')
grid on
legend('Capacitence','interpreter','latex','FontSize',10, 'Location', 'northeast');
title('Log of Capacitence for h=50, $L\in[12,13]$ at maximum displacement','interpreter','latex','FontSize',12)
xlabel('$L$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('$C$','interpreter','latex','FontSize',12,'FontWeight', 'bold')