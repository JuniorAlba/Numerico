function Q = integralNC(f,a,b,n)
    % function Q = integralNC(f,a,b,n)
    %
    % Calcula la integral de una función f sobre el intervalo [a,b]
    % de manera aproximada usando la fórmula de Newton-Cotes simple de n puntos.
    %
    % ENTRADAS:
    %   f: Función a integrar.
    %   a, b: Límites del intervalo.
    %   n: Número de puntos de interpolación.
    %
    % SALIDAS:
    %   Q: Valor aproximado de la integral.
    %
    % OBJETIVO:
    %   Aplicar la cuadratura de Newton-Cotes obteniendo los pesos adecuados
    %   y evaluando en nodos equiespaciados.
    w = pesosNC(n);
    x = linspace(a,b,n);
    fx = f(x);
    Q = (b-a)*(fx*w);
endfunction