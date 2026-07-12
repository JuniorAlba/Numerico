function E = error_cuadratico(p, x, y)
    % 1. Forzamos columnas para evitar errores de dimensión
    x = x(:);
    y = y(:);
    
    % 2. Evaluamos el polinomio
    y_estimado = polyval(p, x);
    
    % 3. Calculamos la suma de los residuos al cuadrado
    % (No hace falta abs, el cuadrado ya elimina el signo negativo)
    E = sum((y - y_estimado).^2);
endfunction