function Q = intNCcompuesta(f,a,b,L,n)
% function Q = intNCcompuesta(f,a,b,L,n)
% 
% Aproxima la integral de una función f sobre el intervalo [a,b]
% utilizando la fórmula de Newton-Cotes compuesta.
%
% ENTRADAS:
%   f: Función a integrar (debe recibir vectores y devolver vectores).
%   a, b: Límites de integración.
%   L: Cantidad de subintervalos en los que se divide [a,b].
%   n: Número de puntos de la regla de Newton-Cotes en cada subintervalo.
%
% SALIDAS:
%   Q: Valor aproximado de la integral.
%
% OBJETIVO:
%   Interpolar la función por partes usando polinomios de grado n-1
%   en subintervalos y sumar las áreas resultantes para reducir el error global.
y = linspace(a,b,L+1);
h = (b-a)/L;

% calculamos los pesos una sola vez
w = pesosNC(n); 

Q = 0;
for i=1:L
    x = linspace(y(i),y(i+1),n);
    fx = f(x); 
    Q = Q + h*(fx*w);
end
