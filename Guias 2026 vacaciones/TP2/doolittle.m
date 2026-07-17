% Factorizacion LU de una matriz A mediante el metodo de Doolittle (sin pivoteo).
% Recibe: A (matriz cuadrada a factorizar)
% Devuelve: L (matriz triangular inferior con unos en la diagonal), U (matriz triangular superior)
function [L,U] = doolittle(A)
  n=length(A);
  for k=1:n-1
    % almaceno los multiplicadores
    A(k+1:n,k) = A(k+1:n,k)/A(k,k);
    % realizo operaciones elementales
    A(k+1:n,k+1:n) = A(k+1:n,k+1:n)-A(k+1:n,k)*A(k,k+1:n);
  endfor
  L=tril(A,-1)+eye(n);
  U=triu(A);
end