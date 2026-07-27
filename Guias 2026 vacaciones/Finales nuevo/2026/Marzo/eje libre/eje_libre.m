addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;

dA = @(x) sqrt(25 + x.^2);
dB = @(x) sqrt(25 + (30-x).^2);
Ca = 1100;
Cb = 900;
Ia = @(x) Ca./((dA(x)).^2);
Ib = @(x) Cb./((dB(x)).^2);
I = @(x) Ia(x) + Ib(x) - 10;

x = linspace(0,30,100);
plot(x,I(x));
tol = 0.5e-6;
[x,h,it]=biseccion(I,0,15,10000,tol);
x
I(x)
[x,h,it]=biseccion(I,15,30,10000,tol);
x
I(x)

%Resultados:
%raiz1: 10.855081
%cifras_significativas: 8
%raiz2: 20.224990
%cifras_significativas: 8