function [x, it, r_h] = jacobi(A, b, x0, maxit, tol)
    % Resuelve un sistema Ax=b usando el método iterativo de Jacobi.
    %
    % Entradas:
    %   A: Matriz cuadrada de coeficientes (idealmente diag. dominante).
    %   b: Vector de términos independientes.
    %   x0: Vector de estimación inicial.
    %   maxit: Número máximo de iteraciones.
    %   tol: Tolerancia para el criterio de parada.
    %
    % Salidas:
    %   x: Vector solución aproximado.
    %   it: Número de iteraciones realizadas.
    %   r_h: Vector (historial) de errores en cada iteración.

    % --- Configuración Interna "Todo Terreno" ---
    medir_tiempo = false;         % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;          % 0: Silencioso, 1: Resumen final, 2: Detallado (cada iteración)
    opcion_warnings = false;      % true: Muestra advertencia si no converge

    % 1: Error Relativo (Inf) | norm(x-x0,'inf')/norm(x,'inf')
    % 2: Error Absoluto (Inf) | norm(x-x0,'inf')
    % 3: Residuo (Euclidiana) | norm(A*x-b)
    % 4: Residuo (Infinito)   | norm(A*x-b,'inf')
    opcion_error = 1;

    % Opciones de Gráficos
    graficar_convergencia = false;  % true: grafica el historial de error al finalizar
    opcion_grafico_escala = 'log';   % 'log' (semilogy) o 'normal' (plot)
                                     % (Se recomienda 'log' para convergencia)
    opcion_grafico_estilo = '-ob'; % Estilo de línea (ej. '-ob', '--xr', ':k')
    opcion_grafico_pausa = false;  % true: ejecuta 'pause' después de graficar

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = length(b);
    it = 0;
    r_h = [];
    x = zeros(n, 1); % Vector 'nuevo' (para evitar problemas de dimension)

    while (it < maxit)

        % Bucle de Jacobi: x(i) se calcula usando *solo* el vector 'x0' (el anterior)
        for i = 1:n
            x(i) = (b(i) - A(i, 1:i-1) * x0(1:i-1) - A(i, i+1:n) * x0(i+1:n)) / A(i, i);
        endfor

        % Cálculo de error según la opción
        switch (opcion_error)
            case 1 % Relativo (Inf)
                err = norm(x - x0, 'inf') / (norm(x, 'inf') + eps); % (eps evita div por cero)
            case 2 % Absoluto (Inf)
                err = norm(x - x0, 'inf');
            case 3 % Residuo (Euclidiana)
                err = norm(A*x - b);
            case 4 % Residuo (Infinito)
                err = norm(A*x - b, 'inf');
            otherwise
                error("Opción de error no válida.");
        endswitch

        it = it + 1;
        r_h(it) = err;

        % Reporte detallado (por iteración)
        if (opcion_verbose == 2)
            printf("  Iter: %4d | Error (Tipo %d): %e\n", it, opcion_error, err);
        endif

        % Criterio de parada
        if (err < tol)
            break;
        endif

        x0 = x; % El nuevo vector es ahora el viejo para la sig. iteración
    endwhile

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    % Advertencia de no convergencia
    if (opcion_warnings && it == maxit && err >= tol)
        printf("ADVERTENCIA (Jacobi): El método no convergió en %d iteraciones.\n", maxit);
        printf("  Error final: %e (Tolerancia: %e)\n", err, tol);
    endif

    % Resumen final
    if (opcion_verbose >= 1)
        printf("--- Resumen Jacobi ---\n");
        printf("Iteraciones: %d / %d\n", it, maxit);
        printf("Error final: %e (Tipo %d)\n", err, opcion_error);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("----------------------\n");
    endif

    % --- Gráficos ---
    if (graficar_convergencia && !isempty(r_h))
        figure;
        if (strcmp(opcion_grafico_escala, 'log'))
            semilogy(1:length(r_h), r_h, opcion_grafico_estilo);
        else
            plot(1:length(r_h), r_h, opcion_grafico_estilo);
        endif
        grid on;
        title("Jacobi: Convergencia del Error");
        xlabel("Iteración");
        ylabel(sprintf("Error (Tipo %d)", opcion_error));
        if (opcion_grafico_pausa)
            disp("Presione Enter para continuar...");
            pause;
        endif
    endif

endfunction

% --- Ejemplo 1: Caso convergente (Diag. Dominante) (Seleccionar y presionar F9) ---
% A = [4, -1, 0; -1, 4, -1; 0 -1, 4];
% b = [3; 2; 3];
% x0 = [0; 0; 0];
% maxit = 100;
% tol = 1e-8;
%
% [x_j, it_j, r_j] = jacobi(A, b, x0, maxit, tol);
% disp("Solución (Ejemplo 1):")
% disp(x_j)

% --- Resultado Esperado (Ejemplo 1) ---
% (Este estaba bien y es el correcto)
% --- Resumen Jacobi ---
% Iteraciones: 19 / 100
% Error final: 5.587935e-09 (Tipo 1)
% Tiempo: ... s
% ----------------------
% Solución (Ejemplo 1):
%    1.0000
%    1.0000
%    1.0000
% (Abre una gráfica)

% --- Ejemplo 2: Caso de Prueba - Parcial 1 (2025) (Seleccionar y presionar F9) ---
% % Matriz del Ej. 2, Evaluación Parcial 1 (2025)
% A = [2 0 1 0 -2; 1 1 1 1 -1; -2 2 2 -2 1; -1 0 1 2 2; -1 2 2 -1 2];
% b = [4; 0; 1; 3; -1];
% x0 = [0; 0; 0; 0; 0];
% maxit = 100; % El parcial pedía 50, pero 100 está bien para probar
% tol = 1e-4;  % Tolerancia del parcial
%
% [x_j2, it_j2, r_j2] = jacobi(A, b, x0, maxit, tol);
% disp("Solución (Ejemplo 2):")
% disp(x_j2)

% --- Resultado Esperado (Ejemplo 2) ---
% --- Resumen Jacobi ---
% Iteraciones: 51 / 100
% Error final: 7.856604e-05 (Tipo 1)
% Tiempo: ... s
% ----------------------
% Solución (Ejemplo 2):
%   -0.99995
%   -4.00040
%    4.00044
%   -0.00030
%   -0.99998
% (Abre una gráfica)
