p_0 = 1;
omega = 4;

p = @(t) p_0*exp(1i * omega .* t);

time = [0:0.01:2*pi];

waves = p(time);

plot(time, waves)