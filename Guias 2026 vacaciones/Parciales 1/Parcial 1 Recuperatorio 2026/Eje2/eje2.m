addpath('../../../TP4');
addpath('../../../TP3');
addpath('../../../TP2');
format long;

%Iluminancia del nodo A
c1 = 1100;
Ia = @(x) c1./(25 + x.^2);

%Iluminancia del nodo B
c2 = 900;
Ib = @(x) c2./(25 + (30-x).^2);

%Iluminancia total
It = @(x) Ia(x) + Ib(x);
f = @(x) It(x) - 10;

x = linspace(0,30,1000);
plot(x,f(x));
%hay 2 raices, 1 en: [0,15]
%2 en: [15,30]

tol = 5e-5;
kmax = 1000;
[r1, err1, it1] = biseccion(f,0,15,kmax,tol);
[r2, err2, it2] = biseccion(f,15,30,kmax,tol);
r1
r2

%resultados (con error absoluto)
%r1 = 10.855093
%r2 = 20.225000
%Ambos resultados tiene 2 cifras antes de la coma
%por lo tanto tienen 8 cifras significativas