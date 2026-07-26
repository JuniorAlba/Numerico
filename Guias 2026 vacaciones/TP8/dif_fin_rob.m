function [x,y]=dif_fin_rob(f,inter,ycd,rob,L)
% function [x,y]=dif_fin_rob(f,[a b],alpha,[A B C],L)
%
% OBJETIVO:
% Resuelve un problema de valores de contorno lineal 
% utilizando el método de diferencias finitas en 1D.
% Condición Dirichlet izquierda: y(a)=alpha.
% Condición Robin derecha: A*y'(b) + B*y(b) = C.
% Ecuación: y'' = p(x)y' + q(x)y + r(x) en [a,b]
%
% ENTRADA:
% f: función que devuelve un vector columna con las funciones p(x), q(x), r(x) evaluadas en x.
% inter: vector con los extremos del intervalo [a b].
% ycd: valor de la condición de Dirichlet en x=a (alpha).
% rob: vector con las constantes [A B C] de la condición de Robin en x=b.
% L: cantidad de subintervalos en los que se divide [a b].
%
% SALIDA:
% x: vector con los puntos del dominio discretizado.
% y: vector con la solución aproximada en cada punto de x.

p=@(x) f(x)(:,1);
q=@(x) f(x)(:,2);
r=@(x) f(x)(:,3);

# division del intervalo
x=linspace(inter(1),inter(2),L+1)';
h=(inter(2)-inter(1))/L;

# construccion de la matriz
col=[-1-h/2*p(x(3:end)) 2+h^2*q(x(2:end-1)) -1+h/2*p(x(1:end-2))];
col=[col;0 2+h^2*q(x(end)) -1+h/2*p(x(end-1))];
A = spdiags(col, [-1 0 1], L+1, L+1);
A(end-1,end)=-1+h/2*p(x(end));
A(end,end-2:end)=[-rob(1) 2*h*rob(2) rob(1)];

# construccion del vector de terminos idependientes
b = -h^2*r(x(2:end));
b(1)+=(1+h/2*p(x(2)))*ycd;
b(end+1)=2*h*rob(3);

# resolucion del sistema
ys=A\b;

# solucion con las condiciones de contorno
y=[ycd;ys(1:end-1)];
