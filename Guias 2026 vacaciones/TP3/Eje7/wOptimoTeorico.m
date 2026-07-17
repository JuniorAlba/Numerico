function [w_min] = wOptimoTeorico (A)
L = tril(A,-1);
U = triu(A,1);
D = diag(diag(A));
w = linspace(0.1,1.9,100);
w_min=0;
min_radio=0;
condicion = true;
for j = 1:length(w)
  Tw = inv(D + w(j).*L)*((1-w(j)).*D-w(j).*U);
  x = max([abs(eig(Tw))]);
  if (x<min_radio || condicion)
    condicion = false;
    min_radio = x;
    w_min = w(j);
  endif
endfor
endfunction

% -------------------------------------------------------------------------
% BÚSQUEDA NUMÉRICA DEL W ÓPTIMO (MINIMIZACIÓN DE RHO)
% -------------------------------------------------------------------------
% DESCRIPCIÓN:
% Construye la matriz de iteración Tw para distintos w y busca aquel
% que minimiza el Radio Espectral (rho), garantizando la mayor velocidad
% asintótica de convergencia.
%
% VENTAJAS Y VALIDEZ:
% 1. ROBUSTO: A diferencia de la fórmula analítica (Young), este algoritmo
%    encuentra el óptimo VERDADERO incluso si la matriz no es tridiagonal
%    o no tiene "Propiedad A".
% 2. INDEPENDIENTE: No depende del vector b ni del punto de inicio x0.
%
% COSTO COMPUTACIONAL:
% - ALTO/MEDIO. El cálculo de autovalores con eig() es costoso (O(n^3)).
% - No recomendado para matrices gigantes (miles de variables).
% -------------------------------------------------------------------------