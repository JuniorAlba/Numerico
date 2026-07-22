% Construye un trazador cúbico sujeto (clamped cubic spline) para un conjunto de puntos.
% Recibe: x, y (vectores de coordenadas), dy0 (derivada en el primer punto), dyn (derivada en el último punto).
% Devuelve: a, b, c, d (vectores con los coeficientes de los polinomios cúbicos por tramos).
function [a,b,c,d] = cubic_spline_clamped(x,y,dy0,dyn)
    % 1. Forzar columnas para evitar errores de dimensión
    x = x(:);
    y = y(:);
    n = length(x);
    
    % h calculado como columna
    h = x(2:n) - x(1:n-1);
    
    % Inicializamos vectores columna
    v = zeros(n,1);
    
    % 2. Cálculo de v (lado derecho del sistema)
    % Ahora todas las operaciones son Columna - Columna
    term_0 = (y(2) - y(1)) / h(1);
    v(1) = 3 * (term_0 - dy0);
    
    term1 = (y(3:n) - y(2:n-1)) ./ h(2:n-1);
    term2 = (y(2:n-1) - y(1:n-2)) ./ h(1:n-2);
    v(2:n-1) = 3 * (term1 - term2);
    
    term_n = (y(n) - y(n-1)) / h(n-1);
    v(n) = 3 * (dyn - term_n);
    
    % 3. Algoritmo de Crout (Tridiagonal)
    l = zeros(n,1);
    u = zeros(n,1);
    z = zeros(n,1);
    
    l(1) = 2 * h(1);
    u(1) = 0.5;
    z(1) = v(1) / l(1);
    
    for i = 2:n-1
        l(i) = 2 * (x(i+1) - x(i-1)) - h(i-1) * u(i-1);
        u(i) = h(i) / l(i);
        z(i) = (v(i) - h(i-1) * z(i-1)) / l(i);
    endfor
    
    l(n) = h(n-1) * (2 - u(n-1));
    z(n) = (v(n) - h(n-1) * z(n-1)) / l(n);
    
    % 4. Back substitution
    c = zeros(n,1);
    b = zeros(n,1);
    d = zeros(n,1);
    
    c(n) = z(n);
    for i = n-1:-1:1
        c(i) = z(i) - u(i) * c(i+1);
        b(i) = (y(i+1) - y(i)) / h(i) - h(i) * (c(i+1) + 2 * c(i)) / 3;
        d(i) = (c(i+1) - c(i)) / (3 * h(i));
    endfor
    
    % Salida de coeficientes (recortamos el último c para que coincida con n-1 tramos)
    a = y(1:n-1);
    b = b(1:n-1);
    c = c(1:n-1);
    d = d(1:n-1);
endfunction