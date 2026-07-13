function [L D U] = DescomponerMatriz(A)
    % Descompone una matriz A en sus componentes L, D, U tal que A = L + D + U.
    % L: Matriz triangular inferior estricta (sin diagonal).
    % D: Matriz diagonal.
    % U: Matriz triangular superior estricta (sin diagonal).
    %
    % Entradas:
    %   A: Matriz cuadrada de entrada.
    %
    % Salidas:
    %   L: Componente triangular inferior de A.
    %   D: Componente diagonal de A.
    %   U: Componente triangular superior de A.

    % --- Configuración Interna ---
    medir_tiempo = true; % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 1;  % 0: Silencioso, 1: Muestra tiempo de ejecución

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    L = tril(A, -1);
    U = triu(A, 1);
    D = diag(diag(A)); % Equivalente a A - L - U

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Descomposición L+D+U finalizada. Tiempo: %f segundos\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución ---
% A = [4, 1, -1; 1, 3, 1; 2, 0, 5];
% disp("Matriz A:");
% disp(A);
%
% [L, D, U] = DescomponerMatriz(A);
%
% disp("Matriz L:");
% disp(L);
% disp("Matriz D:");
% disp(D);
% disp("Matriz U:");
% disp(U);
%
% % Para verificar:
% % A_recompuesta = L + D + U;
% % disp(A_recompuesta);

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo)
% Matriz A:
%    4   1  -1
%    1   3   1
%    2   0   5
%
% Descomposición L+D+U finalizada. Tiempo: ... segundos
% Matriz L:
%    0   0   0
%    1   0   0
%    2   0   0
%
% Matriz D:
%    4   0   0
%    0   3   0
%    0   0   5
%
% Matriz U:
%    0   1  -1
%    0   0   1
%    0   0   0
