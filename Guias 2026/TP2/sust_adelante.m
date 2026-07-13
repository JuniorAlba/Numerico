function x = sust_adelante(A, b)
  % Resuelve un sistema triangular inferior A*x=b mediante sustitucion hacia adelante.
  % Recibe: A (matriz triangular inferior), b (vector de terminos independientes)
  % Devuelve: x (vector solucion)
  n = length(b);
  x = zeros(n, 1);
  for i = 1:n
    x(i) = (b(i) - A(i, 1:i-1) * x(1:i-1)) / A(i, i);
  end
end
