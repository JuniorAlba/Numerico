function [p, h] = biseccion(f, a, b, maxit, tol)
    % Resuelve f(x)=0 usando el método de Bisección.
    % Esta es la versión estandarizada que devuelve el historial de error.
    % Convergencia lineal.
    %
    % Entradas:
    %   f: Handle de la función f(x).
    %   a: Extremo izquierdo del intervalo.
    %   b: Extremo derecho del intervalo.
    %   maxit: Número máximo de iteraciones.
    %   tol: Tolerancia para el criterio de parada.
    %
    % Salidas:
    %   p: Aproximación de la raíz.
    %   h: Vector (historial) de errores en cada iteración.

    % --- Configuración Interna "Todo Terreno" ---
    medir_tiempo = false;         % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;          % 0: Silencioso, 1: Resumen final, 2: Detallado (cada iteración)
    opcion_warnings = false;      % true: Muestra advertencia si no cumple TVM

    % Criterio de parada (opcion_error):
    % 1: Error Absoluto | abs(p - p_ant)
    % 2: Error Relativo | abs(p - p_ant) / abs(p)
    % 3: Residuo (Función) | abs(f(p))
    % 4: Longitud del Intervalo | abs(b - a)
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

    fa = f(a);
    fb = f(b);

    % Chequeo Teorema de Valor Intermedio (Bolzano)
    if sign(fa) * sign(fb) > 0
        if (opcion_warnings)
            printf("ADVERTENCIA (Bisección): No se cumple la regla de los signos (TVM).\n");
            printf("  f(%f) = %e, f(%f) = %e\n", a, fa, b, fb);
        endif
        p = NaN; % Devolver NaN si no se puede empezar
        h = [NaN];
        if (medir_tiempo) toc(tic_handle); endif
        return;
    endif

    it = 0;
    h = []; % Historial de errores
    p = a;  % Inicializar p para el cálculo de error en la it 1

    while (it < maxit)
        it = it + 1;
        p_ant = p; % Guardar el p anterior
        p = a + (b - a) / 2; % Calcular nuevo p
        fp = f(p);

        % --- Cálculo de error según la opción ---
        switch (opcion_error)
            case 1 % Absoluto
                err = abs(p - p_ant);
            case 2 % Relativo
                err = abs(p - p_ant) / (abs(p) + eps);
            case 3 % Residuo (Función)
                err = abs(fp);
            case 4 % Longitud del Intervalo
                err = abs(b - a);
            otherwise
                error("Opción de error no válida.");
        endswitch
        h(it) = err;

        % Reporte detallado (por iteración)
        if (opcion_verbose == 2)
            printf("  Iter: %4d | p = %-15.10f | Error (Tipo %d): %e\n", it, p, opcion_error, err);
        endif

        % Criterio de parada
        if (err < tol && it > 1) % (it>1 para evitar parada en la primera iteración)
            break;
        endif

        % Actualización del intervalo
        if (sign(fp) * sign(fa) < 0)
            fb = fp;
            b = p;
        else
            fa = fp;
            a = p;
        endif
    endwhile

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_warnings && it == maxit && err >= tol)
        printf("ADVERTENCIA (Bisección): El método no convergió en %d iteraciones.\n", maxit);
        printf("  Error final: %e (Tolerancia: %e)\n", err, tol);
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen Bisección ---\n");
        printf("Raíz encontrada: %-15.10f\n", p);
        printf("Iteraciones: %d / %d\n", it, maxit);
        printf("Error final: %e (Tipo %d)\n", err, opcion_error);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("-------------------------\n");
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
        title("Bisección: Convergencia del Error");
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
% a1 = -1;
% b1 = 0;
% tol1 = 1e-7;
% maxit1 = 100;
%
% % (En la función, usar opcion_error = 1 para error absoluto)
% [p1, h1] = biseccion(f1, a1, b1, maxit1, tol1);

% --- Resultado Esperado (Ejemplo 1) ---
% --- Resumen Bisección ---
% Raíz encontrada: -0.8378265500
% Iteraciones: 24 / 100
% Error final: 5.960464e-08 (Tipo 1)
% Tiempo: ... s
% -------------------------
% (Abre una gráfica)

% --- Ejemplo 2: Caso estándar (x^3 - x - 2) (Seleccionar y presionar F9) ---
% f2 = @(x) x.^3 - x - 2;
% a2 = 1;
% b2 = 2;
% tol2 = 1e-5;
% maxit2 = 100;
%
% % (En la función, probar con opcion_error = 3 (Residuo))
% [p2, h2] = biseccion(f2, a2, b2, maxit2, tol2);

% --- Resultado Esperado (Ejemplo 2) ---
% --- Resumen Bisección ---
% Raíz encontrada: 1.5213813782
% Iteraciones: 18 / 100
% Error final: 9.934278e-06 (Tipo 3)
% Tiempo: ... s
% -------------------------
% (Abre una gráfica)
