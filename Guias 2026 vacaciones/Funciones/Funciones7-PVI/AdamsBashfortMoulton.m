function y = AdamsBashfortMoulton (f,t,y0)
% Resuelve numéricamente un Problema de Valor Inicial (PVI)
% utilizando un esquema Predictor-Corrector
% Adams-Bashforth / Adams-Moulton.
%
% Aproxima la solución de:
%    y' = f(t,y)
%    y(t0) = y0
%
% Utiliza:
%   - Runge-Kutta de orden 4 para generar los
%     valores iniciales.
%   - Adams-Bashforth de 4 pasos como predictor.
%   - Adams-Moulton de 4 pasos como corrector.
%
% Entradas:
%   f  : Handle de la función f(t,y).
%   t  : Vector de tiempos.
%   y0 : Condición inicial. Puede ser escalar o vectorial.
%
% Salidas:
%   y : Aproximación numérica de la solución.

% Guardamos la condición inicial.
y(:,1) = y0;

% Cantidad de subintervalos.
N = length(t)-1;

% Tamaño de paso.
%
% Se supone que la malla es uniforme.
h = t(2) - t(1);

% =====================================================
% GENERACIÓN DE VALORES INICIALES
% =====================================================
%
% Adams-Bashforth y Adams-Moulton son métodos
% multipaso.
%
% Necesitan varios valores previos para poder
% comenzar.
%
% Para obtenerlos se utiliza RK4.
%
% Se calculan:
% y1, y2, y3
%
% a partir de y0.
for n=1:3

  % Primera pendiente
  k1 = h * f(t(n) , y(:,n));

  % Segunda pendiente
  k2 = h * f(t(n)+h/2 , y(:,n)+k1/2);

  % Tercera pendiente
  k3 = h * f(t(n)+h/2 , y(:,n)+k2/2);

  % Cuarta pendiente
  k4 = h * f(t(n+1) , y(:,n)+k3);

  % Fórmula de RK4
  y(:,n+1) = y(:,n) + (k1+2*k2+2*k3+k4)/6;

endfor

% =====================================================
% ADAMS-BASHFORTH + ADAMS-MOULTON
% =====================================================
%
% Como RK4 calculó:
%
% y0,y1,y2,y3
%
% podemos comenzar desde n=4.
%
% El método se divide en dos etapas:
%
% 1) Predictor:
%    Adams-Bashforth de 4 pasos
%
% 2) Corrector:
%    Adams-Moulton de 4 pasos
%
% La idea es:
%
% Primero predecir y(n+1)
%
% Luego corregir dicha aproximación.
for n=4:N

  % ==========================================
  % PREDICTOR
  % Adams-Bashforth de 4 pasos
  % ==========================================
  %
  % Método explícito.
  %
  % Utiliza información de:
  %
  % y(n)
  % y(n-1)
  % y(n-2)
  % y(n-3)
  %
  % para estimar y(n+1).
  y(:,n+1) = y(:,n) + (h/24) * ...
  (55*f(t(n),y(:,n))...
  -59*f(t(n-1),y(:,n-1))...
  +37*f(t(n-2),y(:,n-2))...
  -9*f(t(n-3),y(:,n-3)));

  % ==========================================
  % CORRECTOR
  % Adams-Moulton de 4 pasos
  % ==========================================
  %
  % Método implícito.
  %
  % Utiliza la predicción anterior
  % para mejorar la aproximación.
  %
  % En esta implementación se realiza
  % una única corrección.
  y(:,n+1) = y(:,n) + (h/24) * ...
  (9*f(t(n+1),y(:,n+1))...
  +19*f(t(n),y(:,n))...
  -5*f(t(n-1),y(:,n-1))...
  +f(t(n-2),y(:,n-2)));

endfor

% Cada fila representa un instante temporal.
y=y';

%{
Ejemplo:
    f = @(t,y) -y;
    t = linspace(0,1,21);

    y = AdamsBashfortMoulton(f,t,1);

Observaciones:
    - Es un método multipaso.
    - Implementa un esquema Predictor-Corrector.
    - Utiliza RK4 para arrancar.
    - Adams-Bashforth realiza la predicción.
    - Adams-Moulton realiza la corrección.
    - Requiere una malla temporal uniforme.
    - Puede utilizarse para sistemas de EDO.
    - Suele ser más eficiente que RK4 cuando se
      necesitan muchos pasos.
    - Reduce la cantidad de evaluaciones de f
      una vez obtenidos los valores iniciales.

Relación con otros métodos:
    - Utiliza RK4 para generar valores iniciales.
    - Adams-Bashforth es el predictor.
    - Adams-Moulton es el corrector.
    - Forma parte de la familia de métodos
      multipaso.
    - A diferencia de Euler, RK2 y RK4,
      utiliza varios puntos anteriores.

Cómo puede aparecer en un ejercicio:
    - "Utilice Adams-Bashforth."
    - "Utilice Adams-Moulton."
    - "Implemente un predictor-corrector."
    - "Utilice un método multipaso."
    - "Genere los valores iniciales con RK4."
    - "Compare Runge-Kutta y Adams."
    - "Construya un esquema predictor-corrector."

Trampas frecuentes:
    - Olvidar generar los valores iniciales.
    - Utilizar menos puntos de los necesarios.
    - Confundir predictor con corrector.
    - Comenzar el ciclo principal antes de tiempo.
    - Utilizar una malla no uniforme.
    - Pensar que Adams-Bashforth es implícito.
    - Pensar que Adams-Moulton es explícito.

Traducción de consigna:
    - "Predictor-Corrector"        -> AdamsBashfortMoulton(...)
    - "Adams-Bashforth"            -> etapa predictor
    - "Adams-Moulton"             -> etapa corrector
    - "Método multipaso"          -> AdamsBashfortMoulton(...)
    - "Generar valores con RK4"   -> bloque inicial

Resumen:
    Tipo          : Multipaso
    Predictor     : Adams-Bashforth 4 pasos
    Corrector     : Adams-Moulton 4 pasos
    Inicialización: RK4
    Orden         : 4
    Error global  : O(h^4)
    Requiere      : Valores previos
    Ventaja       : Alta precisión con menor costo
                    por paso que RK4

%}
endfunction
