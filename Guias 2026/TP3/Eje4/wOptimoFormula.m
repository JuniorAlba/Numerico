% Calculo del w optimo para el metodo SOR
function [w] = wOptimoFormula(A)
M = diag(diag(A));
G = diag(ones(length(A),1))-inv(M)*A;
w = 2 / (1 + sqrt(1 - (max(eig(G)))^2));

end %function

Matlab
% -------------------------------------------------------------------------
% CALCULO DE W OPTIMO (FORMULA TEORICA)
% -------------------------------------------------------------------------
% CONDICIONES DE VALIDEZ:
% Esta fórmula analítica deriva del Teorema de Young y es matemáticamente
% EXACTA solo si la matriz A cumple las siguientes propiedades:
%
% 1. Tiene "Propiedad A" (ej: es Tridiagonal o Tridiagonal por bloques).
% 2. Es Simétrica y Definida Positiva (garantiza autovalores reales).
%
% NOTA:
% - Si la matriz es general (densa o estructura aleatoria), este valor
%   es solo una aproximación heurística y podría no ser el mejor.
% - Para matrices generales, se recomienda usar el método de búsqueda
%   experimental (fuerza bruta).
% -------------------------------------------------------------------------