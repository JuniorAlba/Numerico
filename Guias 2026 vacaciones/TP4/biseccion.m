% Resuelve la ecuación no lineal f(x)=0 usando el método de bisección.
% Recibe: f (función), xmin y xmax (extremos del intervalo inicial), kmax (iteraciones máximas), tol (tolerancia).
% Devuelve: x (aproximación de la raíz), h (vector de errores relativos), it (cantidad de iteraciones).
function [x, h, it] = biseccion(f, xmin, xmax, kmax, tol)
  fa = f(xmin);
  fb = f(xmax);
  if sign(fa)*sign(fb) > 0
    error("No se cumplen las condiciones para aplicar bisección (f(xmin) y f(xmax) deben tener distinto signo)");
  endif

  #Esta variable nos va a servir para calcular el error absoluto entre dos iteraciones
  Pold = xmin;
  for it=1:kmax
    x = xmin + (xmax-xmin)/2;
    fx = f(x);
    h(it) = abs(x-Pold)/abs(x);
    if h(it)<tol
      break;
    endif

    Pold = x;
    if sign(fx)*sign(fb) < 0
      fa = fx;
      xmin = x;
    else
      fb = fx;
      xmax = x;
    endif

  endfor
endfunction


