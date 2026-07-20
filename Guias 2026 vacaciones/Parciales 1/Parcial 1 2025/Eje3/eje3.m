addpath('../../../TP4');
addpath('../../../TP3');
addpath('../../../TP2');
format long;
f1 = 440;
f2 = 660;
f3 = 1100;
f4 = 5;
f5 = 8;
s = [2.1004; 4.3702; 5.1745; -0.7222; 0.9249];
t = [0:0.0025:0.01]';
M = [sin(2*pi*f1*t) sin(2*pi*f2*t) sin(2*pi*f3*t) cos(2*pi*f4*t) sin(2*pi*f5*t)];

%ITEM A
[A,r] = gauss_p(M,s);
A

%ITEM B
M_permutada = M(r,:);
s_permutada = s(r,:);
tol = 1e-4;
A0 = zeros(5,1);
itmax = 1000;
w = wOptimo2(M_permutada, s_permutada, A0, tol, itmax,2)
[x,it,h] = SOR(M_permutada, s_permutada, A0, itmax, tol, w);
x
it

%resultados (error absoluto)
%w = 0.60 (2cifras)
%it = 24