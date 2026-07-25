function [t,y]=rk4(f, inter, y0, L)
% function [t,y] = rk4(f, inter, y0, L)
%
% ENTRADAS:
%   f     - Función que define la EDO: y' = f(t,y). Debe aceptar t e y.
%   inter - Vector con el intervalo de integración [t0, tf].
%   y0    - Condición inicial (puede ser escalar o vector).
%   L     - Cantidad de pasos (subintervalos) a utilizar.
%
% SALIDAS:
%   t     - Vector columna con los tiempos t_i evaluados.
%   y     - Matriz donde cada fila es la solución y(t_i).
%
% OBJETIVO:
%   Aproximar la solución del PVI utilizando el Método Clásico de Runge-Kutta de orden 4.
%   Es uno de los métodos de un paso más robustos y populares. Orden empírico O(h^4).

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
