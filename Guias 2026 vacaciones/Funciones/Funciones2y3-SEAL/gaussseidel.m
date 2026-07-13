function [x, it, r_h] = gaussseidel(A, b, x0, maxit, tol)
    % Resuelve un sistema Ax=b usando el método iterativo de Gauss-Seidel.
    % Convergencia garantizada si A es diagonal dominante o s.d.p.
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
    x = x0; % x es el vector de la iteración actual
    it = 0;
    r_h = []; % Historial de errores
    err = tol + 1; % Inicializar error para entrar al bucle

    if any(diag(A) == 0)
      error("La matriz tiene ceros en la diagonal.");
    endif

    while (it < maxit && err >= tol)
        it = it + 1;

        % Bucle de Gauss-Seidel
        for i = 1:n
            % x(1:i-1) usa los valores *nuevos* ya calculados en este 'it'
            % x0(i+1:n) usa los valores *viejos* de la iteración anterior
            x(i) = (b(i) - A(i, 1:i-1) * x(1:i-1) - A(i, i+1:n) * x0(i+1:n)) / A(i, i);
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

        r_h(it) = err;

        x0 = x; % Guardar x de la iteración anterior

        % Reporte detallado (por iteración)
        if (opcion_verbose == 2)
            printf("  Iter: %4d | Error (Tipo %d): %e\n", it, opcion_error, err);
        endif
    endwhile

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    % Advertencia de no convergencia
    if (opcion_warnings && it == maxit && err >= tol)
        printf("ADVERTENCIA (Gauss-Seidel): El método no convergió en %d iteraciones.\n", maxit);
        printf("  Error final: %e (Tolerancia: %e)\n", err, tol);
    endif

    % Resumen final
    if (opcion_verbose >= 1)
        printf("--- Resumen Gauss-Seidel ---\n");
        printf("Iteraciones: %d / %d\n", it, maxit);
        printf("Error final: %e (Tipo %d)\n", err, opcion_error);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("----------------------------\n");
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
        title("Gauss-Seidel: Convergencia del Error");
        xlabel("Iteración");
        ylabel(sprintf("Error (Tipo %d)", opcion_error));

        if (opcion_grafico_pausa)
            disp("Presione Enter para continuar...");
            pause;
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % 1. Definir un sistema Diag. Dominante (asegura convergencia)
% A = [4, -1, 0; -1, 4, -1; 0, -1, 4];
% b = [3; 2; 3];
% x0 = [0; 0; 0]; % Estimación inicial
%
% maxit = 100;
% tol = 1e-8;
%
% [x, it, r_h] = gaussseidel(A, b, x0, maxit, tol);
%
% disp("Solución x:")
% disp(x)
%
% % Verificación:
% % disp("A*x =")
% % disp(A*x) % Debería ser muy cercano a b = [3; 2; 3]

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo con verbose=1)
%
% --- Resumen Gauss-Seidel ---
% Iteraciones: 11 / 100
% Error final: 6.941913e-09 (Tipo 1)
% Tiempo: ... s
% ----------------------------
% Solución x:
%    1.0000
%    1.0000
%    1.0000
%
% (Además, se abrirá una ventana con el gráfico de convergencia del error)
