function [S, dS, ddS] = funcion_spline(x1, y1, df1, df2)
    % funcion_spline: Genera handles de función para un spline cúbico
    % y sus derivadas (S, S', S'').
    %
    % Selecciona automáticamente el tipo de spline:
    %   - Natural: Si se proveen 2 argumentos (x, y).
    %   - Sujeto (Clamped): Si se proveen 4 argumentos (x, y, df0, dfn).
    %
    % Entradas:
    %   x1: Vector de nodos.
    %   y1: Vector de valores en los nodos.
    %   df1: (Opcional) Derivada primera en x1(1).
    %   df2: (Opcional) Derivada primera en x1(end).
    %
    % Salidas:
    %   S: Handle de la función del spline, S(x).
    %   dS: Handle de la primera derivada, S'(x).
    %   ddS: Handle de la segunda derivada, S''(x).
    %
    % Dependencias:
    %   Requiere 'cubic_spline_natural.m' o 'cubic_spline_clamped.m'.

    % --- Configuración Interna ---
    medir_tiempo = false;    % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;     % 0: Silencioso, 1: Muestra tiempo y tipo

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    % --- Selección de Tipo de Spline ---
    if (nargin == 2)
        % Spline Natural
        if (opcion_verbose >= 1)
             printf("Generando handles para Spline Natural...\n");
        endif
        [a, b, c, d] = cubic_spline_natural(x1, y1);

        % Definir valor de la derivada en el punto inicial (S''(x1) = 0)
        % S'(x1) = b(1)
        dS_inicial = @(x) b(1) * (x == x1(1));

    elseif (nargin == 4)
        % Spline Sujeto (Clamped)
        if (opcion_verbose >= 1)
             printf("Generando handles para Spline Sujeto (Clamped)...\n");
        endif
        [a, b, c, d] = cubic_spline_clamped(x1, y1, df1, df2);

        % Definir valor de la derivada en el punto inicial (dada por df1)
        dS_inicial = @(x) df1 * (x == x1(1));

    else
        error("Número de argumentos incorrecto. Usar 2 para Natural o 4 para Sujeto.");
    endif

    % --- Construcción de Handles de Funciones ---

    % Matriz de coeficientes para polyval (formato [d, c, b, a])
    M = [d(:), c(:), b(:), a(:)];

    % Inicializar funciones anónimas
    % (Se usa el valor en el primer nodo para manejar x == x1(1))
    S = @(x) a(1) * (x == x1(1));
    dS = dS_inicial; % (Ya definido arriba)
    ddS = @(x) (2 * c(1)) * (x == x1(1)); % S''(x1) = 2*c1

    dM = [];
    ddM = [];

    % Bucle para construir las funciones por tramos
    for i = 1:length(x1) - 1
        % Calcular polinomios derivados
        dM(i, :) = polyder(M(i, :));
        ddM(i, :) = polyder(dM(i, :));

        % Máscara para el intervalo (x_i, x_i+1]
        mask = @(x) (x > x1(i)) & (x <= x1(i+1));

        % Diferencial dx
        dx = @(x) x - x1(i);

        % Acumular el tramo actual en la función handle
        S = @(x) S(x) + polyval(M(i, :), dx(x)) .* mask(x);
        dS = @(x) dS(x) + polyval(dM(i, :), dx(x)) .* mask(x);
        ddS = @(x) ddS(x) + polyval(ddM(i, :), dx(x)) .* mask(x);
    endfor

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Handles S(x), dS(x), ddS(x) generados. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % (Se asume que las funciones 'cubic_spline_...' están en el path)
% % (Se recomienda ponerlas en modo silencioso (verbose=0))
%
% % --- 1. Datos de Prueba (sin(x)) ---
% x = [0, pi/2, pi, 3*pi/2, 2*pi];
% y = sin(x);
% dy0 = cos(0);   % Derivada en x=0
% dyn = cos(2*pi); % Derivada en x=2*pi
%
% % --- 2. Generar Handles ---
% disp("--- Probando Spline Natural ---")
% [S_nat, dS_nat, ddS_nat] = funcion_spline(x, y);
%
% disp("--- Probando Spline Sujeto ---")
% [S_clamp, dS_clamp, ddS_clamp] = funcion_spline(x, y, dy0, dyn);
%
% % --- 3. Evaluar en un punto ---
% t_eval = pi/4; % (0.785...)
% S_val = S_clamp(t_eval)
% dS_val = dS_clamp(t_eval)
% ddS_val = ddS_clamp(t_eval)
%
% % --- 4. Verificación (Valores reales) ---
% S_real = sin(t_eval)
% dS_real = cos(t_eval)
% ddS_real = -sin(t_eval)

% --- Resultado Esperado ---
% --- Probando Spline Natural ---
% Generando handles para Spline Natural...
% Handles S(x), dS(x), ddS(x) generados. Tiempo: ... s
%
% --- Probando Spline Sujeto ---
% Generando handles para Spline Sujeto (Clamped)...
% Handles S(x), dS(x), ddS(x) generados. Tiempo: ... s
%
% S_val = 0.69887
% dS_val = 0.70814
% ddS_val = -0.64481
%
% S_real = 0.70710
% dS_real = 0.70710
% ddS_real = -0.70710
% (El spline sujeto con f(x)=sin(x) es muy preciso en este caso)
