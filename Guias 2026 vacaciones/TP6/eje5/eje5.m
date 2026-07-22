addpath('..');
f1 = @(x) sin(pi.*x);
f2 = @(x) 1./(1+x.^2);
f3 = @(x) abs(x).^(3/2);
v_exacto1 = 2/pi;
v_exacto2 = atan(5)-atan(-5);
v_exacto3 = 2/5*(5)^(5/2);
Etrap = [];
Etrap_cociente = [];
Esimp = [];
Esimp_cociente = [];
trap_aproximada = [];
simp_aproximada = [];
for i=1:1:12
    L1 = (5)*(2^i);
    L2 = (5+5)*(2^i);
    
    Etrap = [Etrap ; abs(v_exacto1 - intNCcompuesta(f1,0,5,L1,2)) abs(v_exacto2-intNCcompuesta(f2,-5,5,L2,2)) abs(v_exacto3-intNCcompuesta(f3,0,5,L1,2))];
    Esimp = [Esimp ; abs(v_exacto1 - intNCcompuesta(f1,0,5,L1,3) ) abs(v_exacto2-intNCcompuesta(f2,-5,5,L2,3)) abs(v_exacto3-intNCcompuesta(f3,0,5,L1,3))];
    trap_aproximada = [trap_aproximada ; intNCcompuesta(f1,0,5,L1,2) intNCcompuesta(f2,-5,5,L2,2) intNCcompuesta(f3,0,5,L1,2)];
    simp_aproximada = [simp_aproximada ; intNCcompuesta(f1,0,5,L1,3) intNCcompuesta(f2,-5,5,L2,3) intNCcompuesta(f3,0,5,L1,3)];
    if(i>1)
        Etrap_cociente = [Etrap_cociente; Etrap(i-1,1)/Etrap(i,1) Etrap(i-1,2)/Etrap(i,2) Etrap(i-1,3)/Etrap(i,3)];
        Esimp_cociente = [Esimp_cociente; Esimp(i-1,1)/Esimp(i,1) Esimp(i-1,2)/Esimp(i,2) Esimp(i-1,3)/Esimp(i,3)];
    endif
endfor

% --- CÓDIGO AGREGADO PARA MOSTRAR TABLAS ---

% 1. Igualamos tamaños: Agregamos una fila de NaN al principio de los cocientes
%    para que tengan 12 filas igual que el resto de datos.
Etrap_cociente = [NaN NaN NaN; Etrap_cociente];
Esimp_cociente = [NaN NaN NaN; Esimp_cociente];

% 2. Definimos títulos para encabezar cada tabla
titulos = {
    'TABLA 1: f(x) = sin(pi*x) en [0, 5]', ...
    'TABLA 2: f(x) = 1/(1+x^2) en [-5, 5]', ...
    'TABLA 3: f(x) = |x|^(3/2) en [0, 5]'
};

% 3. Bucle para imprimir las 3 tablas
for k = 1:3
    fprintf('\n\n%s\n', titulos{k});
    fprintf('------------------------------------------------------------------------------------------\n');
    fprintf('| %-7s | %-6s | %-12s | %-10s | %-6s | %-12s | %-10s | %-6s |\n', ...
            'h', 'L', 'Q_trap', 'E_trap', 'Ratio', 'Q_simp', 'E_simp', 'Ratio');
    fprintf('|---------|--------|--------------|------------|--------|--------------|------------|--------|\n');
    
    for i = 1:12
        h_val = 2^(-i);     % h = 1/2, 1/4...
        den = 2^i;          % Denominador para imprimir "1/..."
        
        % Determinar L correcto según la función (la 2da tiene longitud 10)
        if k == 2
            L_print = 10 * den;
        else
            L_print = 5 * den;
        end
        
        % Imprimimos la fila i de la función k
        fprintf('| 1/%-5d | %-6d | %10.7f   | %1.2e   | %5.2f  | %10.7f   | %1.2e   | %5.2f  |\n', ...
            den, L_print, ...
            trap_aproximada(i,k), Etrap(i,k), Etrap_cociente(i,k), ...
            simp_aproximada(i,k), Esimp(i,k), Esimp_cociente(i,k));
    end
    fprintf('------------------------------------------------------------------------------------------\n');
end

% -------------------------------------------------------------------------
% CONCLUSIONES CORREGIDAS
% -------------------------------------------------------------------------

%NOTA IMPORTANTE: CUANDO SE HABLA DE SUBINTERVALO SE HABLA DE LA DISTANCIA DE UN PUNTO A OTRO
%En la regla del trapecio el subintervalo coincide con el largo del trapecio
%Pero en la regla de simpson el subintervalo no necesariamente coincide con el largo de la parabola
% b) REGLA DEL TRAPECIO
% Observando las tablas, al duplicar L (reducir h a la mitad), el error disminuye 
% aproximadamente 4 veces en todos los casos. 
% Como 2^k = 4 implica k=2, confirmamos que el método es de orden O(h^2) 
% para cualquier función continua.

% c) REGLA DE SIMPSON (¡OJO AQUÍ!)
% Para las funciones f1 y f2 (que son suaves e infinitamente derivables), el error 
% disminuye 16 veces, confirmando un orden de convergencia O(h^4). (teoricamente deberia ser O(h^3)
% pero gracias a la simetria del polinomio con el que integramos, los errores de la parte izquierda
% y de la parte derecha se cancelan mutuamente, aumentando el orden de convergencia)
%
% SIN EMBARGO, para f3(x) = |x|^(3/2), observamos en la Tabla 3 que el error solo 
% disminuye un factor de 5.66 (Ratio aprox 5.66). 
% Esto indica que el orden de convergencia cae a k ≈ 2.5.
% RESPUESTA: NO es cierto que sea siempre O(h^4). Para funciones que no tienen 
% derivada cuarta acotada (como f3 en x=0), Simpson pierde su velocidad de 
% convergencia teórica.

% d) INTERVALOS NECESARIOS (Para Error < 1e-7)
% Mirando las tablas generadas:
%
% d) INTERVALOS NECESARIOS (Para Error < 1e-7)
% Nota sobre Evaluaciones de Función (n_eval):
% Si dividimos el dominio en L subintervalos (paso h), tenemos L+1 puntos en la malla.
% Como ambas reglas son cerradas (usan x0 y x_final) y re-utilizan los extremos
% de los subintervalos intermedios, la cantidad de evaluaciones es n_eval = L + 1.

% -- REGLA DEL TRAPECIO --
% Convergencia lenta O(h^2). Requiere un L muy grande.
% f1: L = 20480  -> Evaluaciones: 20481
% f2: L = 2560   -> Evaluaciones: 2561
% f3: L = 10240  -> Evaluaciones: 10241

% -- REGLA DE SIMPSON --
% Convergencia rápida O(h^4) (salvo en f3).
% A diferencia del trapecio que trabaja intervalo a intervalo, Simpson agrupa 
% los subintervalos de a pares (cada parábola cubre 2h).
% f1: L = 160    -> Evaluaciones: 161   (¡Mucho más eficiente! 161 vs 20481)
% f2: L = 40     -> Evaluaciones: 41    (¡Extremadamente eficiente!)
% f3: L = 320    -> Evaluaciones: 321   
%      Nota f3: Aunque Simpson pierde su orden O(h^4) por la derivada singular
%      y baja a aprox O(h^2.5), sigue ganando por mucho (321 evaluaciones vs 10241).