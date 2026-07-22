function Q = cuad_gauss_c(f,a,b,L,n)
% function Q = cuad_gauss_c(f,a,b,L,n)
%
% Aproxima la integral de f sobre [a,b] usando Cuadratura de Gauss Compuesta.
%
% ENTRADAS:
%   f: Función a integrar.
%   a, b: Límites del intervalo completo.
%   L: Cantidad de subintervalos.
%   n: Número de puntos de Gauss por subintervalo.
%
% SALIDAS:
%   Q: Aproximación del valor de la integral.
%
% OBJETIVO:
%   Subdividir el intervalo en L partes y aplicar Gauss en cada una para mayor precisión.

[xg,w] = gauss_xw(n);

x=linspace(a,b,L+1);
h=(b-a)/L;
Q=0;
for i=1:L
  t=h/2*(xg+1)+x(i);
  Q+=h/2*(w'*f(t));
endfor