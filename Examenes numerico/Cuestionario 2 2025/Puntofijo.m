function [x, h, it] = Puntofijo(g, x0,  maxit, tol)
  #HECHO POR MI
  for it=1:maxit
    x = g(x0);
    h(it) = abs(x-x0);
    if h(it)<tol
      break;
    endif
    x0=x;
endfor

