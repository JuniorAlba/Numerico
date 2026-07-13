function [x, it, r_h] = sor(A, b, x0, maxit, tol, w)
    % Resuelve un sistema Ax=b usando el método iterativo SOR
    % (Successive Over-Relaxation).
    % Si A es s.d.p -> SOR converge para todo w de (0,2)
    %
    % Entradas:
    %   A: Matriz cuadrada de coeficientes.
    %   b: Vector de términos independientes.
    %   x0: Vector de estimación inicial.
    %   maxit: Número máximo de iteraciones.
    %   tol: Tolerancia para el criterio de parada.
    %   w: Parámetro de relajación (0 < w < 2). (w=1 es Gauss-Seidel).
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
    opcion_error = 2;

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
    x = x0; % El vector 'nuevo' se construye sobre 'x0'

    % Advertencia de 'w'
    if (opcion_warnings && (w <= 0 || w >= 2))
       printf("ADVERTENCIA (SOR): 'w' = %f está fuera del rango (0, 2).", w);
       printf(" El método probablemente diverja.\n");
    endif

    while (it < maxit)

        % Bucle de SOR
        % x0 es el vector de la iteración anterior
        % x es el vector que se está construyendo
        for i = 1:n
            % x(1:i-1) son los valores *nuevos* de esta iteración (j < i)
            % x0(i+1:n) son los valores *viejos* de la iteración anterior (j > i)
            % x0(i) es el valor *viejo* de la posición actual
            x(i) = (1 - w) * x0(i) + w * (b(i) - A(i, 1:i-1) * x(1:i-1) - A(i, i+1:n) * x0(i+1:n)) / A(i, i);
        endfor

        % Cálculo de error según la opción
        switch (opcion_error)
            case 1 % Relativo (Inf)
                err = norm(x - x0, 'inf') / (norm(x, 'inf') + eps);
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

        x0 = x; % El nuevo vector es ahora el viejo
    endwhile

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_warnings && it == maxit && err >= tol)
        printf("ADVERTENCIA (SOR): El método no convergió en %d iteraciones (w=%f).\n", maxit, w);
        printf("  Error final: %e (Tolerancia: %e)\n", err, tol);
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen SOR (w=%f) ---\n", w);
        printf("Iteraciones: %d / %d\n", it, maxit);
        printf("Error final: %e (Tipo %d)\n", err, opcion_error);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("-------------------------------\n");
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
        title(sprintf("SOR (w=%f): Convergencia del Error", w));
        xlabel("Iteración");
        ylabel(sprintf("Error (Tipo %d)", opcion_error));

        if (opcion_grafico_pausa)
            disp("Presione Enter para continuar...");
            pause;
        endif
    endif

endfunction

% --- Ejemplo 1: Caso de Prueba - Ev. Continua 1 (2025) (Seleccionar y presionar F9) ---
% % Contexto: Matriz tridiagonal 40x40
% n = 40;
% A = diag(2*ones(n,1), 0) + diag(-1*ones(n-1,1), 1) + diag(-1*ones(n-1,1), -1);
% b = ones(n,1);
% for i=1:n
%   b(i)=1.5*i-6;
% endfor
% x0 = zeros(n,1);
% maxit = 5000;
% tol = 1e-5;
% w = 1.85;
%
% [x_sor, it_sor, r_sor] = sor(A, b, x0, maxit, tol, w);
% disp("x(20) (Ejemplo 1):")
% disp(x_sor(20))

% --- Resultado Esperado (Ejemplo 1) ---
% --- Resumen SOR (w=1.850000) ---
% Iteraciones: 98 / 5000
% Error final: 9.516385e-06 (Tipo 1)
% Tiempo: ... s
% -------------------------------
% x(20) (Ejemplo 1):
%    5144.637...
% (Abre una gráfica)

% --- Ejemplo 2: Caso de Gauss-Seidel (w=1.0) (Seleccionar y presionar F9) ---
% % Matriz simple, diagonal dominante
% A = [4, -1, 0; -1, 4, -1; 0, -1, 4];
% b = [3; 2; 3];
% x0 = [0; 0; 0];
% maxit = 100;
% tol = 1e-8;
% w_gs = 1.0; % w=1.0 es Gauss-Seidel
%
% [x_gs, it_gs, r_gs] = sor(A, b, x0, maxit, tol, w_gs);
% disp("Solución (Ejemplo 2 - GS):")
% disp(x_gs)

% --- Resultado Esperado (Ejemplo 2) ---
% --- Resumen SOR (w=1.000000) ---
% Iteraciones: 11 / 100
% Error final: 4.074536e-09 (Tipo 1)
% Tiempo: ... s
% -------------------------------
% Solución (Ejemplo 2 - GS):
%    1.0000
%    1.0000
%    1.0000
% (Abre una gráfica)

% --- Ejemplo 3: Caso de Prueba - Parcial 1 (2025) - Divergente (Seleccionar y presionar F9) ---
% % Matriz del Ej. 2, Evaluación Parcial 1 (2025)
% % Esta matriz divergía para Gauss-Seidel (w=1.0)
% A = [2 0 1 0 -2; 1 1 1 1 -1; -2 2 2 -2 1; -1 0 1 2 2; -1 2 2 -1 2];
% b = [4; 0; 1; 3; -1];
% x0 = [0; 0; 0; 0; 0];
% maxit = 50; % Límite corto para ver la advertencia
% tol = 1e-4;
% w_div = 1.0; % w=1.0 (Gauss-Seidel) divergía (rho=1.6)
%
% [x_div, it_div, r_div] = sor(A, b, x0, maxit, tol, w_div);

% --- Resultado Esperado (Ejemplo 3) ---
% ADVERTENCIA (SOR): El método no convergió en 50 iteraciones (w=1.000000).
%   Error final: 1.618732e+00 (Tolerancia: 1.000000e-04)
% --- Resumen SOR (w=1.000000) ---
% Iteraciones: 50 / 50
% Error final: 1.618732e+00 (Tipo 1)
% Tiempo: ... s
% -------------------------------
% (Abre una gráfica del error explotando)
