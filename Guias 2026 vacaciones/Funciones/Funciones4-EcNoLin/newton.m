function [x, h] = newton(f, df, x0, kmax, tol)
    % Resuelve f(x)=0 usando el método de Newton-Raphson.
    % Convergencia:
    %   Raíz simple -> cuadrática
    %   Raíz múltiple -> lineal
    % Entradas:
    %   f: Handle de la función f(x).
    %   df: Handle de la derivada f'(x).
    %   x0: Valor inicial.
    %   kmax: Máximo número de iteraciones.
    %   tol: Tolerancia para el criterio de parada.
    %
    % Salidas:
    %   x: Aproximación de la raíz.
    %   h: Vector (historial) de errores en cada iteración.

    % --- Configuración Interna "Todo Terreno" ---
    medir_tiempo = true;         % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 1;          % 0: Silencioso, 1: Resumen final, 2: Detallado (cada iteración)
    opcion_warnings = true;      % true: Muestra advertencia si no converge
                                 % (Se eliminó el chequeo de df=0 para
                                 %  igualar el comportamiento original)

    % Criterio de parada (opcion_error):
    % 1: Error Absoluto | abs(x - x_ant)
    % 2: Error Relativo | abs(x - x_ant) / abs(x)
    % 3: Residuo (Función) | abs(f(x))
    opcion_error = 2; % (Default Relativo)

    % Opciones de Gráficos
    graficar_convergencia = true;
    opcion_grafico_escala = 'log';   % (Se recomienda 'log' para Newton)
    opcion_grafico_estilo = '-or';
    opcion_grafico_pausa = false;

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    it = 0;
    h = [];
    x = x0; % x es el valor "anterior" (x_k)
    err = tol + 1;

    while (it < kmax && err >= tol)
        it = it + 1;
        fx = f(x);
        dfx = df(x);

        % (Se elimina el chequeo de derivada cero para replicar
        %  el comportamiento de la cátedra, que permite "saltar"
        %  de raíz si la derivada es muy chica)

        % Paso de Newton
        x_nuevo = x - (fx / dfx);

        % --- Cálculo de error según la opción ---
        switch (opcion_error)
            case 1 % Absoluto
                err = abs(x_nuevo - x);
            case 2 % Relativo
                err = abs(x_nuevo - x) / (abs(x_nuevo) + eps);
            case 3 % Residuo (Función)
                err = abs(f(x_nuevo));
            otherwise
                error("Opción de error no válida.");
        endswitch
        h(it) = err;

        % Reporte detallado (por iteración)
        if (opcion_verbose == 2)
            printf("  Iter: %4d | x = %-15.10f | Error (Tipo %d): %e\n", it, x_nuevo, opcion_error, err);
        endif

        % Criterio de parada
        if (err < tol)
            x = x_nuevo; % Actualizar x al valor final
            break;
        endif

        x = x_nuevo; % Actualizar para la siguiente iteración
    endwhile

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_warnings && it == kmax && err >= tol)
        printf("ADVERTENCIA (Newton): El método no convergió en %d iteraciones.\n", kmax);
        printf("  Error final: %e (Tolerancia: %e)\n", err, tol);
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen Newton-Raphson ---\n");
        printf("Raíz encontrada: %-15.10f\n", x);
        printf("Iteraciones: %d / %d\n", it, kmax);
        printf("Error final: %e (Tipo %d)\n", err, opcion_error);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("------------------------------\n");
    endif

    % --- Gráficos ---
    if (graficar_convergencia && !isempty(h))
        figure;

        % CORRECCIÓN: Se suma 'eps' al historial 'h'
        % para evitar el error 'log(0)' en semilogy
        % si el error es exactamente cero.
        h_plot = h + eps;

        if (strcmp(opcion_grafico_escala, 'log'))
            semilogy(1:length(h_plot), h_plot, opcion_grafico_estilo);
        else
            plot(1:length(h_plot), h_plot, opcion_grafico_estilo);
        endif
        grid on;
        title("Newton: Convergencia del Error");
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
% f1 = @(x) log(x.^2 + 1) - exp(x/2) .* cos(pi*x) - 1.106;
% df1 = @(x) (2*x)./(x.^2+1) - (0.5*exp(x/2).*cos(pi*x) - exp(x/2).*sin(pi*x)*pi);
%
% tol1 = 1e-10;
% kmax1 = 100;
%
% % Caso 1a (x0 = 3)
% disp("--- Newton Caso 1a (x0=3) ---")
% [p1a, h1a] = newton(f1, df1, 3, kmax1, tol1);
%
% % Caso 1b (x0 = 3.05)
% disp("--- Newton Caso 1b (x0=3.05) ---")
% [p1b, h1b] = newton(f1, df1, 3.05, kmax1, tol1);
%
% % Caso 1c (x0 = 3.1)
% disp("--- Newton Caso 1c (x0=3.1) ---")
% [p1c, h1c] = newton(f1, df1, 3.1, kmax1, tol1);

% --- Resultado Esperado (Ejemplo 1) ---
%
% --- Newton Caso 1a (x0=3) ---
% --- Resumen Newton-Raphson ---
% Raíz encontrada: 0.6746660956
% Iteraciones: 8 / 100
% Error final: 0.000000e+00 (Tipo 2)
% Tiempo: ... s
% ------------------------------
%
% --- Newton Caso 1b (x0=3.05) ---
% --- Resumen Newton-Raphson ---
% Raíz encontrada: -0.8378265061
% Iteraciones: 9 / 100
% Error final: 6.343363e-13 (Tipo 2)
% Tiempo: ... s
% ------------------------------
%
% --- Newton Caso 1c (x0=3.1) ---
% --- Resumen Newton-Raphson ---
% Raíz encontrada: 6.4666706700
% Iteraciones: 6 / 100
% Error final: 0.000000e+00 (Tipo 2)
% Tiempo: ... s
% ------------------------------
% (Las gráficas se abren sin warnings)
