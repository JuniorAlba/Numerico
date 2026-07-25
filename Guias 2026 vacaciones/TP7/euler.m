function [t,y] = euler(f,inter,y0,L)
% function [t,y] = euler(f,inter,y0,L)
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
%   Aproximar la solución del PVI utilizando el Método de Euler Hacia Adelante (Explícito),
%   que aproxima la derivada mediante truncamiento de Taylor a primer orden: O(h).

t = linspace(inter(1),inter(2),L+1)'; 
h = (inter(2)-inter(1))/L;

% reservamos lugar en memoria para y
y = zeros( length(y0), L+1 );

y(:,1) = y0;
for n = 1:L
    y(:,n+1) = y(:,n) + h*f(t(n),y(:,n));
end

y = y';
