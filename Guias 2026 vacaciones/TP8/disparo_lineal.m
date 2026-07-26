function [x,y]=disparo_lineal(f,inter,yc,L)
% function [x,y]=disparo_lineal(f,[a b],[alpha,beta],L)
%
% OBJETIVO:
% Resuelve un problema de valores de contorno lineal 
% de la forma: y'' = p(x)y' + q(x)y + r(x)
% utilizando el método del disparo lineal con Runge-Kutta de orden 4.
% Condiciones de contorno de Dirichlet: y(a)=alpha, y(b)=beta.
%
% ENTRADA:
% f: función que devuelve un vector columna con p(x), q(x), r(x) evaluadas en x.
% inter: vector con los extremos del intervalo [a b].
% yc: vector con los valores de contorno [alpha, beta].
% L: cantidad de subintervalos en los que se divide [a b].
%
% SALIDA:
% x: vector con los puntos del dominio discretizado.
% y: vector con la solución aproximada en cada punto de x.
  
p=@(x) f(x)(:,1);
q=@(x) f(x)(:,2);
r=@(x) f(x)(:,3);

% construye sistema
F=@(x,y) [y(3);
          y(4);
          p(x)*y(3)+q(x)*y(1)+r(x);
          p(x)*y(4)+q(x)*y(2)+r(x)];

% define condiciones iniciales del sistema
% se resuelve combinando 2 problemas de valor inicial
y0=[yc(1);yc(1);0;1];

[x,yd]=rk4(F, inter, y0, L);

% se calcula el parámetro lambda para satisfacer la condición en b
lambda=(yc(2)-yd(end,2))/(yd(end,1)-yd(end,2));

% combinación lineal de las dos soluciones
y=lambda*yd(:,1)+(1-lambda)*yd(:,2);