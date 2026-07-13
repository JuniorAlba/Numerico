function [t, y] = adams_rashford(f, inter, Y0, L)
% Resuelve numéricamente un Problema de Valor Inicial (PVI)
% utilizando un esquema Predictor-Corrector
% Adams-Bashforth / Adams-Moulton.
%
% Aproxima la solución de:
%    y' = f(t,y)
%    y(t0) = Y0
%
% Utiliza:
%   - RK4 para generar los valores iniciales.
%   - Adams-Bashforth de 4 pasos como predictor.
%   - Adams-Moulton de 4 pasos como corrector.
%
% Entradas:
%   f     : Handle de la función f(t,y).
%   inter : Vector [t0 TF] con el intervalo de integración.
%   Y0    : Condición inicial. Puede ser escalar o vectorial.
%   L     : Cantidad de pasos.
%
% Salidas:
%   t : Vector de tiempos.
%   y : Aproximación numérica de la solución.

  % Construimos la malla temporal.
  t = linspace(inter(1),inter(2),L+1)';

  % Tamaño de paso.
  h = (inter(2)-inter(1))/L;

  % Reservamos memoria para almacenar la solución.
  y = zeros( length(Y0), L+1 );

  % Imponemos la condición inicial.
  y(:,1) = Y0;

  % =====================================================
  % GENERACIÓN DE VALORES INICIALES
  % =====================================================
  %
  % Adams-Bashforth de 4 pasos necesita:
  %
  % y0
  % y1
  % y2
  % y3
  %
  % Como únicamente conocemos y0,
  % generamos y1, y2 e y3 mediante RK4.
  %
  % Recién después podremos aplicar
  % el método multipaso.
  for n = 1:3

    % Primera pendiente.
    k1 = h * f(t(n)  , y(:,n));

    % Segunda pendiente.
    k2 = h * f(t(n)+h/2, y(:,n)+k1/2);

    % Tercera pendiente.
    k3 = h * f(t(n)+h/2, y(:,n)+k2/2);

    % Cuarta pendiente.
    k4 = h * f(t(n+1), y(:,n)+k3);

    % Fórmula de RK4.
    y(:,n+1) = y(:,n) + (k1+2*k2+2*k3+k4)/6;

  endfor

  % =====================================================
  % ADAMS-BASHFORTH + ADAMS-MOULTON
  % =====================================================
  %
  % Ya disponemos de:
  %
  % y0, y1, y2, y3
  %
  % Por lo tanto podemos comenzar
  % en n = 4.
  for n = 4:L

    % ==========================================
    % PREDICTOR
    % Adams-Bashforth de 4 pasos
    % ==========================================
    %
    % Método explícito.
    %
    % Utiliza las derivadas en los
    % cuatro instantes anteriores para
    % estimar y(n+1).
    y(:, n+1) = y(:, n) + (h/24) * ...
    (55*f(t(n), y(:,n)) ...
    -59*f(t(n-1), y(:, n-1)) ...
    +37*f(t(n-2), y(:, n-2)) ...
    -9*f(t(n-3), y(:, n-3)));

    % ==========================================
    % CORRECTOR
    % Adams-Moulton de 4 pasos
    % ==========================================
    %
    % Utiliza la predicción obtenida
    % anteriormente para mejorar
    % la aproximación final.
    y(:, n+1) = y(:, n) + (h/24) * ...
    (9*f(t(n+1), y(:,n+1)) ...
    +19*f(t(n), y(:, n)) ...
    -5*f(t(n-1), y(:, n-1)) ...
    +f(t(n-2), y(:, n-2)));

  end

  % Cada fila representa un instante temporal.
  y = y';

%{
Ejemplo:
    f = @(t,y) -y;
    [t,y] = adams_rashford(f,[0 1],1,20);

Observaciones:
    - Implementa un método Predictor-Corrector.
    - Utiliza RK4 para generar los valores iniciales.
    - Adams-Bashforth realiza la predicción.
    - Adams-Moulton realiza la corrección.
    - Es un método multipaso.
    - Requiere una malla uniforme.
    - Puede trabajar con sistemas de EDO.
    - Una vez obtenidos los valores iniciales,
      necesita menos evaluaciones que aplicar
      RK4 en todos los pasos.
    - Es uno de los esquemas predictor-corrector
      más utilizados en cursos introductorios.

Relación con otros métodos:
    - Utiliza RK4 para arrancar.
    - Adams-Bashforth es explícito.
    - Adams-Moulton es implícito.
    - Forma parte de los métodos multipaso.
    - A diferencia de Euler, RK2 y RK4,
      necesita varios valores anteriores.
    - Pertenece a la familia de métodos
      Predictor-Corrector.

Cómo puede aparecer en un ejercicio:
    - "Implemente Adams-Bashforth."
    - "Implemente Adams-Moulton."
    - "Utilice un Predictor-Corrector."
    - "Obtenga los valores iniciales con RK4."
    - "Aplique un método multipaso."
    - "Compare RK4 y Adams."
    - "Construya un esquema predictor-corrector."

Trampas frecuentes:
    - Olvidar generar y1, y2 e y3.
    - Comenzar Adams-Bashforth demasiado pronto.
    - Confundir predictor con corrector.
    - Usar una malla no uniforme.
    - Pensar que Adams-Bashforth es implícito.
    - Pensar que Adams-Moulton es explícito.
    - Olvidar utilizar el valor predicho
      dentro del corrector.

Traducción de consigna:
    - "Adams-Bashforth"         -> bloque predictor
    - "Adams-Moulton"          -> bloque corrector
    - "Predictor-Corrector"    -> adams_rashford(...)
    - "Método multipaso"       -> adams_rashford(...)
    - "Generar datos con RK4"  -> bloque inicial

Resumen:
    Tipo             : Multipaso
    Predictor        : Adams-Bashforth 4 pasos
    Corrector        : Adams-Moulton 4 pasos
    Inicialización   : RK4
    Orden            : 4
    Error global     : O(h^4)
    Requiere         : Valores previos
    Ventaja          : Menor costo por paso que RK4
                        una vez inicializado

%}
endfunction
