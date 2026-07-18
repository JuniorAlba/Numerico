% Resuelve el problema g(x)=x mediante iteración de punto fijo.
% Recibe: g (función de iteración), x0 (estimación inicial), kmax (iteraciones máximas), tol (tolerancia).
% Devuelve: x (aproximación del punto fijo), h (vector de errores absolutos), it (cantidad de iteraciones).
function [x, h, it] = puntofijo(g, x0, kmax, tol)
  for it=1:kmax
    x = g(x0);
    h(it) = abs(x-x0);
    if h(it)<tol
      break;
    endif
    x0=x;
endfor

