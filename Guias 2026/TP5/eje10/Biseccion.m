function [p, h, it] = Biseccion(f, a, b, maxit, tol )
  #HECHO POR MI
  fa= f(a);
  fb = f(b);
  if sign(fa)*sign(fb) > 0
    error("No se cumplen las condiciones para aplicar biseccion")
  endif

  #Esta variable nos va a servir para calcular el error absoluto entre dos iteraciones
  Pold = a;
  for it= 1:maxit
    p = a + (b-a)/2;
    fp = f(p);
    h(it) = abs(p-Pold)/abs(p);
    if h(it)<tol
      break;
    endif

    Pold = p;
    if sign(fp)*sign(fb)<0
      fa = fp;
      a = p;
    else
      fb = fp;
      b = p;
    endif

  endfor
endfunction


%{
function it = it_bisec(a,b,tol)
  #Iteraciones necesarias para la convergencia de biseccion con tolerancia = tol
  it = log2(abs(b-a)/tol);
  it = ceil(it); # Función Techo
endfunction;
%}
