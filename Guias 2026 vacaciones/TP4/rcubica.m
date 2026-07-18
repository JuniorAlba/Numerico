% Calcula la raíz cúbica de 'a' con error relativo menor a 10^-12 usando el método de bisección.
% Recibe: a (número real a calcularle la raíz).
% Devuelve: r (raíz cúbica de a).
function [r] = rcubica(a)
  a_m = abs(a);
  f = @(x) x^(3)-a_m;
  if a_m>1
    a1 = 1;
    b1 = a_m;
  else
    b1=1;
    a1 = 0;
  endif
  tol = 1e-12;
  [p, h, it] = biseccion(f, a1, b1, 500, tol);
  if a < 0
    r = -1 * p;
  else
    r = p;
  endif
endfunction
