format long;
c1 = 1100;
c2 = 900;
d1 = @(x) 25 + x.^2;
d2 = @(x) 25 + (30 - x).^2;
It = @(x) c1./d1(x) + c2./d2(x) ;
f = @(x) It(x)-10;
figure(1)
hold on;
plot([0 30], [0 0])
xx = linspace(0,30,100);
plot(xx,f(xx));
%se obsevan que hay n raices entre [0,30];
%la primer raiz esta entre [5 15]
%la segunda raiz esta entre [15 25]
a1 = 5;
b1 = 15;
a2 = 15;
b2 = 25;
tol = 0.5e-6;
%Verificar que biseccion trabaje bajo el error absoluto y no relativo
[p1,h1,it1] = Biseccion(f,a1,b1,10000,tol);
p1
f(p1)
%resultado con 6 decimales correctos: 10.855080
%tiene 8 ciftas significativas


[p2,h2,it2] = Biseccion(f,a2,b2,10000,tol);
p2
f(p2)
%resultado con 6 decimales correctos: 20.224989
%tiene 8 cifras significativas


%respuestas correctas:
%p1 = 10.855080     8 cifras sig
%p2 = 20.224990     8 cifras sig

