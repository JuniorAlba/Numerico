addpath('..');
fprintf('\n=== EJERCICIO 11: MÉTODOS PREDICTOR-CORRECTOR (SISTEMA) ===\n');

% EDO: t^2 y'' - 2ty' + 2y = t^3 ln(t)
% y'' = t ln(t) + (2/t) y' - (2/t^2) y
%
% Sistema: x(1) = y, x(2) = y'
% x1' = x2
% x2' = t*log(t) + (2/t)*x(2) - (2/t^2)*x(1)

f = @(t,x) [x(2) ; t*log(t) + (2/t)*x(2) - (2/t^2)*x(1)];

a = 1; b = 2;
x0 = [1; 0]; % y(1)=1, y'(1)=0

y_exacta = @(t) (7/4).*t + (1/2).*t.^3 .* log(t) - (3/4).*t.^3;
dy_exacta = @(t) (7/4) + (3/2).*t.^2 .* log(t) + (1/2).*t.^2 - (9/4).*t.^2;

H_vals = [0.2, 0.1, 0.05];

fprintf('   h    | Error Max y (x1) | Error Max y'' (x2)\n');
fprintf('-----------------------------------------------\n');

for i=1:length(H_vals)
    h = H_vals(i);
    N = round((b-a)/h);
    
    % Aplicamos el Predictor-Corrector de Adams a TODO el sistema
    [t, x] = PredictorCorrectorAdams(f, a, b, x0, N);
    
    y_real = y_exacta(t);
    dy_real = dy_exacta(t);
    
    err_max_y = max(abs(x(:,1) - y_real));
    err_max_dy = max(abs(x(:,2) - dy_real));
    
    fprintf(' %.2f  |    %.4e    |    %.4e\n', h, err_max_y, err_max_dy);
end

fprintf('\nCONCLUSIONES:\n');
fprintf('- Como se trata de un Predictor-Corrector de Adams de 4to orden,\n');
fprintf('  el error disminuye en un factor cercano a 16 cada vez que el paso h se reduce a la mitad.\n');
fprintf('- La solución numérica resuelve satisfactoriamente el sistema transformado.\n');
