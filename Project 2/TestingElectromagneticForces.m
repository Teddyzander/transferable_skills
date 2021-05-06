%% calculate an estimate for elastic characteristic

r = @(L) sqrt((8.988*10^9*16)/(6.29*10^(-4)+4/L^2));

r(10)