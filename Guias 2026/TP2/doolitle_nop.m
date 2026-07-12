function [L,U] = doolitle_nop(A)
  n = length(A(:,end));
  for k=1:1:n
        A(k+1:n,k) = A(k+1:n,k)/A(k,k);
        A(k+1:n,k+1:n) = A(k+1:n,k+1:n) - A(k+1:n,k)*A(k,k+1:n);
       % A(k+1,k+1:n) = A(k+1,k+1:n) - b*A(k+1:n,k)';
  endfor
  L = eye(n)+tril(A,-1);
  U = triu(A);
endfunction


