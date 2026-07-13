function [x] = gauss1(A, b)
    % Resuelve un sistema Ax=b usando Eliminación Gaussiana SIN pivoteo.
    % Esta es la versión "clásica" con bucles anidados.
    % ADVERTENCIA: Numéricamente inestable, puede fallar con pivotes cero.
    %
    % Entradas:
    %   A: Matriz cuadrada de coeficientes.
    %   b: Vector de términos independientes.
    %
    % Salidas:
    %   x: Vector solución.
    %
    % Dependencias:
    %   Requiere 'sust_atras(Aug)' en el path.

    % --- Configuración Interna ---
    medir_tiempo = false;    % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;     % 0: Silencioso, 1: Muestra resumen y tiempo
    opcion_warnings = true; % true: Muestra advertencias (ej. pivote cero)
    TOL_PIVOTE = 1e-12;     % Tolerancia para pivote

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = length(b);
    A = [A b]; % Prepara la matriz aumentada

    % Fase de Eliminación (bucles anidados)
    for k = 1:n-1 % Recorre las columnas (pivote)
        % Chequeo de pivote
        if (opcion_warnings && abs(A(k, k)) < TOL_PIVOTE)
            printf("ADVERTENCIA (gauss1): Pivote en k=%d es cercano a cero (%e).\n", k, A(k, k));
            % (El método continuará, pero probablemente falle o dé Inf)
        endif

        for i = k+1:n % Recorre las filas debajo del pivote
            m = A(i, k) / A(k, k);
            % A(i,k) = 0; % (Opcional, se puede omitir si sust_atras lo ignora)
            for j = k+1:n+1 % Recorre los elementos de la fila
                A(i, j) = A(i, j) - m * A(k, j);
            endfor
        endfor
    endfor

    % Chequeo final
    if (abs(A(n, n)) < TOL_PIVOTE)
        if (opcion_warnings)
            printf("ADVERTENCIA (gauss1): Pivote final A(n,n) es cero. No hay solución única.\n");
        endif
        x = NaN(n, 1); % Devuelve NaN
        if (medir_tiempo) toc(tic_handle); endif % Detener el tiempo
        return;
    endif

    % Fase de Sustitución
    b=A(:,n+1);
    A=A(:,1:n);

    x = sust_atras(A,b);

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Eliminación Gaussiana (Sin Pivoteo, bucles) finalizada. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % NOTA: Requiere que 'sust_atras.m' exista.
%
% A = [4, 2, 0; 2, 2, 1; 1, 1, 3];
% b = [2; 3; 6];
%
% x = gauss1(A, b)
%
% % Verificación:
% % A_orig = [4, 2, 0; 2, 2, 1; 1, 1, 3];
% % A_orig * x % Debería dar [2; 3; 6]

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo con verbose=1)
%
% Eliminación Gaussiana (Sin Pivoteo, bucles) finalizada. Tiempo: ... s
% x =
%
%    0.40000
%    0.20000
%    1.80000
