function resultado = esDefinidaPositiva(A)
    % Verifica si una matriz A es definida positiva.
    % Una matriz es definida positiva si es simétrica Y todos
    % sus autovalores son estrictamente positivos.
    %
    % Entradas:
    %   A: Matriz cuadrada a verificar.
    %
    % Salidas:
    %   resultado: true (1) si es definida positiva, false (0) si no lo es.

    % --- Configuración Interna ---
    medir_tiempo = false;   % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;    % 0: Silencioso (solo devuelve true/false)
                           % 1: Resumen (ej. "Resultado: Es/No es Definida Positiva.")
                           % 2: Detallado (explica *por qué* no lo es)

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    % 1. Chequear simetría (condición necesaria)
    if ~isequal(A, A')
        if (opcion_verbose >= 2)
            printf("Chequeo DP: Falla (La matriz no es simétrica).\n");
        endif
        resultado = false;

        % --- Reporte Final (en caso de falla temprana) ---
        if (medir_tiempo)
            tiempo_ejecucion = toc(tic_handle);
            if (opcion_verbose == 1) % Solo si es 1, el 2 ya imprimió
                printf("Resultado: No es Definida Positiva. (Tiempo: %f s)\n", tiempo_ejecucion);
            elseif (opcion_verbose >= 2) % El 2 complementa
                 printf("(Tiempo de chequeo: %f s)\n", tiempo_ejecucion);
            endif
        endif
        return; % Salimos de la función
    endif

    % 2. Chequear que todos los autovalores sean positivos
    try
        autovalores = eig(A);
    catch err
        if (opcion_verbose >= 2)
             printf("Chequeo DP: Falla (Error calculando autovalores: %s).\n", err.message);
        endif
        resultado = false;

        % --- Reporte Final (en caso de falla en 'try') ---
        if (medir_tiempo)
            tiempo_ejecucion = toc(tic_handle);
            if (opcion_verbose == 1)
                printf("Resultado: No es Definida Positiva. (Tiempo: %f s)\n", tiempo_ejecucion);
            elseif (opcion_verbose >= 2)
                 printf("(Tiempo de chequeo: %f s)\n", tiempo_ejecucion);
            endif
        endif
        return; % Salimos de la función
    end % <-- ESTE ERA EL ERROR (decía endtry o estaba ausente)

    % Chequeo de autovalores
    if any(autovalores <= 0)
        if (opcion_verbose >= 2)
            printf("Chequeo DP: Falla (Tiene autovalores no positivos).\n");
            % disp("Autovalores:"); disp(autovalores);
        endif
        resultado = false;
    else
        % Pasó ambos chequeos
        resultado = true;
    endif

    % --- Reporte Final (Normal) ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_verbose >= 1)
        if (resultado)
            printf("Resultado: Es Definida Positiva.");
        else
            printf("Resultado: No es Definida Positiva.");
        endif

        if (medir_tiempo)
            printf(" (Tiempo: %f s)\n", tiempo_ejecucion);
        else
            printf("\n");
        endif
    endif

endfunction

% --- Ejemplo de Ejecución ---
%
% % Ejemplo 1: Matriz definida positiva
% A_pos = [2, -1, 0; -1, 2, -1; 0, -1, 2];
% res_1 = esDefinidaPositiva(A_pos)
%
% % Ejemplo 2: Matriz no definida positiva (no simétrica)
% A_no_sim = [1, 2; 3, 4];
% res_2 = esDefinidaPositiva(A_no_sim)
%
% % Ejemplo 3: Matriz no definida positiva (autovalor no positivo)
% A_no_pos = [1, 2; 2, 1];
% res_3 = esDefinidaPositiva(A_no_pos)

% --- Resultado Esperado ---
% (Con opcion_verbose = 1)
% Resultado: Es Definida Positiva. (Tiempo: ... s)
% res_1 = 1
% Resultado: No es Definida Positiva. (Tiempo: ... s)
% res_2 = 0
% Resultado: No es Definida Positiva. (Tiempo: ... s)
% res_3 = 0
