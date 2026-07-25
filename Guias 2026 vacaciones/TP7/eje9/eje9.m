addpath('..');
fprintf('=== EJERCICIO 9: SISTEMA DE ORDEN SUPERIOR ===\n');

% EDO 3er orden: y''' + 4y'' + 5y' + 2y = -4sin(t) - 2cos(t)
% Variables: x(1) = y, x(2) = y', x(3) = y''
f = @(t,x) [x(2) ; x(3) ; -4*sin(t)-2*cos(t)-4*x(3)-5*x(2)-2*x(1)];
x0 = [1; 0; -1];
inter = [0 2.5];

tol = 0.5e-6; % Criterio para 6 cifras decimales exactas

% --- INCISO B: Búsqueda del L necesario ---
fprintf('Buscando L iterativamente (sin usar solucion analitica) para alcanzar tol = %g...\n', tol);
L = 10;
err_estimado = inf;

% Primera aproximación base
[t_rk, x_rk] = rk4(f, inter, x0, L);
aprox_vieja = x_rk(end, 1);

while (err_estimado >= tol && L <= 5000)
    L = L * 2; % Reducimos el paso a la mitad
    [t_rk, x_rk] = rk4(f, inter, x0, L);
    aprox_nueva = x_rk(end, 1);
    
    % Estimamos el error absoluto comparando con la iteración anterior
    % (Criterio de parada por diferencia)
    err_estimado = abs(aprox_nueva - aprox_vieja);
    
    aprox_vieja = aprox_nueva;
endwhile

fprintf('L necesario: %d (h = %.4f)\n', L, (inter(2)-inter(1))/L);
fprintf('Aproximación de y(2.5): %.8f\n', aprox_nueva);
fprintf('Error absoluto est.:    %.2e\n', err_estimado);

% --- INCISO C: ¿Cuántas veces se anula y'(t) en [0, 15]? ---
fprintf('\n--- INCISO C ---\n');
inter_c = [0 15];
L_c = 300; % h = 0.05
[t_c, x_c] = rk4(f, inter_c, x0, L_c);

% Buscamos cruces por cero en x_c(:,2) que es y'(t)
y_prima = x_c(:,2);
cruces = 0;
for i = 1:length(y_prima)-1
    if (y_prima(i) == 0)
        cruces = cruces + 1;
    elseif (y_prima(i) * y_prima(i+1) < 0)
        cruces = cruces + 1;
    end
endfor
% Revisar el último punto por si cae exactamente en cero
if (y_prima(end) == 0)
    cruces = cruces + 1;
end

fprintf('La función y''(t) se anula %d veces en el intervalo [0, 15].\n', cruces);

figure(1); clf;
plot(t_c, x_c(:,1), 'b-', 'LineWidth', 2); hold on;
plot(t_c, x_c(:,2), 'r--', 'LineWidth', 1.5);
plot([0 15], [0 0], 'k:'); % Eje horizontal
title('Evolución de y(t) y su derivada y''(t)');
xlabel('Tiempo (t)');
ylabel('Amplitud');
legend('y(t)', 'y''(t)');
grid on;