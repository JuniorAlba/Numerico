function [L] = cholesky(A)
% Solo sirve si A es Simétrica y Definida Positiva (SDP).
  lambda = eig(A);

  if lambda < 0
    error('matriz no definida positivamente')
  endif

  if A ~= A'
    error('matriz no simetrica')
  endif

  n = length(A(:,1));
  L=zeros(n);

  L(1,1)= sqrt(A(1,1));

  for i=2:n
    L(i,1) = A(i,1)/L(1,1);
  endfor

  for i = 2:n-1
    L(i,i) = sqrt(A(i,i) - sum(L(i,1:i-1).^2));

    for j = i+1:n
      #L(variable, rango de sigma)
      L(j,i) = (A(j,i)- sum(L(j,1:i-1) .* L(i,1:i-1)))/L(i,i);
    endfor
  endfor

  L(n,n)= sqrt(A(n,n)- sum(L(n,1:n-1).^2));


