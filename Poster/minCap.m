D=2.2;
L=10;
h=5;
P = 4;
eps = 8.85e-12
w = @(x) (P*(L/2).^4)/(64*D)*(1-(x.^2)/(L/2).^2).^2;
d1 = @(x) h - w(x);
d2 = @(x) h + w(x);

func = @(x) eps*(1./d1(x)-1./d2(x));
integral(func, -L/2, L/2)