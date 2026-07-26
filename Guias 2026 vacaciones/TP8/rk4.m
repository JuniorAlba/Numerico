function [t,y]=rk4(f, inter, y0, L)
% function [t,y]=rk4(f, [t0 tf], y0, L)
%
% OBJETIVO:
% Resuelve un problema de valor inicial mediante el 
% Método de Runge-Kutta de orden 4.
% Resuelve: y' = f(t,y) en [t0,tf] con y(t0) = y0.
%
% ENTRADA:
% f: función que evalúa y devuelve f(t,y).
% inter: vector con los extremos del intervalo [t0 tf].
% y0: vector columna (o escalar) con los valores iniciales.
% L: cantidad de pasos (subintervalos).
%
% SALIDA:
% t: vector columna de tiempos discretizados.
% y: matriz donde cada fila corresponde a la aproximación en cada paso de tiempo.

t = linspace(inter(1),inter(2),L+1)'; 
h = (inter(2)-inter(1))/L;

% reservamos lugar en memoria para y
y = zeros( length(y0), L+1 );

y(:,1) = y0;

for n=1:L
  k1 = h * f(t(n)  , y(:,n));
  k2 = h * f(t(n)+h/2, y(:,n)+k1/2);
  k3 = h * f(t(n)+h/2, y(:,n)+k2/2);
  k4 = h * f(t(n+1), y(:,n)+k3);

  y(:,n+1) = y(:,n) + (k1+2*k2+2*k3+k4)/6;
end

y=y';
