% EJERCICIO 3
% El inciso b pide implementar Crank-Nicholson con Newton, y el inciso c Euler Hacia Atrás.
% Estas funciones ya han sido implementadas por la cátedra en la carpeta raíz:
% CN_newton.m y back_euler.m
addpath('..');

% Vamos a demostrar su funcionamiento con un PVI de prueba:
% y' = -y,  y(0) = 1, t en [0, 2]
% Solución exacta: y(t) = e^(-t)

f = @(t, y) -y;
dfdy = @(t, y) -1 + 0*t*y;

a = 0; b = 2; y0 = 1;
N = 10; % 10 pasos

[t_cn, y_cn] = CN_newton(f, dfdy, a, b, y0, N);
[t_be, y_be] = back_euler(f, dfdy, a, b, y0, N);

y_exacta = exp(-t_cn);

fprintf('=== EJERCICIO 3: CRANK-NICHOLSON Y BACKWARD EULER ===\n');
fprintf('Se prueban las funciones CN_newton y back_euler con PVI y''=-y.\n\n');
fprintf('  t   |   Exacta   | CN_newton  | Error CN   | back_euler | Error BE \n');
fprintf('---------------------------------------------------------------------\n');
for i=1:length(t_cn)
    fprintf(' %.1f  | %.6f   | %.6f   | %.4e | %.6f   | %.4e\n', ...
        t_cn(i), y_exacta(i), y_cn(i), abs(y_exacta(i)-y_cn(i)), y_be(i), abs(y_exacta(i)-y_be(i)));
end

fprintf('\n(Ver justificaciones de ecuaciones en comentarios del código)\n');

% RESPUESTA TEÓRICA INCISO A (Crank-Nicholson):
% La ecuación a resolver en cada paso es implícita:
% y_{i+1} = y_i + h/2 * [f(t_i, y_i) + f(t_{i+1}, y_{i+1})]
%
% Como y_{i+1} está dentro de la función f no lineal, se define la función raíz:
% g(y_{i+1}) = y_{i+1} - y_i - h/2 * [f(t_i, y_i) + f(t_{i+1}, y_{i+1})] = 0
%
% Y se aplica Newton-Raphson iterativamente:
% y_{i+1}^{(k+1)} = y_{i+1}^{(k)} - g(y_{i+1}^{(k)}) / g'(y_{i+1}^{(k)})
% donde g'(y_{i+1}) = 1 - h/2 * df/dy(t_{i+1}, y_{i+1})
%
% RESPUESTA TEÓRICA INCISO C (Backward Euler):
% La ecuación a resolver en cada paso de Euler hacia atrás es:
% y_{i+1} = y_i + h * f(t_{i+1}, y_{i+1})
%
% Su función raíz es:
% g(y_{i+1}) = y_{i+1} - y_i - h * f(t_{i+1}, y_{i+1}) = 0
%
% Y Newton-Raphson iterativo queda:
% y_{i+1}^{(k+1)} = y_{i+1}^{(k)} - g(y_{i+1}^{(k)}) / g'(y_{i+1}^{(k)})
% donde g'(y_{i+1}) = 1 - h * df/dy(t_{i+1}, y_{i+1})
