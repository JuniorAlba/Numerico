function [x, h] = puntofijo(g, x0, kmax, tol)
    % Resuelve x = g(x) usando el método de Iteración de Punto Fijo.
    % Convergencia:
    %   g'(p) != 0 -> lineal
    %   g'(p) == 0 -> cuadrática
    %
    % Entradas:
    %   g: Handle de la función de iteración g(x).
    %   x0: Valor inicial.
    %   kmax: Máximo número de iteraciones.
    %   tol: Tolerancia para el criterio de parada.
    %
    % Salidas:
    %   x: Aproximación del punto fijo.
    %   h: Vector (historial) de errores en cada iteración.

    % --- Configuración Interna "Todo Terreno" ---
    medir_tiempo = true;         % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;          % 0: Silencioso, 1: Resumen final, 2: Detallado (cada iteración)
    opcion_warnings = true;      % true: Muestra advertencia si no converge

    % Criterio de parada (opcion_error):
    % 1: Error Absoluto | abs(x - x0)
    % 2: Error Relativo | abs(x - x0) / abs(x)
    opcion_error = 1; % (Default Absoluto, como en el código original)

    % Opciones de Gráficos
    graficar_convergencia = true;
    opcion_grafico_escala = 'log';   % (Se recomienda 'log' para PF)
    opcion_grafico_estilo = '-.g';
    opcion_grafico_pausa = false;

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    it = 0;
    h = [];
    err = tol + 1;

    while (it < kmax && err >= tol)
        it = it + 1;
        x = g(x0); % Calcular x_k+1

        % --- Cálculo de error según la opción ---
        switch (opcion_error)
            case 1 % Absoluto
                err = abs(x - x0);
            case 2 % Relativo
                err = abs(x - x0) / (abs(x) + eps);
            otherwise
                error("Opción de error no válida.");
        endswitch
        h(it) = err;

        % Reporte detallado (por iteración)
        if (opcion_verbose == 2)
            printf("  Iter: %4d | x = %-15.10f | Error (Tipo %d): %e\n", it, x, opcion_error, err);
        endif

        % Criterio de parada
        if (err < tol)
            break;
        endif

        x0 = x; % Actualizar para la siguiente iteración
    endwhile

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_warnings && it == kmax && err >= tol)
        printf("ADVERTENCIA (Punto Fijo): El método no convergió en %d iteraciones.\n", kmax);
        printf("  Error final: %e (Tolerancia: %e)\n", err, tol);
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen Punto Fijo ---\n");
        printf("Punto Fijo encontrado: %-15.10f\n", x);
        printf("Iteraciones: %d / %d\n", it, kmax);
        printf("Error final: %e (Tipo %d)\n", err, opcion_error);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("--------------------------\n");
    endif

    % --- Gráficos ---
    if (graficar_convergencia && !isempty(h))
        figure;
        if (strcmp(opcion_grafico_escala, 'log'))
            semilogy(1:length(h), h, h + eps, opcion_grafico_estilo);
        else
            plot(1:length(h), h, opcion_grafico_estilo);
        endif
        grid on;
        title("Punto Fijo: Convergencia del Error");
        xlabel("Iteración");
        ylabel(sprintf("Error (Tipo %d)", opcion_error));
        if (opcion_grafico_pausa)
            disp("Presione Enter para continuar...");
            pause;
        endif
    endif

endfunction

% --- Ejemplo 1: Caso de Prueba - Parcial 1 (2025) (Seleccionar y presionar F9) ---
% % f(x) = ln(x^2+1) - exp(x/2)*cos(pi*x) - 1.106
% % g(x) = f(x) + x
% % (Esta g(x) busca las raíces de f(x))
%
% f1 = @(x) log(x.^2 + 1) - exp(x/2) .* cos(pi*x) - 1.106;
% g1 = @(x) f1(x) + x;
%
% x0_1 = 0.5; % (Punto de inicio)
% tol1 = 1e-7;
% kmax1 = 100;
%
% % (En la función, usar opcion_error = 1)
% [p1, h1] = puntofijo(g1, x0_1, kmax1, tol1);

% --- Resultado Esperado (Ejemplo 1) ---
% --- Resumen Punto Fijo ---
% Punto Fijo encontrado: -0.8378264750
% Iteraciones: 53 / 100
% Error final: 7.503340e-08 (Tipo 1)
% Tiempo: ... s
% --------------------------
% (Abre una gráfica)

% --- Ejemplo 2: Caso clásico (cos(x)) (Seleccionar y presionar F9) ---
% g2 = @(x) cos(x);
% x0_2 = 0.5;
% tol2 = 1e-8;
% kmax2 = 100;
%
% % (En la función, usar opcion_error = 1)
% [p2, h2] = puntofijo(g2, x0_2, kmax2, tol2);

% --- Resultado Esperado (Ejemplo 2) ---
% --- Resumen Punto Fijo ---
% Punto Fijo encontrado: 0.7390851372
% Iteraciones: 45 / 100
% Error final: 9.989360e-09 (Tipo 1)
% Tiempo: ... s
% --------------------------
% (Abre una gráfica)
