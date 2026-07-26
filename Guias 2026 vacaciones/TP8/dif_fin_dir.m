function [x,y,it]=dif_fin_dir(f,inter,yc,L)
% function [x,y,it]=dif_fin_dir(f,[a b],[alpha,beta],L)
%
% OBJETIVO:
% Resuelve un problema de valores de contorno lineal 
% de la forma: y'' = p(x)y' + q(x)y + r(x)
% utilizando el método de diferencias finitas en 1D.
% Condiciones de contorno de Dirichlet: y(a)=alpha, y(b)=beta.
%
% ENTRADA:
% f: función que devuelve un vector columna con las funciones p(x), q(x), r(x) evaluadas en x.
% inter: vector con los extremos del intervalo [a b].
% yc: vector con los valores de contorno [alpha, beta].
% L: cantidad de subintervalos en los que se divide [a b].
%
% SALIDA:
% x: vector columna con los puntos del dominio discretizado.
% y: vector columna con la solución aproximada en cada punto de x.
% it: devuelve 0 (en este método directo no hay iteraciones, se mantiene por compatibilidad).

p=@(x) f(x)(:,1);
q=@(x) f(x)(:,2);
r=@(x) f(x)(:,3);

# division del intervalo
x=linspace(inter(1),inter(2),L+1)';
h=(inter(2)-inter(1))/L;

# construccion de la matriz tridiagonal
col=[-1-h/2*p(x(3:end)) 2+h^2*q(x(2:end-1)) -1+h/2*p(x(1:end-2))];
A = spdiags(col, [-1 0 1], L-1, L-1);

# construccion del vector de terminos independientes
b = -h^2*r(x(2:end-1));
b(1)+=(1+h/2*p(x(2)))*yc(1);
b(end)+=(1-h/2*p(x(end-1)))*yc(2);

# resolucion del sistema
ys=A\b;
it=0;

# solucion con las condiciones de contorno
y=[yc(1);ys;yc(2)];