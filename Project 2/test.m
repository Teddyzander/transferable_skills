L=12.8;
h=50;
Pres = [4.2:0.001:4.25];
D=2.227;
eps = 10e-12;

disp=zeros(1,length(Pres));
cap=zeros(1,length(Pres));

for n=1:length(Pres)
    P=Pres(n);
    dist = @(x) (h - ((P*(L/2).^4)./(64*D))*(1-(x.^2)/(L/2).^2).^2);
    func = @(x) eps./(h - ((P*(L/2).^4)./(64*D))*(1-(x.^2)/(L/2).^2).^2);
    disp(n) = dist(0);
    cap(n)=integral(func, -L/2, L/2);
end

%%
loglog(disp, cap, '-r')
grid on
legend('Capacitence','interpreter','latex','FontSize',10, 'Location', 'northeast');
title('Loglog of Capacitance Growth as $d(0)\to 0$', 'interpreter', 'latex','FontSize',12)
xlabel('$d(0)$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
ylabel('$C$','interpreter','latex','FontSize',12,'FontWeight', 'bold')
hold on
loglog(disp, (disp).^-0.5, '-b')

%%
P=4;
dist = @(x) (h - ((P*(L/2).^4)./(64*D))*(1-(x.^2)/(L/2).^2).^2);
func = @(x) eps./(h - ((P*(L/2).^4)./(64*D))*(1-(x.^2)/(L/2).^2).^2);
dist(0);