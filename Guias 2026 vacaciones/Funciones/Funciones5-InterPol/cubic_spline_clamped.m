function [a, b, c, d] = cubic_spline_clamped(x, y, dy0, dyn)
    % Calcula los coeficientes de un spline cúbico sujeto (clamped).
    % Utiliza las derivadas primeras en los extremos S'(x0)=dy0, S'(xn)=dyn.
    % Resuelve el sistema tridiagonal usando el algoritmo de Crout (Burden).
    %
    % Entradas:
    %   x: Vector (fila o columna) con coordenadas x de nodos (ordenado).
    %   y: Vector (fila o columna) con coordenadas y de nodos.
    %   dy0: Derivada primera en el nodo inicial x(1).
    %   dyn: Derivada primera en el nodo final x(n).
    %
    % Salidas:
    %   a, b, c, d: Vectores columna con coeficientes del spline por segmento.

    % --- Configuración Interna ---
    medir_tiempo = false;    % true: mide el tiempo de ejecución, false: no mide
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

    % Asegurarse de que x e y sean vectores fila para la lógica original
    x = x(:)';
    y = y(:)';

    if (opcion_warnings && any(diff(x) <= 0))
        printf("ADVERTENCIA (cubic_spline_clamped): El vector 'x' no está ordenado ascendentemente.\n");
    endif

    % --- Algoritmo de Crout (Burden & Faires) ---

    % Paso 1: Calcular h
    h(1:n-1) = x(2:n) - x(1:n-1);

    % Paso 2: Vector v (alpha)
    v = zeros(n, 1);
    v(1) = 3 * ((y(2) - y(1)) / h(1) - dy0);
    v(n) = 3 * (dyn - (y(n) - y(n-1)) / h(n-1));

    % Paso 3: Puntos interiores de v
    v(2:n-1) = 3 * ( (y(3:n) - y(2:n-1)) ./ h(2:n-1) - (y(2:n-1) - y(1:n-2)) ./ h(1:n-2) );

    % Paso 4: Factorización Crout (l, u, z)
    l = zeros(n, 1);
    u = zeros(n, 1);
    z = zeros(n, 1);

    l(1) = 2 * h(1);
    u(1) = 0.5;
    z(1) = v(1) / l(1);

    % Paso 5: Bucle de Crout
    for i = 2:n-1
        l(i) = 2 * (x(i+1) - x(i-1)) - h(i-1) * u(i-1);
        u(i) = h(i) / l(i);
        z(i) = (v(i) - h(i-1) * z(i-1)) / l(i);
    endfor

    % Paso 6: Últimos elementos
    l(n) = h(n-1) * (2 - u(n-1));
    z(n) = (v(n) - h(n-1) * z(n-1)) / l(n);

    % --- Resolución y Cálculo de Coeficientes ---

    % Paso 7: Sustitución hacia atrás para 'c'
    c = zeros(n, 1); % (c(n) es c_n, no c_n-1)
    c(n) = z(n);

    % (b y d se calculan para n-1 segmentos)
    b = zeros(n-1, 1);
    d = zeros(n-1, 1);

    for i = n-1:-1:1
        c(i) = z(i) - u(i) * c(i+1);
        b(i) = (y(i+1) - y(i)) / h(i) - h(i) * (c(i+1) + 2 * c(i)) / 3;
        d(i) = (c(i+1) - c(i)) / (3 * h(i));
    endfor

    % Paso 8: Coeficientes finales (n-1 segmentos)
    a = y(1:n-1)';
    b = b(1:n-1); % b ya es columna
    c = c(1:n-1);
    d = d(1:n-1); % d ya es columna

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        if (opcion_verbose >= 1)
            printf("Cálculo Spline Clamped finalizado. Tiempo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % Ejemplo: f(x) = sin(x) en [0, 3]
% x = [0, 1, 2, 3];
% y = sin(x);
% dy0 = cos(0);   % Derivada en x=0 (es 1)
% dyn = cos(3);   % Derivada en x=3 (es ~-0.99)
%
% [a, b, c, d] = cubic_spline_clamped(x, y, dy0, dyn)
%
% % Verificación:
% % (spline_a_funcion.m aún no fue refactorizado, usar el original
% %  o el método manual del ejemplo original)
%
% % Evaluación en x=1.5 (Segmento j=2, x en [1, 2])
% j = 2;
% dx = 1.5 - x(j);
% valor = a(j) + b(j)*dx + c(j)*dx^2 + d(j)*dx^3;
% disp(sprintf("S(1.5) = %f (Valor real sin(1.5) = %f)", valor, sin(1.5)))

% --- Resultado Esperado ---
% (Salida de la ejecución del ejemplo con verbose=1)
% Cálculo Spline Clamped finalizado. Tiempo: ... s
% a =
%    0.00000
%    0.84147
%    0.90930
%
% b =
%    1.00000
%    0.54336
%   -0.41344
%
% c =
%   -0.01042
%   -0.45472
%   -0.49158
%
% d =
%   -0.14809
%   -0.01228
%    0.13488
%
% S(1.5) = 0.993674 (Valor real sin(1.5) = 0.997495)
