function [A] = doolittle(A)
    % Realiza la factorización LU in-place (factores L y U en A) SIN pivoteo.
    % ADVERTENCIA: Falla si un pivote A(k,k) es cero o cercano a cero.
    %
    % Entradas:
    %   A: Matriz cuadrada a factorizar.
    %
    % Salidas:
    %   A: Matriz que contiene L (sin diagonal) y U (con diagonal).

    % --- Configuración Interna ---
    medir_tiempo = false;       % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;        % 0: Silencioso, 1: Muestra tiempo de ejecución
    opcion_warnings = true;    % true: Muestra advertencias (ej. pivote cero)
    opcion_vectorizado = true; % true: usa bucle vectorizado, false: usa bucles anidados
    TOL_PIVOTE = 1e-12;        % Tolerancia para advertir sobre pivote pequeño

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = length(A(:, 1));

    for k = 1:n-1
        % Chequeo de pivote
        if (opcion_warnings && abs(A(k, k)) < TOL_PIVOTE)
            printf("ADVERTENCIA (doolittle): Pivote en k=%d es cercano a cero (%e).", k, A(k, k));
            printf(" El resultado puede ser inestable o incorrecto.\n");
        endif

        if (opcion_vectorizado)
            % Versión vectorizada (tomada de tus comentarios)
            A(k+1:n, k) = A(k+1:n, k) / A(k, k); %Valor lambda: vector columna
            A(k+1:n, k+1:n) = A(k+1:n, k+1:n) - A(k+1:n, k) * A(k, k+1:n);
        else
            % Versión con bucles anidados
            for i = k+1:n
                s = A(i, k) / A(k, k);
                A(i, k) = s;
                for j = k+1:n
                    A(i, j) = A(i, j) - s * A(k, j);
                endfor
            endfor
        endif
    endfor

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Factorización Doolittle (Sin Pivoteo) finalizada. Tiempo: %f segundos\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución ---
% A_orig = [2, 1, 5; 4, 4, -4; 1, 3, 1];
% A_lu = doolittle(A_orig);
%
% % Para extraer L y U
% n = length(A_lu);
% L = eye(n) + tril(A_lu, -1);
% U = triu(A_lu);
%
% disp("Matriz L:");
% disp(L);
% disp("Matriz U:");
% disp(U);

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo)
% Factorización Doolittle (Sin Pivoteo) finalizada. Tiempo: ... segundos
% Matriz L:
%    1.0000   0.0000   0.0000
%    2.0000   1.0000   0.0000
%    0.5000   1.2500   1.0000
%
% Matriz U:
%    2.0000   1.0000   5.0000
%    0.0000   2.0000  -14.0000
%    0.0000   0.0000   16.0000
