function [w_min] = wOptimoExperimental (A,b,x0,maxit,tolerancia)
  aux=1;
  condicion =true;
  w = linspace(0.1,1.9,100);
  for i=1:length(w)
    [x,it,r]=SOR(A,b,x0,maxit,tolerancia,w(i));
    if(it<aux || condicion)
      w_min=w(i);
      aux=it;
      condicion = false;
    endif
  endfor

  %tambien se puede usar la formula, si la matriz es definida positiva
  %y tridiagonal
  %w = 2/( 1+sqrt( 1 - (RadJacobi(A)^2) ) )

endfunction
% -------------------------------------------------------------------------
% BÚSQUEDA EXPERIMENTAL DE W (FUERZA BRUTA / EMPÍRICO)
% -------------------------------------------------------------------------
% DESCRIPCIÓN:
% Encuentra el w que minimiza el número real de iteraciones ejecutando
% el método SOR completo para un rango de valores.
%
% VENTAJAS Y VALIDEZ:
% 1. UNIVERSAL: Funciona para CUALQUIER matriz y vector b, sin importar
%    su estructura (no requiere "Propiedad A" ni simetría).
% 2. REALISTA: Encuentra el óptimo para la tolerancia y x0 específicos
%    del problema actual.
%
% COSTO COMPUTACIONAL:
% - MUY ALTO. Ejecuta el método SOR 100 veces.
% - Recomendado solo para matrices pequeñas o cuando se desconoce
%   la estructura de la matriz y falla la teoría.
% -------------------------------------------------------------------------