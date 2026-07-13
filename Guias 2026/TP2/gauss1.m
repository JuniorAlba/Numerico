function x = gauss1(A, b)
  % Resuelve un sistema de ecuaciones lineales A*x=b mediante eliminacion de Gauss sin pivoteo.
  % Recibe: A (matriz de coeficientes), b (vector de terminos independientes)
  % Devuelve: x (vector solucion)
  n = length(b);
  A = [A, b]; % Matriz ampliada
  for k = 1:n-1
    m = A(k+1:n, k) / A(k, k);
    A(k+1:n, k) = 0; % Opcional, pero util para visualizar
    A(k+1:n, k+1:n+1) = A(k+1:n, k+1:n+1) - m * A(k, k+1:n+1);
  end
  x = sust_atras(A(:, 1:n), A(:, n+1));
end