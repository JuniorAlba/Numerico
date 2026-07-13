function [A, r] = doolittle_p(A)
  % Calcula la factorizacion LU de la matriz A con pivoteo parcial.
  % La matriz A se sobreescribe con los multiplicadores L y la matriz U.
  % Recibe: A (matriz cuadrada)
  % Devuelve: A (matriz factorizada desordenada) y r (vector de permutaciones)
  n = size(A, 1);
  r = 1:n;
  for k = 1:n-1
    [~, p] = max(abs(A(r(k:n), k)));
    p = p + k - 1;
    if p ~= k
      r([p k]) = r([k p]);
    end
    A(r(k+1:n), k) = A(r(k+1:n), k) / A(r(k), k);
    A(r(k+1:n), k+1:n) = A(r(k+1:n), k+1:n) - A(r(k+1:n), k) * A(r(k), k+1:n);
  end
end
