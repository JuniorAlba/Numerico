addpath('../../../TP4');
addpath('../../../TP3');
addpath('../../../TP2');
format long;
f = @(x) log(x.^2+1) - exp(x/2).*cos(pi*x)-1.106;

%ITEM A

x = linspace(-6,6,100);
hold on;
plot(x,f(x))
plot([-6 6],[0 0])
%queda en duda si en [-2.5 -1.5] hay una raiz o no entonces
# x1 = linspace(-2.5,-1.5,200)
# indice = 1;
# for i = 1:1:199
#     if f(x1(i))*f(x1(i+1))<0
#         indice = i;
#     endif
# endfor
# indice
%se ven 7 raices

%ITEM B
%Los enteros mas cercanos a la raiz x=-1 es -1 y 0
tol = 1e-7;
itmax = 1000;
[x,h,it]=biseccion(f,-1,0,itmax,tol);
it
x

%resultados (CON ERROR ABSOLUTO)
%x=-0.8378265
%it = 24

%ITEM C
%por ser una raiz simple el orden de convergencia es cuadratico para newton 
%independiendepende del punto inicial
df = @(x) (2*x./(x.^2+1)) - ((1/2)*exp(x/2).*cos(pi*x) - pi*exp(x/2).*sin(pi*x));
tol = 1e-10;
p1 = 3;
p2 = 3.05;
p3 = 3.1;
itmax = 100;
[x1,h1,it1]=newton(f,df,p1,itmax,tol);
[x2,h2,it2]=newton(f,df,p2,itmax,tol);
[x3,h3,it3]=newton(f,df,p3,itmax,tol);
x1
x2
x3

%resultados (CON ERROR relativo)
%x1 = 0.6746660955
%x2 = -0.8378265061
%x3 = 6.466670670


%ITEM D
%la derivada en x=1 es mayor a 1 por lo que no converge
df(1)

%entonces transformamos el problema en la busqueda de una raiz
f2 = @(x) f(x) - x;
df2 = @(x) df(x) - 1;
[x,h,it] = newton(f2,df2,1,itmax,5e-7);
x

%resultados (CON ERROR RELATIVO)
%x = 0.8679355