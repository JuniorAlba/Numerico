function x = sust_atras_vec(A)
    % Resuelve un sistema triangular superior Ux=b usando sustitución
    % hacia atrás. Versión vectorizada.
    % (Usada generalmente por 'Elimin_gauss_vec').
    %
    % Entradas:
    %   A: Matriz aumentada [U | b].
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

    n = length(A(:, 1));
    x = zeros(n, 1); % Inicializar 'x' como columna

    % Primer cálculo con la última ecuación
    if (opcion_warnings && abs(A(n, n)) < TOL_PIVOTE)
        printf("ADVERTENCIA (sust_atras_vec): Pivote A(%d,%d) es cercano a cero.\n", n, n);
    endif
    x(n) = A(n, n + 1) / A(n, n);

    for i = n-1:-1:1
        % Chequeo de pivote
        if (opcion_warnings && abs(A(i, i)) < TOL_PIVOTE)
            printf("ADVERTENCIA (sust_atras_vec): Pivote A(%d,%d) es cercano a cero.\n", i, i);
        endif

        % Cálculo vectorizado (tu lógica de 's')
        s = A(i, n + 1); % representa al termino de b en la fila i
        s = s - A(i, i+1:n) * x(i+1:n);
        x(i) = s / A(i, i);
    endfor

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Sustitución Hacia Atrás (Vec) finalizada. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % (Mismo ejemplo que sust_atras_p, debería dar igual)
% U = [4, 2, 0; 0, 1, 1; 0, 0, 2.5];
% b_mod = [2; 2; 5];
% Aug = [U b_mod];
%
% x = sust_atras_vec(Aug)
%
% % Verificación:
% % U * x % Debería dar [2; 2; 5]

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo con verbose=1)
% Sustitución Hacia Atrás (Vec) finalizada. Tiempo: ... s
% x =
%
%    0.5000
%    0.0000
%    2.0000
