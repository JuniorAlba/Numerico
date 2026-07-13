function [A, r] = doolittle_p(A)
    % Realiza la factorización LU in-place (factores L y U en A) con pivoteo parcial.
    % El resultado es P*A = L*U.
    %
    % Entradas:
    %   A: Matriz cuadrada a factorizar.
    %
    % Salidas:
    %   A: Matriz que contiene L (sin diagonal) y U (con diagonal).
    %   r: Vector de permutación de filas (pivoteo).

    % --- Configuración Interna ---
    medir_tiempo = false; % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;  % 0: Silencioso, 1: Muestra tiempo de ejecución

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = length(A(:, 1));
    r = 1:n;

    for k = 1:n-1
        % Pivoteo parcial: buscar el máximo en la columna k
        [~, p] = max(abs(A(r(k:n), k)));
        p = p(1) + k - 1;

        % Intercambiar filas en el vector de permutación
        r([p k]) = r([k p]);

        % Cálculo de multiplicadores (columna de L)
        A(r(k+1:n), k) = A(r(k+1:n), k) / A(r(k), k);

        % Actualización de la submatriz restante
        A(r(k+1:n), k+1:n) = A(r(k+1:n), k+1:n) - A(r(k+1:n), k) * A(r(k), k+1:n);
    endfor

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Factorización Doolittle (Pivoteo) finalizada. Tiempo: %f segundos\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% A_orig = [2, 1, 5; 4, 4, -4; 1, 3, 1];
% [A_lu, r] = doolittle_p(A_orig);
%
% % Para extraer L, U y P
% n = length(A_lu);
% P = eye(n)(r, :);
% L = eye(n) + tril(A_lu(r, 1:n), -1); % Esta lógica de extracción es correcta
% U = triu(A_lu(r, 1:n)); % Esta lógica de extracción es correcta
%
% disp("Matriz L:");
% disp(L);
% disp("Matriz U:");
% disp(U);
% disp("Matriz P:");
% disp(P);
%
% % Verificación (debería dar ~0)
% % disp("Error P*A_orig - L*U:");
% % disp(P * A_orig - L * U);


% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo. ESTE SÍ ES EL CORRECTO.)
% Factorización Doolittle (Pivoteo) finalizada. Tiempo: ... segundos
% Matriz L:
%    1.00000   0.00000   0.00000
%    0.25000   1.00000   0.00000
%    0.50000  -0.50000   1.00000
%
% Matriz U:
%    4.0000   4.0000  -4.0000
%    0.0000   2.0000   2.0000
%    0.0000   0.0000   8.0000
%
% Matriz P:
%    0   1   0
%    0   0   1
%    1   0   0
