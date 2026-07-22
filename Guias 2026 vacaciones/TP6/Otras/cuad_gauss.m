function Q = cuad_gauss(f,a,b,n)
% function Q = cuad_gauss(f,a,b,n)
%
% Aproxima la integral de f sobre [a,b] usando Cuadratura de Gauss simple.
%
% ENTRADAS:
%   f: Función a integrar.
%   a, b: Límites de integración.
%   n: Número de puntos de Gauss.
%
% SALIDAS:
%   Q: Aproximación del valor de la integral.
%
% OBJETIVO:
%   Trasladar los nodos de Gauss del intervalo [-1, 1] al intervalo [a, b] 
%   y calcular la aproximación de la integral.

    [x,w] = gauss_xw(n);
    t=(b-a)/2*(x+1)+a;
    Q=(b-a)/2*(w’*f(t));
endfunction