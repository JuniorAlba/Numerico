function [x, w] = AdamsBashford_Ord4(f, x0, xn, y0, N)
% function [x, w] = AdamsBashford_Ord4(f, x0, xn, y0, N)
%
% ENTRADAS:
%   f     - Función de la EDO: y' = f(x,y).
%   x0,xn - Intervalo de integración [x0, xn].
%   y0    - Condición inicial.
%   N     - Cantidad de subintervalos.
%
% SALIDAS:
%   x     - Vector de abcisas.
%   w     - Vector con la solución aproximada.
%
% OBJETIVO:
%   Método multipaso explícito de Adams-Bashforth de 4to orden.
%   Nota: Para mantener el orden O(h^4) global, los primeros 3 pasos 
%   se deben inicializar con un método de un paso del mismo orden (Runge-Kutta 4).
h = (xn-x0)/N;
x = [x0:h:xn];
w = zeros(1,N+1);
w(1) = y0;

% Inicialización correcta con RK4 para los primeros 3 pasos (para tener w(1) a w(4))
for i = 1:3
    k1 = h*f(x(i), w(i));
    k2 = h*f(x(i)+h/2, w(i)+k1/2);
    k3 = h*f(x(i)+h/2, w(i)+k2/2);
    k4 = h*f(x(i)+h, w(i)+k3);
    w(i+1) = w(i) + (k1+2*k2+2*k3+k4)/6;
endfor
for i=4:N
f0 = f(x(i),w(i));
f1 = f(x(i-1),w(i-1));
f2 = f(x(i-2),w(i-2));
f3 = f(x(i-3),w(i-3));
  w(i+1) = w(i) + h/24*(55*f0 - 59*f1 + 37*f2 - 9*f3);
endfor
endfunction