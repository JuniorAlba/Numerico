function [a,b,c,d] = cubic_spline_natural(x,y)
  % 1. PREPARACIÓN
  x = x(:); 
  y = y(:);
  n = length(x);
  
  h = x(2:n) - x(1:n-1); 

  % 2. ARMADO DE MATRIZ A (CORREGIDO)
  % Inicializamos A vacía de tamaño correcto
  A = zeros(n,n);

  % a) Diagonal Principal
  dp = ones(n,1);
  dp(2:n-1) = 2*(h(1:n-2) + h(2:n-1)); 
  A = diag(dp); % A ahora es 21x21 con la diagonal llena

  % b) Diagonal Inferior (usando inserción directa para evitar error de tamaño)
  % Insertamos en las filas 2 hasta n-1, columnas 1 hasta n-2
  A(2:n-1, 1:n-2) = A(2:n-1, 1:n-2) + diag(h(1:n-2));

  % c) Diagonal Superior
  % Insertamos en las filas 2 hasta n-1, columnas 3 hasta n
  A(2:n-1, 3:n) = A(2:n-1, 3:n) + diag(h(2:n-1));

  % 3. LADO DERECHO (Z)
  z = zeros(n,1);
  term1 = (y(3:n) - y(2:n-1)) ./ h(2:n-1);
  term2 = (y(2:n-1) - y(1:n-2)) ./ h(1:n-2);
  z(2:n-1) = 3 * (term1 - term2);
  
  z(1) = 0; 
  z(n) = 0;

  % 4. SOLUCIÓN Y COEFICIENTES
  c = A\z; 

  d = (c(2:n) - c(1:n-1)) ./ (3 * h);
  b = (y(2:n) - y(1:n-1)) ./ h - h .* (c(2:n) + 2*c(1:n-1))/3;
  a = y(1:n-1); % Esto ya funciona bien porque y es columna
  c = c(1:n-1);

endfunction