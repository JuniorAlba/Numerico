function Q = trapcomp(x,y)
    %
    % function Q = trapcomp(x,y)
    %
    % Regla del trapecio compuesta para aproximar
    % la integral de una funcion f a partir de puntos dados.
    %
    % ENTRADAS:
    %   x: Vector de puntos en el eje x. Pueden ser no equiespaciados.
    %   y: Vector de valores de la funcion evaluada en x, tal que y(i) = f(x(i)).
    %
    % SALIDAS:
    %   Q: Aproximación de la integral sumando el área de los trapecios.
    %
    % OBJETIVO:
    %   Integrar numéricamente asumiendo comportamiento lineal entre los puntos dados.
    % Calculamos la cantidad L de subintervalos
    % que determinan los datos
    L = numel(x) - 1;
    % Calculamos un vector que tiene la longitud
    % de cada uno de los L subintervalos
    deltax = diff(x); % deltax(i) = x(i+1)-x(i)
    % Ahora aplicamos la regla del trapecio en
    % cada intervalo [x(i),x(i+1)], para i = 1,2,...,L
    Q = 0;
    for i = 1:L
        Q = Q + .5*deltax(i)*(y(i)+y(i+1));
    end
endfunction