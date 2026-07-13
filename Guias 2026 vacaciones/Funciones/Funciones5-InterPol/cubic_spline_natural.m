function [a, b, c, d] = cubic_spline_natural(x, y)
    % Calcula los coeficientes de un spline cúbico natural (S''(x0)=0, S''(xn)=0).
    %
    % Entradas:
    %   x: Vector (fila o columna) con coordenadas x de nodos (debe estar ordenado).
    %   y: Vector (fila o columna) con coordenadas y de nodos.
    %
    % Salidas:
    %   a, b, c, d: Vectores columna con coeficientes del spline por segmento.
    %   Spline en segmento j: S_j(t) = a_j + b_j(t - x_j) + c_j(t - x_j)^2 + d_j(t - x_j)^3

    % --- Configuración Interna ---
    medir_tiempo = true;    % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;     % 0: Silencioso, 1: Muestra tiempo de ejecución
    opcion_warnings = true; % true: Muestra advertencias

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    n = length(x);

    % --- Validaciones ---
    if (n != length(y))
        error("Los vectores 'x' e 'y' deben tener la misma longitud.");
    endif

    % Asegurarse de que x e y sean vectores columna para los cálculos
    x = x(:);
    y = y(:);

    if (opcion_warnings && any(diff(x) <= 0))
        printf("ADVERTENCIA (cubic_spline_natural): El vector 'x' no está ordenado ascendentemente.\n");
    endif

    % Vector de diferencias entre nodos consecutivos
    h = x(2:n) - x(1:n-1); % h(j) = x(j+1)-x(j)

    % --- Armado de Matriz A (Tridiagonal) ---
    % (¡CORREGIDO! Volviendo a la lógica original que sí funciona)

    A = zeros(n, n);   % Matriz principal
    Aup = zeros(n, n); % Matriz para la diagonal superior

    % Diagonal principal
    dp = ones(n, 1);
    dp(2:n-1) = 2 * (h(1:n-2) + h(2:n-1)); % Puntos interiores

    % Diagonal Inferior
    A(2:n-1, 1:n-2) = diag(h(1:n-2));

    % Diagonal Superior
    Aup(2:n-1, 3:n) = diag(h(2:n-1));

    % Armo la matriz A
    A = A + Aup + diag(dp);

    % --- Armado de Vector z ---
    z = zeros(n, 1);

    % Puntos interiores
    z(2:n-1) = 3 * ( (y(3:n) - y(2:n-1)) ./ h(2:n-1) - (y(2:n-1) - y(1:n-2)) ./ h(1:n-2) );

    % z(1) = 0 y z(n) = 0 (Condiciones de Spline Natural)

    % --- Resolución del Sistema Ac = z ---
    c = A \ z; % Usamos el metodo directo de Octave.

    % --- Cálculo de coeficientes b, d, a ---
    % (Se calculan para n-1 segmentos)

    % Coeficientes d
    d = (c(2:n) - c(1:n-1)) ./ (3 * h);

    % Coeficientes b
    b = ( (y(2:n) - y(1:n-1)) ./ h ) - h .* (c(2:n) + 2 * c(1:n-1)) / 3;

    % Coeficientes a (S_j(x_j) = y_j)
    a = y(1:n-1);

    % Coeficientes c (truncar al último segmento)
    c = c(1:n-1);

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Cálculo Spline Natural finalizado. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% x = [1, 2, 3, 4];
% y = [0.5, 1, 2, 1.5];
%
% [a, b, c, d] = cubic_spline_natural(x, y)
%
% % --- Verificación Manual ---
% % (Para evaluar el spline en x=1.5, usamos el segmento j=1)
% j = 1;
% x_eval = 1.5;
% dx = x_eval - x(j);
%
% S_de_1_5 = a(j) + b(j)*dx + c(j)*(dx^2) + d(j)*(dx^3)

% --- Resultado Esperado ---
% (El output de la función)
% Cálculo Spline Natural finalizado. Tiempo: ... s
% a =
%    0.50000
%    1.00000
%    2.00000
% b =
%    0.26667
%    0.96667
%    0.36667
% c =
%    0.00000
%    0.70000
%   -1.30000
% d =
%    0.23333
%   -0.66667
%    0.43333
%
% (El output de la verificación)
% S_de_1_5 = 0.66562
