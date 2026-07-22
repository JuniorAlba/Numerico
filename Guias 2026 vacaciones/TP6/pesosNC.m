function w = pesosNC(n)
% function w = pesosNC(n)
%
% Calcula los pesos de la fórmula de cuadratura de Newton-Cotes de n puntos
% en el intervalo [0, 1].
%
% ENTRADAS:
%   n - Número de puntos de la regla de Newton-Cotes.
%
% SALIDAS:
%   w - Vector columna con los pesos correspondientes a cada punto.
%
% OBJETIVO:
%   Resolver el sistema lineal que garantiza que la regla de integración sea 
%   exacta para polinomios de grado n-1.
    x = linspace(0,1,n);
    A = ones(n,n);
    for i=2:n
        A(i,:) = A(i-1,:) .* x;
    end
    b = 1./(1:n)';
    w = A\b;
endfunction