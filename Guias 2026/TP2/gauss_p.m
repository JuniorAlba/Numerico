function [x, r] = gauss_p(A, b)
  % Resuelve un sistema de ecuaciones A*x=b mediante eliminacion de Gauss con pivoteo parcial.
  % Recibe: A (matriz de coeficientes), b (vector de terminos independientes)
  % Devuelve: x (vector solucion), r (vector de permutaciones de filas)
  n = length(b);
  A = [A, b];
  r = 1:n;
  for k = 1:n-1
    [~, p] = max(abs(A(r(k:n), k)));
    p = p + k - 1;
    if p ~= k
      r([p k]) = r([k p]);
    end
    m = A(r(k+1:n), k) / A(r(k), k);
    A(r(k+1:n), k) = 0; 
    A(r(k+1:n), k+1:n+1) = A(r(k+1:n), k+1:n+1) - m * A(r(k), k+1:n+1);
  end
  x = sust_atras(A(r, 1:n), A(r, n+1));
end
