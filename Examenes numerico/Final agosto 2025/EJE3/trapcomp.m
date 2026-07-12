function I = trapcomp(x,y)
    % Forzamos que 'y' sea FILA y 'x' sea cualquiera (pero consistente)
    y = y(:)';

    n = length(x);
    if n < 2
        error('Se necesitan al menos dos puntos.');
    end

    w = pesosNC(2); % Esto devuelve una COLUMNA [w1; w2]
    I = 0;

    for i = 1:n-1
        h = x(i+1) - x(i);
        % Como 'y' ya es fila, multiplicamos directo: (1x2) * (2x1)
        I = I + h * (y(i:i+1) * w);
    end
end