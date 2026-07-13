function x = sust_adel_vec(A)
    % Resuelve un sistema triangular inferior Lx=b usando sustitución
    % hacia adelante. Versión vectorizada.
    %
    % Entradas:
    %   A: Matriz aumentada [L | b].
    %
    % Salidas:
    %   x: Vector solución.

    % --- Configuración Interna ---
    medir_tiempo = true;    % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 1;     % 0: Silencioso, 1: Muestra tiempo de ejecución
    opcion_warnings = true; % true: Muestra advertencias (ej. pivote cero)
    TOL_PIVOTE = 1e-12;     % Tolerancia para pivote

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = length(A(:, 1));
    x = zeros(n, 1); % Inicializar 'x' como columna

    % Chequeo del primer pivote
    if (opcion_warnings && abs(A(1, 1)) < TOL_PIVOTE)
        printf("ADVERTENCIA (sust_adel_vec): Pivote A(1,1) es cercano a cero.\n");
    endif
    x(1) = A(1, n + 1) / A(1, 1);

    for i = 2:n
        % Chequeo de pivote
        if (opcion_warnings && abs(A(i, i)) < TOL_PIVOTE)
            printf("ADVERTENCIA (sust_adel_vec): Pivote A(%d,%d) es cercano a cero.\n", i, i);
        endif

        % Cálculo vectorizado
        x(i) = (A(i, n + 1) - A(i, 1:i-1) * x(1:i-1)) / A(i, i);
    endfor

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Sustitución Hacia Adelante (Vec) finalizada. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% L = [1, 0, 0; 2, 1, 0; 3, 4, 1];
% b = [1; 3; 8];
% Aug = [L b];
%
% x = sust_adel_vec(Aug)
%
% % Verificación:
% % L * x % Debería dar [1; 3; 8]

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo con verbose=1)
% Sustitución Hacia Adelante (Vec) finalizada. Tiempo: ... s
% x =
%
%    1
%    1
%    1
