function str = mostrar_cifras_sig(x, n)
    % Muestra un número con n cifras significativas
    % usando redondeo y sprintf.
    %
    % Entrada:
    %   x -> número
    %   n -> cantidad de cifras significativas
    %
    % Salida:
    %   str -> string formateado con n cifras significativas
    %
    % Ejemplos:
    %   mostrar_cifras_sig(12345.9944,4)
    %   => '1.235e+04'
    %
    %   mostrar_cifras_sig(0.0032929,3)
    %   => '0.00329'

    % Caso especial
    if x == 0
        str = '0';
        return;
    end

    % ===== REDONDEO A n CIFRAS SIGNIFICATIVAS =====

    % Orden de magnitud
    exp10 = floor(log10(abs(x)));

    % Factor de escalado
    factor = 10^(n - 1 - exp10);

    % Número redondeado
    y = round(x * factor) / factor;

    % ===== FORMATO DE SALIDA =====
    % %g trabaja con cifras significativas
    formato = ['%.' num2str(n) 'g'];

    str = sprintf(formato, y);

end
