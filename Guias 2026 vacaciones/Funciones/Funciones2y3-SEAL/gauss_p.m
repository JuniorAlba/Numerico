function [x, r] = gauss_p(A, b)
    % Resuelve un sistema Ax=b usando Eliminación Gaussiana con
    % pivoteo parcial por filas.
    %
    % Entradas:
    %   A: Matriz cuadrada de coeficientes.
    %   b: Vector de términos independientes.
    %
    % Salidas:
    %   x: Vector solución.
    %   r: Vector de permutación de filas (cómo quedó A y b).
    %
    % Dependencias:
    %   Requiere 'sust_atras_p(Aug)' en el path.

    % --- Configuración Interna ---
    medir_tiempo = false;    % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;     % 0: Silencioso, 1: Muestra resumen y tiempo
    opcion_warnings = true; % true: Muestra advertencias (ej. pivote cero)
    TOL_PIVOTE = 1e-9;      % Tolerancia para pivote (tomado de tu epsilon)

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = length(b);
    A = [A b]; % Matriz aumentada
    r = [1:n]'; % Vector de permutación (filas)

    for k = 1:n-1
        % Pivoteo parcial
        [pmax, p] = max(abs(A(r(k:n), k)));
        p = p + k - 1; % Posición global

        if (pmax < TOL_PIVOTE)
            if (opcion_warnings)
                printf("ADVERTENCIA (gauss_p): Pivote en k=%d es cercano a cero (%e).", k, pmax);
                printf(" El sistema puede ser singular.\n");
            endif
            break % Sale del bucle de eliminación
        endif

        % Intercambio de filas (solo en el vector r)
        if p != k
            r([p k]) = r([k p]);
        endif

        % Eliminación (vectorizada)
        A(r(k+1:n), k) = A(r(k+1:n), k) / A(r(k), k); % Multiplicadores
        A(r(k+1:n), k+1:n+1) = A(r(k+1:n), k+1:n+1) - A(r(k+1:n), k) * A(r(k), k+1:n+1);
    endfor

    % Cálculo de la solución usando la matriz permutada
    x = sust_atras_p(A(r, :)); % Llama a la 'caja negra'

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Eliminación Gaussiana (Pivoteo) finalizada. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % NOTA: Requiere que 'sust_atras_p.m' exista en el path.
%
% A_orig = [2, 1, 5; 4, 4, -4; 1, 3, 1];
% b_orig = [5; 6; 7];
%
% [x, r] = gauss_p(A_orig, b_orig);
%
% disp("Vector de permutación r:")
% disp(r)
% disp("Solución x:")
% disp(x)
%
% % Verificación:
% % disp("Error A_orig*x - b_orig:")
% % disp(A_orig*x - b_orig) % Debería dar [0; 0; 0]

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo con verbose=1.)
%
% Eliminación Gaussiana (Pivoteo) finalizada. Tiempo: ... s
% Vector de permutación r:
%    2
%    3
%    1
%
% Solución x:
%   -6.2500e-02
%    2.1562e+00
%    5.9375e-01
