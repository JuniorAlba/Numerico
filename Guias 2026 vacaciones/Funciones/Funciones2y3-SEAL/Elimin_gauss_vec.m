function [x] = Elimin_gauss_vec(A, b)
    % Resuelve un sistema Ax=b usando Eliminación Gaussiana (vectorizada)
    % y sustitución hacia atrás.
    % NO usa pivoteo, por lo que es numéricamente inestable y puede fallar.
    %
    % Entradas:
    %   A: Matriz cuadrada de coeficientes.
    %   b: Vector de términos independientes.
    %
    % Salidas:
    %   x: Vector solución.
    %
    % Dependencias:
    %   Requiere la función 'sust_atras_vec(Aug)' en el path de Octave.

    % --- Configuración Interna ---
    medir_tiempo = false;    % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;     % 0: Silencioso, 1: Muestra tiempo de ejecución
    opcion_warnings = true; % true: Muestra advertencias (ej. pivote cero)
    TOL_PIVOTE = 1e-12;     % Tolerancia para advertir sobre pivote pequeño

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = length(b);
    % A y b se modifican por separado (eficiente).

    % Fase de Triangulación (vectorizada)
    for k = 1:n-1 % Se itera hasta la penúltima columna
        % Chequeo de pivote
        if (opcion_warnings && abs(A(k, k)) < TOL_PIVOTE)
            printf("ADVERTENCIA (Elimin_gauss_vec): Pivote en k=%d es cercano a cero (%e).", k, A(k, k));
            printf(" El resultado puede ser inestable o incorrecto.\n");
        endif

        % Cálculo de multiplicadores (vector)
        m = A(k+1:n, k) / A(k, k);

        % Actualización de la submatriz A
        A(k+1:n, k:n) = A(k+1:n, k:n) - m * A(k, k:n);

        % Actualización del vector b
        b(k+1:n) = b(k+1:n) - m * b(k);
    endfor

    % Fase de Sustitución hacia atrás
    % Se arma la matriz aumentada [A_triang, b_modificado] para la función
    Aug = [A b];
    [x] = sust_atras_vec(Aug); % Llama a tu función externa

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            % (El 'tic/toc' de sust_atras_vec es aparte y se respeta)
            printf("Eliminación Gaussiana finalizada. Tiempo total (EG+Sust): %f segundos\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % NOTA: Para que este ejemplo funcione, primero debe existir
% % la función 'sust_atras_vec.m' (la que nos da el profe)
% % en la carpeta de funciones.
%
% % 1. Script de prueba
% A = [4, 2, 0; 2, 2, 1; 1, 1, 3];
% b = [2; 3; 6];
%
% x = Elimin_gauss_vec(A, b)
%
% % 2. Verificación (A*x debe dar b)
% % A_orig = [4, 2, 0; 2, 2, 1; 1, 1, 3];
% % b_verif = A_orig * x
% % disp("Error (A*x - b):")
% % disp(b_verif - b) % Debería dar cercano a cero

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo. ESTE ES EL CORRECTO.)
%
% (Salida de 'sust_atras_vec.m')
% Elapsed time is ... seconds.
%
% (Salida de 'Elimin_gauss_vec.m')
% Eliminación Gaussiana finalizada. Tiempo total (EG+Sust): ... segundos
%
% x =
%
%    0.40000
%    0.20000
%    1.80000
