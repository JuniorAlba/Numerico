function I = simpsoncomp(x,y)
    % Forzamos que 'y' sea FILA
    y = y(:)';

    n = length(x);
    if n < 3 || mod(n,2) == 0
        error('Se necesitan al menos 3 puntos y cantidad IMPAR.');
    end

    w = pesosNC(3); % Esto devuelve una COLUMNA [w1; w2; w3]
    I = 0;

    % Nota: Usamos n-2 para iterar correctamente hasta el antepenúltimo
    for i = 1:2:n-2
        h = x(i+2) - x(i);
        % Como 'y' ya es fila, multiplicamos directo: (1x3) * (3x1)
        I = I + h * (y(i:i+2) * w);
    end
end