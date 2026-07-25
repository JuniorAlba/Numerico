addpath('..');
format long;
t0 = 0;
tf = 2;
y0 = 0;

% Definición de funciones
f = @(t,y) -y+sin(t)+cos(t);
sol_exacta = @(t) sin(t);

error_metodos = [];

% Bucle de iteración para distintos pasos h
for i=1:1:6
    L=20*2^(i-1);   % Empieza en L=20 (h=1/10) y va duplicando pasos
    
    % Llamada a los métodos (asumiendo que tienes los archivos euler.m, rk2.m, rk4.m)
    [t_euler,y_euler] = euler(f,[t0 tf],y0,L);
    [t_rk2,y_rk2] = rk2(f,[t0 tf],y0,L);
    [t_rk4,y_rk4] = rk4(f,[t0 tf],y0,L);
    
    % Guardamos la última aproximación (y en t=2)
    error_metodos = [error_metodos ; y_euler(end) y_rk2(end) y_rk4(end)];
endfor

% --- MOSTRAR RESULTADOS ---
fprintf('\n=== EJERCICIO 2: COMPARACIÓN DE MÉTODOS ===\n');
fprintf('Aproximación de y(2):\n');
fprintf('-----------------------------------------------------------------------\n');
fprintf('   L  |      Euler      |       RK2       |       RK4       |   Exacto\n');
fprintf('-----------------------------------------------------------------------\n');
for i=1:6
    L_val = 20*2^(i-1);
    fprintf('%4d  | %.13f | %.13f | %.13f | %.13f\n', L_val, error_metodos(i,1), error_metodos(i,2), error_metodos(i,3), sol_exacta(2));
end
fprintf('-----------------------------------------------------------------------\n');

% --- CÁLCULO DE ERRORES ---
err_abs_euler = abs(error_metodos(:,1) - sol_exacta(2));
err_abs_rk2   = abs(error_metodos(:,2) - sol_exacta(2));
err_abs_rk4   = abs(error_metodos(:,3) - sol_exacta(2));

fprintf('\nERROR ABSOLUTO (|y_aprox - y_exacto|):\n');
fprintf('-----------------------------------------------------------------------\n');
fprintf('   L  |      Euler      |       RK2       |       RK4\n');
fprintf('-----------------------------------------------------------------------\n');
for i=1:6
    L_val = 20*2^(i-1);
    fprintf('%4d  | %.13e | %.13e | %.13e\n', L_val, err_abs_euler(i), err_abs_rk2(i), err_abs_rk4(i));
end
fprintf('-----------------------------------------------------------------------\n');

%3 decimales correctos (Error < 5e-4)
%Euler: No llega con L=640 (Error 1.1e-3). Necesita aprox L=1280 -> 1280 evaluaciones de f.
%Rk2: Lo alcanza en L=80 (Error 1.2e-4). Necesita 80 pasos -> 160 evaluaciones de f. (L=40 da 5.05e-4, casi casi).
%Rk4: Le sobra con L=20 (Error 7.2e-7). Necesita <= 20 pasos -> 80 evaluaciones de f.

%6 decimales correctos (Error < 5e-7)
%Euler: Impráctico. Necesita millones de pasos.
%Rk2: No llega con L=640 (Error 1.9e-6). Al duplicar a L=1280 bajará a 4.8e-7. Necesita aprox L=1280 -> 2560 evaluaciones de f.
%Rk4: Lo alcanza en L=40 (Error 4.4e-8). Necesita 40 pasos -> 160 evaluaciones de f.

%Orden del error
%Euler O(h)
%Rk2 O(h^2)
%Rk4 O(h^4)