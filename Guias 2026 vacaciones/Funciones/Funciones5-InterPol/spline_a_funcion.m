function [S, dS, ddS] = spline_a_funcion(x_nodes, a, b, c, d)
    % spline_a_funcion: Convierte coeficientes (a,b,c,d) de un spline
    % en handles de función evaluables (S, S', S'').
    % (Esta versión es más directa si ya se tienen los coeficientes).
    %
    % Entradas:
    %   x_nodes: Vector de nodos ordenados.
    %   a, b, c, d: Coeficientes del spline (vectores columna o fila).
    %
    % Salidas:
    %   S: Handle de la función del spline, S(x).
    %   dS: Handle de la primera derivada, S'(x).
    %   ddS: Handle de la segunda derivada, S''(x).

    % --- Configuración Interna ---
    medir_tiempo = false;    % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;     % 0: Silencioso, 1: Muestra tiempo

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    % Forzar coeficientes a ser vectores columna
    a = a(:); b = b(:); c = c(:); d = d(:);

    n = length(a); % Número de segmentos

    % Validar que los nodos coincidan con los segmentos
    if (length(x_nodes) < n + 1)
        error("Se necesitan al menos %d nodos para %d segmentos.", n + 1, n);
    endif

    M = [d c b a]; % Coeficientes en formato polyval [x^3 x^2 x^0 x^1]

    % Inicializar funciones con zeros (para manejo vectorizado)
    S = @(x) zeros(size(x));
    dS = @(x) zeros(size(x));
    ddS = @(x) zeros(size(x));

    for i = 1:n
        % Definir intervalo de activación
        mask = @(x) (x > x_nodes(i)) & (x <= x_nodes(i+1));
        dx = @(x) x - x_nodes(i);

        % Actualizar Spline
        S = @(x) S(x) + polyval(M(i, :), dx(x)) .* mask(x);

        % Calcular y actualizar derivadas
        d_poly = polyder(M(i, :));
        dS = @(x) dS(x) + polyval(d_poly, dx(x)) .* mask(x);

        dd_poly = polyder(d_poly);
        ddS = @(x) ddS(x) + polyval(dd_poly, dx(x)) .* mask(x);
    endfor

    % Manejar punto inicial exacto (x == x_nodes(1))
    S = @(x) S(x) + a(1) .* (x == x_nodes(1));

    % Manejar derivada en el punto inicial
    % (Se asume S'(x1) = b(1), S''(x1) = 2*c(1), típico de Crout/Natural)
    dS = @(x) dS(x) + b(1) .* (x == x_nodes(1));
    ddS = @(x) ddS(x) + (2*c(1)) .* (x == x_nodes(1));

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Handles (desde coefs) S(x), dS(x), ddS(x) generados. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % (Se asume que 'cubic_spline_natural.m' está en el path)
% % (Se recomienda ponerlo en modo silencioso (verbose=0))
%
% % 1. Generar coeficientes (ejemplo)
% x = [0, pi/2, pi, 3*pi/2];
% y = sin(x);
% [a, b, c, d] = cubic_spline_natural(x, y);
%
% % 2. Generar handles desde los coeficientes
% [S, dS, ddS] = spline_a_funcion(x, a, b, c, d);
%
% % 3. Evaluar en múltiples puntos
% xx = linspace(0, 3*pi/2, 50);
% yy = S(xx);
% dyy = dS(xx);
% ddyy = ddS(xx);
%
% % 4. Gráficos (usando subplots)
% figure;
% subplot(3, 1, 1);
% plot(xx, yy, 'b-');
% hold on;
% plot(x, y, 'ro', 'MarkerFaceColor', 'r');
% hold off;
% title('Spline S(x)');
% grid on;
%
% subplot(3, 1, 2);
% plot(xx, dyy, 'g--');
% title('Primera Derivada dS(x)');
% grid on;
%
% subplot(3, 1, 3);
% plot(xx, ddyy, 'm:');
% title('Segunda Derivada ddS(x)');
% grid on;
% xlabel('x');

% --- Resultado Esperado ---
% (Salida de cubic_spline_natural)
% Handles (desde coefs) S(x), dS(x), ddS(x) generados. Tiempo: ... s
% (Se abre una figura con 3 gráficas: el spline, su derivada 1ra y su derivada 2da)
