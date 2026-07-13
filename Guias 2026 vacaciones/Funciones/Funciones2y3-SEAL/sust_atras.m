function x = sust_atras(A, b)
    % Resuelve un sistema triangular superior Ux=b usando sustitución
    % hacia atrás. Versión NO vectorizada (con bucles anidados).
    %
    % Entradas:
    %   A: Matriz triangular superior U.
    %   b: Vector de términos independientes.
    %
    % Salidas:
    %   x: Vector solución.

    % --- Configuración Interna ---
    medir_tiempo = false;    % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;     % 0: Silencioso, 1: Muestra tiempo de ejecución
    opcion_warnings = true; % true: Muestra advertencias (ej. pivote cero)
    TOL_PIVOTE = 1e-12;     % Tolerancia para pivote

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = size(A, 1);
    x = zeros(n, 1);

    % Primer cálculo con la última ecuación
    if (opcion_warnings && abs(A(n, n)) < TOL_PIVOTE)
        printf("ADVERTENCIA (sust_atras): Pivote A(%d,%d) es cercano a cero.\n", n, n);
    endif

    % --- CORRECCIÓN DE BUG ---
    % El código original usaba A(n,n+1) (asumiendo matriz aumentada)
    % pero la firma (A,b) indica argumentos separados.
    % Se corrige para usar 'b(n)'.
    x(n) = b(n) / A(n, n);

    for i = n-1:-1:1
        % Chequeo de pivote
        if (opcion_warnings && abs(A(i, i)) < TOL_PIVOTE)
            printf("ADVERTENCIA (sust_atras): Pivote A(%d,%d) es cercano a cero.\n", i, i);
        endif

        % Bucle anidado (no vectorizado)
        s = b(i); % <-- CORREGIDO (antes A(i,n+1))
        for j = i+1:n
            s = s - A(i, j) * x(j);
        endfor
        x(i) = s / A(i, i);
    endfor

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Sustitución Hacia Atrás (No-Vec) finalizada. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % (Mismo ejemplo que las anteriores, pero con A y b separados)
% U = [4, 2, 0; 0, 1, 1; 0, 0, 2.5];
% b_mod = [2; 2; 5];
%
% x = sust_atras(U, b_mod)
%
% % Verificación:
% % U * x % Debería dar [2; 2; 5]

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo con verbose=1)
% Sustitución Hacia Atrás (No-Vec) finalizada. Tiempo: ... s
% x =
%
%    0.5000
%    0.0000
%    2.0000
