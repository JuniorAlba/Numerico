function x = rcubica(a)
    % Calcula la raíz cúbica de 'a' usando Bisección.
    % Esta es una función "wrapper" que llama a 'biseccion.m'.
    %
    % Entradas:
    %   a: Número real.
    %
    % Salidas:
    %   x: Raíz cúbica de 'a'.
    %
    % Dependencias:
    %   Requiere 'biseccion.m' en el path.

    % --- Configuración Interna ---
    medir_tiempo = true;   % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 1;    % 0: Silencioso, 1: Muestra resumen

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    if (a == 0)
        x = 0;
        if (medir_tiempo) toc(tic_handle); endif
        return;
    endif

    % Función f(x) = x^3 - a
    f = @(x) x^3 - a;

    % Determinar el intervalo inicial
    if (a > 0)
        izq = 0;
        der = max(1, a);
    else
        izq = min(-1, a);
        der = 0;
    endif

    % Tolerancia (Error relativo en el intervalo)
    % (El 'tol' de bisección se define como error absoluto,
    %  así que esta tolerancia es para el intervalo).
    tol = 1e-12;

    % Máximo de iteraciones (calculado para Bisección)
    maxit = ceil(log2((der - izq) / tol));

    % --- Llamada a Bisección ---
    % NOTA: Se asume que 'biseccion.m' está en modo silencioso
    % (opcion_verbose = 0) para no contaminar esta salida.
    [x, h] = biseccion(f, izq, der, maxit, tol);

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_verbose >= 1)
        printf("--- Cálculo Raíz Cúbica (vía Bisección) ---\n");
        printf("Raíz cúbica de %f: %-15.10f\n", a, x);
        if (medir_tiempo)
            printf("Tiempo total (incl. bisección): %f s\n", tiempo_ejecucion);
        endif
        printf("-------------------------------------------\n");
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % NOTA: Antes de correr, se recomienda editar 'biseccion.m'
% % y poner 'opcion_verbose = 0' y 'graficar_convergencia = false'
% % para que esta función dé un reporte limpio.
%
% disp("--- Calculando rcubica(27) ---")
% x1 = rcubica(27)
%
% disp("--- Calculando rcubica(-8) ---")
% x2 = rcubica(-8)
%
% disp("--- Calculando rcubica(10) ---")
% x3 = rcubica(10)

% --- Resultado Esperado (Ejemplo 1) ---
% (Suponiendo biseccion.m en silencio)
% --- Calculando rcubica(27) ---
% --- Cálculo Raíz Cúbica (vía Bisección) ---
% Raíz cúbica de 27.000000: 3.0000000000
% Tiempo total (incl. bisección): ... s
% -------------------------------------------
% x1 = 3.0000
%
% --- Calculando rcubica(-8) ---
% --- Cálculo Raíz Cúbica (vía Bisección) ---
% Raíz cúbica de -8.000000: -2.0000000000
% Tiempo total (incl. bisección): ... s
% -------------------------------------------
% x2 = -2.0000
%
% --- Calculando rcubica(10) ---
% --- Cálculo Raíz Cúbica (vía Bisección) ---
% Raíz cúbica de 10.000000: 2.1544346900
% Tiempo total (incl. bisección): ... s
% -------------------------------------------
% x3 = 2.1544
