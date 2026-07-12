function [S, dS, ddS] = funcion_spline(x1, y1, df1, df2)
  x1 = x1(:); 
  y1 = y1(:);

  if (nargin == 2)
    [a, b, c, d] = cubic_spline_natural(x1, y1);
  elseif (nargin == 4)
    [a, b, c, d] = cubic_spline_clamped(x1, y1, df1, df2);
  else
    error('Argumentos incorrectos: Ingrese 2 (Natural) o 4 (Sujeta)');
  endif

  % 1. Matriz de coeficientes M (tamaño: (n-1) x 4)
  M = [d, c, b, a];

  % 2. Derivadas calculadas vectorialmente sin bucles ni polyder
  dM = [3*d, 2*c, b];
  ddM = [6*d, 2*c];

  % 3. Uso de mkpp y ppval (método nativo, eficiente y sin recursión)
  S = @(x) ppval(mkpp(x1, M), x);
  dS = @(x) ppval(mkpp(x1, dM), x);
  ddS = @(x) ppval(mkpp(x1, ddM), x);
endfunction