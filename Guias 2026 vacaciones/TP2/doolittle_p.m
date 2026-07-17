% Factorizacion LU de una matriz A mediante el metodo de Doolittle con pivoteo parcial.
% Recibe: A (matriz cuadrada a factorizar)
% Devuelve: L (matriz triangular inferior con unos en la diagonal), U (matriz triangular superior), A (matriz modificada), P (matriz de permutacion), r (vector de permutaciones)
function [L,U,A,P,r] = doolittle_p(A)
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
  L=tril(A,-1)+eye(n);
  U=triu(A);
  P = eye(n)(r,:);
end
