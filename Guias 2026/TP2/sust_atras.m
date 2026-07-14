% Resuelve un sistema triangular superior A*x=b mediante sustitucion hacia atras.
% Recibe: A (matriz triangular superior), b (vector de terminos independientes)
% Devuelve: x (vector solucion)
function x=sust_atras(A,b)
  n=length(b);
  x=zeros(n,1);
  x(n)=b(n)/A(n,n);
  for i = n-1:-1:1
    x(i) = (b(i)-A(i,i+1:n)*x(i+1:n))/A(i,i);
  endfor
end
