function A = doolittle(A)
  % Calcula la factorizacion LU de la matriz A sin pivoteo.
  % La matriz A se sobreescribe con L (multiplicadores) y U (matriz triangular superior).
  % Recibe: A (matriz cuadrada)
  % Devuelve: A (matriz factorizada, L y U superpuestas)
  n = size(A, 1);
  for k = 1:n-1
    A(k+1:n, k) = A(k+1:n, k) / A(k, k);
    A(k+1:n, k+1:n) = A(k+1:n, k+1:n) - A(k+1:n, k) * A(k, k+1:n);
  end
end
