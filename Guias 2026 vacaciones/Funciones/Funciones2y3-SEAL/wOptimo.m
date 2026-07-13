function [w] = wOptimo(A, b, x0, tol, maxit)
    % Estima el parámetro óptimo 'w' para el método SOR.
    % ### NOTA IMPORTANTE: Ver nota del ejemplo 2! ###
    %
    % Estrategia:
    % 1. (Teórico) Si A es Tridiagonal y Def. Positiva, usa la fórmula
    %    basada en el radio espectral de Jacobi.
    % 2. (Fuerza Bruta) Si no, prueba un rango de 'w' y busca el que
    %    minimiza las iteraciones.
    %
    % Entradas:
    %    A: Matriz cuadrada de coeficientes.
    %    b: Vector de términos independientes.
    %    x0: Vector de estimación inicial.
    %    tol: Tolerancia (para la prueba de fuerza bruta).
    %    maxit: Máx. iteraciones (para la prueba de fuerza bruta).
    %
    % Salidas:
    %    w: Valor óptimo de 'w' estimado.
    %
    % Dependencias:
    %    esDefinidaPositiva.m, esTridiagonal.m, RadioEspectral.m, sor.m

    % --- Configuración Interna ---
    medir_tiempo = false;   % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;    % 0: Silencioso, 1: Resumen (w y método), 2: Detallado

    % Opciones de Fuerza Bruta (si aplica)
    opcion_bruteforce_paso = 0.05;  % Tamaño del salto al probar 'w' (ej: 0.01, 0.06, 0.11...)
    opcion_bruteforce_max_w = 1.99; % Límite superior (no probar 2)

    % Opciones de Gráficos (solo para fuerza bruta)
    graficar_convergencia = true;  % true: grafica It vs. w
    opcion_grafico_escala = 'normal';% 'log' o 'normal'
                                     % (Se recomienda 'normal' para It vs w)
    opcion_grafico_estilo = '-xb'; % Estilo de línea
    opcion_grafico_pausa = false;  % true: ejecuta 'pause' después de graficar

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    % 1. Intento utilizar la fórmula de ω óptimo (Método Teórico)
    try
        % (Se asume que las funciones de chequeo están en modo silencioso
        %  editándolas manualmente, o usando analizar_convergencia.m)
        if (esDefinidaPositiva(A) && esTridiagonal(A))
            if (opcion_verbose >= 1)
                printf("wOptimo: Matriz es Tridiagonal y Def. Positiva. Usando fórmula...\n");
            endif

            rho_j = RadioEspectral(A, 'ja', []);
            w = 2 / (1 + sqrt(1 - (rho_j^2)));

            if (opcion_verbose >= 1)
                printf("wOptimo (Teórico) = %f\n", w);
            endif

            if (medir_tiempo)
                tiempo_ejecucion = toc(tic_handle);
                printf("  Tiempo: %f s\n", tiempo_ejecucion);
            endif
            return;
        endif
    catch err
        if (opcion_verbose >= 2)
            printf("wOptimo: Falla chequeo teórico (o dependencia). Pasando a fuerza bruta.\n");
        endif
    end

    % 2. Prueba por fuerza bruta (si el método teórico no aplicó)

    % Generamos el rango de w usando el paso configurado
    w_range = 0.01 : opcion_bruteforce_paso : opcion_bruteforce_max_w;

    if (opcion_verbose >= 1)
        printf("wOptimo: Matriz no cumple requisitos. Usando fuerza bruta (%d intentos con saltos de %g)...\n", ...
               length(w_range), opcion_bruteforce_paso);
    endif

    it_hist = zeros(size(w_range));
    it_hist(:) = maxit + 1;

    for j = 1:length(w_range)
        % (Ver NOTA IMPORTANTE en el Ejemplo 2)
        [~, it_j, r_h] = sor(A, b, x0, maxit, tol, w_range(j));
        it_hist(j) = it_j;

        if (opcion_verbose == 2)
            printf("  Probando w = %f ... Iteraciones = %d\n", w_range(j), it_j);
        endif
    endfor

    % Encontrar el mínimo
    [it_min, p_min] = min(it_hist);
    w = w_range(p_min);

    if (opcion_verbose >= 1)
        printf("wOptimo (Fuerza Bruta) = %f (logró %d iteraciones)\n", w, it_min);

        if (it_min > maxit)
           printf("ADVERTENCIA: La 'fuerza bruta' no encontró ningún 'w' convergente.\n");
        endif
    endif

    % --- Reporte Final (Tiempo) ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        printf("  Tiempo total de búsqueda: %f s\n", tiempo_ejecucion);
    endif

    % --- Gráficos (Fuerza Bruta) ---
    if (graficar_convergencia && exist('w_range', 'var'))
        figure;
        if (strcmp(opcion_grafico_escala, 'log'))
            semilogy(w_range, it_hist, opcion_grafico_estilo);
        else
            plot(w_range, it_hist, opcion_grafico_estilo);
        endif

        hold on;
        plot(w, it_min, 'pr', 'MarkerSize', 12, 'MarkerFaceColor', 'red');
        legend('Iteraciones vs w', 'w Óptimo');
        hold off;

        grid on;
        % Ajuste de eje Y para ver mejor los valles (ignora los maxit+1)
        max_y_visible = max(it_hist(it_hist <= maxit));
        if isempty(max_y_visible) max_y_visible = maxit; endif
        ylim([0, max_y_visible * 1.1 + 1]);

        title("SOR: Búsqueda de w Óptimo (Fuerza Bruta)");
        xlabel("Valor de w (Relajación)");
        ylabel("Número de Iteraciones");

        if (opcion_grafico_pausa)
            disp("Presione Enter para continuar...");
            pause;
        endif
    endif

endfunction

% --- Ejemplo 1: Caso Teórico (Matriz Tridiagonal DP) (Seleccionar y presionar F9) ---
% % NOTA: Requiere DescomponerMatriz, RadioEspectral, esDefinidaPositiva, esTridiagonal
%
%
% n = 40;
% A = diag(2*ones(n,1), 0) + diag(-1*ones(n-1,1), 1) + diag(-1*ones(n-1,1), -1);
% b = zeros(n,1);
% x0 = zeros(n,1);
% tol = 1e-5;
% maxit = 100;
%
% w_opt_teo = wOptimo(A, b, x0, tol, maxit)

% --- Resultado Esperado (Ejemplo 1) ---
% (Salida de esDefinidaPositiva, esTridiagonal en modo verbose=1)
% wOptimo: Matriz es Tridiagonal y Def. Positiva. Usando fórmula...
% (Salida de RadioEspectral en modo verbose=1)
% wOptimo (Teórico) = 1.857788
%   Tiempo: ... s
% w_opt_teo = 1.857788

% --- Ejemplo 2: Caso Fuerza Bruta (Matriz Parcial 1 2025) (Seleccionar y presionar F9) ---
%
% % NOTA IMPORTANTE:
% % Antes de correr este ejemplo (Fuerza Bruta),
% % debes editar manualmente el archivo 'sor.m' y cambiar
% % sus Configuraciones Internas a:
% %
% %   opcion_verbose = 0;
% %   graficar_convergencia = false;
% %
% % (Atajo: ejecutar "edit sor.m", ir a líneas 20 y 30, guardar)
% % Si no lo haces se imprimen como 100 resúmenes y se abren 100 gráficos.
%
% A = [2 0 1 0 -2; 1 1 1 1 -1; -2 2 2 -2 1; -1 0 1 2 2; -1 2 2 -1 2];
% b = [4; 0; 1; 3; -1];
% x0 = [0; 0; 0; 0; 0];
% maxit = 100;
% tol = 1e-4;

% w_opt_fb = wOptimo(A, b, x0, tol, maxit)

% --- Resultado Esperado (Ejemplo 2) ---
% (Salida de esDefinidaPositiva, esTridiagonal)
% wOptimo: Matriz no cumple requisitos. Usando fuerza bruta (40 intentos con saltos de 0.05)...
% wOptimo (Fuerza Bruta) = 0.81 (logró X iteraciones)
%   Tiempo total de búsqueda: ... s
% w_opt_fb = 0.81
% (Abre una gráfica de It vs w, con un valle cerca de 1.06)
