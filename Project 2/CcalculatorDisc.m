P0 = 4;
D = 2.206;
freq = 100;
L=100;
h=((L/2)^4)/(16*D)+50;
epsilon = 8.85*10^(-12);
wpeak = (P0*(L/2)^4)/(64*D);
P = @(t) (P0+(0.0005-(rand(1,1)*0.001)))*exp(1i*(freq)*t);
w = @(t) (P(t)*(L/2)^2)/(64*D);
C = @(t, p) (epsilon*pi*(L/2)^2*atanh(sqrt(w(t)/h)))/sqrt(h*w(t));
time = [0:0.00001:1];
cap = zeros(1, length(time));

for i=1:length(time)
    cap(i) = C(time(i));
end

plot(time, real(cap))