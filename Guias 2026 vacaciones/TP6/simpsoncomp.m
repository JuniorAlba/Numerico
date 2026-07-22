function Q = simpsoncomp(x,y)
    %
    % function Q = simpsoncomp(x,y)
    %
    % Regla de Simpson compuesta para aproximar
    % la integral de una funcion f a partir de puntos dados.
    %
    % ENTRADAS:
    %   x: Vector de puntos en el eje x, equidistribuidos, de longitud impar (n=L+1).
    %   y: Vector de valores de la funcion evaluada en x, tal que y(i) = f(x(i)).
    %
    % SALIDAS:
    %   Q: Aproximación de la integral.
    %
    % OBJETIVO:
    %   Integrar numéricamente usando interpolación cuadrática (3 puntos) en cada subintervalo.
    % Calculamos la cantidad L de subintervalos
    % que determinan los datos
    L = numel(x) - 1;
    % Chequeamos que haya una cantidad par de
    % subintervalos
    if rem(L,2)
        % Chequear en la linea de comandos
        % que devuelve rem(L,2) para distintos valores de L
        disp('Atencion: Tiene que dar una cantidad impar de datos')
        Q = NaN;
        return
    end
    % Para aplicar la regla de Simpson compuesta
    % en L/2 intevalos consecutivos, necesitamos la longitud
    % de cada intervalo.
    h = (x(end)-x(1))/(L/2);
    % Ahora aplicamos la regla de Simpson compuesta.
    % Para entender la siguiente linea primero hay que
    % escribir en papel como quedaria la formula.
    Q = h/6 * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));
endfunction