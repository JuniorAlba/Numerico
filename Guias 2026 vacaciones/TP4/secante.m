% Resuelve la ecuación no lineal f(x)=0 usando el método de la secante.
% Recibe: f (función), xmin y xmax (estimaciones iniciales), kmax (iteraciones máximas), tol (tolerancia).
% Devuelve: x (aproximación de la raíz), h (vector de errores relativos), it (cantidad de iteraciones).
function [x, h, it] = secante(f, xmin, xmax, kmax, tol)
  fmin = f(xmin);
  fmax = f(xmax);
  #No es una condicion necesaria pero mejora las chances de convergencia del metodo
  #if sign(fmax)*sign(fmin) > 0
  #  error(' Los limites del intervalo medidos en f son del mismo signo');
  #endif
  for it=1:kmax
    x = xmax - ((xmax-xmin)*fmax)/(fmax-fmin);
    h(it) = abs(x-xmax)/abs(x);
    if h(it)<tol
      break;
    endif
    xmin = xmax;
    xmax = x;
    fmin = f(xmin);
    fmax = f(xmax);
  endfor
endfunction
