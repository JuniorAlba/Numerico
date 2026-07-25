function [x, w] = AdamsMoulton_Ord4(f, x0, xn, y0, N)
% function [x, w] = AdamsMoulton_Ord4(f, x0, xn, y0, N)
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
%   Método multipaso implícito de Adams-Moulton de 4to orden.
%   Requiere valores futuros, por lo que típicamente se usa como corrector.
%   Nota: Para mantener el orden O(h^4) global, los primeros 3 pasos 
%   se deben inicializar con un método del mismo orden (Runge-Kutta 4).
%   ESTE SCRIPT ASI COMO ESTA NO ESTA RESOLVIENDO LA ECUACION NO LINEAL. 
%   Usa el valor futuro w(i+1) en la linea 32, asumiendo que ya se calculó 
%   con un predictor. Se provee a modo demostrativo de la formula.
h = (xn-x0)/N;
x = [x0:h:xn];
w = zeros(1,N+1);
w(1) = y0;

% Inicialización con RK4
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
fm1 = f(x(i+1),w(i+1));
w(i+1) = w(i) + h/720*(251*fm1 + 646*f0 - 264*f1 + 106*f2 - 19*f3);
endfor
endfunction