function [L, U, A, r, P] = doolitle_p(A)
  n = size(A, 1);
  r = 1:n;
  for k = 1:n-1
    [pmax, p] = max(abs(A(r(k:n), k)));
    p = p + k - 1;
    if p ~= k
      r([p k]) = r([k p]);
    endif
    P = eye(length(r))(r, :);
    A(r(k+1:n), k) = A(r(k+1:n), k)/A(r(k), k);
    A(r(k+1:n), k+1:n) = A(r(k+1:n), k+1:n) - A(r(k+1:n), k) * A(r(k), k+1:n);
  endfor

  C = P*A;
  L = eye(n)+tril(C,-1);
  U = triu(C);
endfunction
