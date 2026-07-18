% Resuelve la ecuación no lineal f(x)=0 usando el método de Newton-Raphson.
% Recibe: f (función), df (derivada de la función), x0 (estimación inicial), kmax (iteraciones máximas), tol (tolerancia).
% Devuelve: x (aproximación de la raíz), h (vector de errores relativos), it (cantidad de iteraciones).
function [x, h, it] = newton(f, df, x0, kmax, tol)
  x = x0;
  for it=1:kmax
    x = x0 - f(x0)/df(x0);
    h(it) = abs(x-x0)/abs(x);
    #h(it) = abs(p-x0);
    #h(it) = f(p);
    if h(it) < tol
      break;
    endif
    x0 = x;
  endfor
endfunction
