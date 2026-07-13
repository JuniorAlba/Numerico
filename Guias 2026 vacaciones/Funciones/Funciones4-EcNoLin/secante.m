function [x, h] = secante(f, xmin, xmax, kmax, tol)
    % Resuelve f(x)=0 usando el método de la Secante.
    % Convergencia:
    %    Raíz simple -> superlineal
    %
    % Entradas:
    %   f: Handle de la función f(x).
    %   xmin, xmax: Dos estimaciones iniciales (x_k-1 y x_k).
    %   kmax: Máximo número de iteraciones.
    %   tol: Tolerancia para el criterio de parada.
    %
    % Salidas:
    %   x: Aproximación de la raíz.
    %   h: Vector (historial) de errores en cada iteración.

    % --- Configuración Interna "Todo Terreno" ---
    medir_tiempo = false;         % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;          % 0: Silencioso, 1: Resumen final, 2: Detallado (cada iteración)
    opcion_warnings = true;      % true: Muestra advertencia si no converge

    % Criterio de parada (opcion_error):
    % 1: Error Absoluto | abs(x - xmax)
    % 2: Error Relativo | abs(x - xmax) / abs(x)
    % 3: Residuo (Función) | abs(f(x))
    opcion_error = 1;
    TOL_SECANTE = 1e-12;  % Tolerancia para (fx1 - fxmin) cercano a cero

    % Opciones de Gráficos
    graficar_convergencia = true;
    opcion_grafico_escala = 'log';   % (Se recomienda 'log' para Secante)
    opcion_grafico_estilo = '-.k';
    opcion_grafico_pausa = false;

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    it = 0;
    h = [];
    fxmin = f(xmin);
    fx1 = f(xmax); % f(x_k)

    % (El chequeo de signos no es mandatorio para Secante,
    %  pero se respeta del código original)
    if (opcion_warnings && sign(fxmin) * sign(fx1) > 0)
        printf("ADVERTENCIA (Secante): Los valores iniciales f(xmin) y f(xmax) tienen el mismo signo.\n");
    endif

    err = tol + 1;
    x = xmax; % Inicializar x

    while (it < kmax && err >= tol)
        it = it + 1;

        denominador = (fx1 - fxmin);

        % Chequeo de secante horizontal
        if (abs(denominador) < TOL_SECANTE)
            if (opcion_warnings)
                printf("ADVERTENCIA (Secante): Denominador cercano a cero (f(x_k) - f(x_k-1)).\n");
                printf("  f(x_k) = %e, f(x_k-1) = %e. Deteniendo el método.\n", fx1, fxmin);
            endif
            break;
        endif

        % Paso de Secante
        x = xmax - fx1 * (xmax - xmin) / denominador;
        fx = f(x);

        % --- Cálculo de error según la opción ---
        switch (opcion_error)
            case 1 % Absoluto
                err = abs(x - xmax);
            case 2 % Relativo
                err = abs(x - xmax) / (abs(x) + eps);
            case 3 % Residuo (Función)
                err = abs(fx);
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

        % Actualizar variables para la siguiente iteración
        xmin = xmax;
        fxmin = fx1;
        xmax = x;
        fx1 = fx;
    endwhile

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_warnings && it == kmax && err >= tol)
        printf("ADVERTENCIA (Secante): El método no convergió en %d iteraciones.\n", kmax);
        printf("  Error final: %e (Tolerancia: %e)\n", err, tol);
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen Método de la Secante ---\n");
        printf("Raíz encontrada: %-15.10f\n", x);
        printf("Iteraciones: %d / %d\n", it, kmax);
        printf("Error final: %e (Tipo %d)\n", err, opcion_error);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("----------------------------------\n");
    endif

    % --- Gráficos ---
    if (graficar_convergencia && !isempty(h))
        figure;
        if (strcmp(opcion_grafico_escala, 'log'))
            semilogy(1:length(h), h, opcion_grafico_estilo);
        else
            plot(1:length(h), h, opcion_grafico_estilo);
        endif
        grid on;
        title("Secante: Convergencia del Error");
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
 f1 = @(x) log(x.^2 + 1) - exp(x/2) .* cos(pi*x) - 1.106;
 xmin1 = -1;
 xmax1 = 0;
 tol1 = 1e-10; % (El parcial pedía bisección, usemos tol de Newton)
 kmax1 = 100;

 % (En la función, usar opcion_error = 3)
 [p1, h1] = secante(f1, xmin1, xmax1, kmax1, tol1);

% --- Resultado Esperado (Ejemplo 1) ---
% --- Resumen Método de la Secante ---
% Raíz encontrada: -0.8378265061
% Iteraciones: 7 / 100
% Error final: 2.597922e-14 (Tipo 3)
% Tiempo: ... s
% ----------------------------------
% (Abre una gráfica)

% --- Ejemplo 2: Caso estándar (x^3 - x - 2) (Seleccionar y presionar F9) ---
% f2 = @(x) x.^3 - x - 2;
% xmin2 = 1;
% xmax2 = 2;
% tol2 = 1e-10;
% kmax2 = 100;
%
% % (En la función, probar con opcion_error = 1 (Absoluto))
% [p2, h2] = secante(f2, xmin2, xmax2, kmax2, tol2);

% --- Resultado Esperado (Ejemplo 2) ---
% --- Resumen Método de la Secante ---
% Raíz encontrada: 1.5213797068
% Iteraciones: 8 / 100
% Error final: 3.108624e-15 (Tipo 1)
% Tiempo: ... s
% ----------------------------------
% (Abre una gráfica)
