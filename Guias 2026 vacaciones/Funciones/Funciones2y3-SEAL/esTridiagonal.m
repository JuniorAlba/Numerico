function resultado = esTridiagonal(A)
    % Verifica si una matriz A es tridiagonal.
    % Una matriz es tridiagonal si es cuadrada y sus únicos elementos
    % no nulos están en la diagonal principal, la primera super-diagonal
    % y la primera sub-diagonal.
    %
    % Entradas:
    %   A: Matriz a verificar.
    %
    % Salidas:
    %   resultado: true (1) si es tridiagonal, false (0) si no lo es.

    % --- Configuración Interna ---
    medir_tiempo = false;   % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;    % 0: Silencioso, 1: Muestra resultado y tiempo

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    % 1. Verifico si la matriz es cuadrada.
    [n, m] = size(A);
    if n != m
        resultado = false;
        if (opcion_verbose >= 1)
            printf("Chequeo Tridiagonal: Falla (Matriz no es cuadrada).\n");
        endif
        if (medir_tiempo)
             toc(tic_handle); % Detener el tiempo aunque falle
        endif
        return;
    endif

    % 2. Encontrar índices de elementos no nulos.
    % (Usar find es mucho más eficiente que bucles anidados)
    [fila, col] = find(A);

    % 3. Verifica que todos los elementos no cero estén
    % en la diagonal principal (fila=col) o adyacentes (abs(fila-col)=1).
    resultado = all(abs(fila - col) <= 1);

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_verbose >= 1)
        if (resultado)
            printf("Resultado: La matriz ES tridiagonal.");
        else
            printf("Resultado: La matriz NO es tridiagonal.");
        endif

        if (medir_tiempo)
            printf(" (Tiempo: %f s)\n", tiempo_ejecucion);
        else
            printf("\n");
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% clc; clear all;
%
% A1 = [4, -1, 0, 0; -1, 4, -1, 0; 0, -1, 4, -1; 0, 0, -1, 3];
% A2 = [10, -1, 2; -1, 11, -1; 2, -1, 10]; % Falla (tiene un 2)
% A3 = [4, -1, 0; -1, 4, -1; 0, -1, 4];
% A4 = rand(5); % Falla (random)
%
% disp("Prueba A1 (Tridiagonal):")
% esTridiagonal(A1)
%
% disp("Prueba A2 (No Tridiagonal):")
% esTridiagonal(A2)
%
% disp("Prueba A3 (Tridiagonal):")
% esTridiagonal(A3)
%
% disp("Prueba A4 (No Tridiagonal):")
% esTridiagonal(A4)

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo con verbose=1)
%
% Prueba A1 (Tridiagonal):
% Resultado: La matriz ES tridiagonal. (Tiempo: ... s)
% ans = 1
% Prueba A2 (No Tridiagonal):
% Resultado: La matriz NO es tridiagonal. (Tiempo: ... s)
% ans = 0
% Prueba A3 (Tridiagonal):
% Resultado: La matriz ES tridiagonal. (Tiempo: ... s)
% ans = 1
% Prueba A4 (No Tridiagonal):
% Resultado: La matriz NO es tridiagonal. (Tiempo: ... s)
% ans = 0
