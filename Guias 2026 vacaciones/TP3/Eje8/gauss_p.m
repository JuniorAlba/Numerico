function [A,x] = gauss_p(A,b)
  n = length(b);
  A = [A b];
  r = 1:n;
  epsilon = 1e-9;
  for k = 1:n-1
    [pmax, p] = max(abs(A(r(k:n),k)));
    if pmax<epsilon
      disp('Los posibles pivots son CERO')
      break
    endif
    p = p + k -1;
    if p~=k
      r([p k]) = r([k p]);
    endif
    A(r(k+1:n),k) = A(r(k+1:n),k)/A(r(k),k);
    %se realiza la misma resta sobre todas las filas debido a que
    %no sabemos cual sera seleccionada como pivote en la siguiente iteracion
    A(r(k+1:n),k+1:n+1) =  A(r(k+1:n),k+1:n+1) - A(r(k+1:n),k)*(A(r(k),k+1:n+1));
  endfor
  x=sust_atras_vec((A(r,1:end-1)),A(r,end));
  A=triu(A);

