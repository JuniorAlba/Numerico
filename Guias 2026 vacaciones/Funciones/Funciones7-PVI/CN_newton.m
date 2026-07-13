function [t,y] = CN_newton(f,dfdy,a,b,y0,N)
#{

 Resuelve numéricamente un Problema de Valor Inicial (PVI)
 utilizando el método de Crank-Nicholson.

 Debido a que Crank-Nicholson es un método implícito,
 en cada paso se utiliza el método de Newton para
 resolver la ecuación no lineal resultante.

 Aproxima la solución de:
    y' = f(t,y)
    y(t0) = y0

 Entradas:
   f    : Handle de la función f(t,y).

          Problema escalar:
              y' = f(t,y)

   dfdy : Derivada parcial de f respecto de y.

          Debe coincidir con la función utilizada
          en f.

   a    : Extremo inicial del intervalo.

   b    : Extremo final del intervalo.

   y0   : Condición inicial.

          Esta implementación está pensada para
          problemas escalares.

   N    : Cantidad de pasos de integración.

 Salidas:
   t : Vector de tiempos.

   y : Aproximación numérica de la solución.

       y(i) aproxima y(t(i))
#}

% Tolerancia utilizada por Newton.
%
% Determina cuándo se considera que Newton
% ha convergido.
tol=1e-9;

% Máximo número de iteraciones permitidas
% para Newton en cada paso temporal.
kmax=100;

% Tamaño de paso temporal.
h=(b-a)/N;

% Construimos la malla temporal.
t=linspace(a,b,N+1)';

% Reservamos memoria para la solución.
y=0*t;

% Imponemos la condición inicial.
y(1)=y0;

% Bucle principal del método de Crank-Nicholson.
%
% En cada paso debemos calcular y(n+1).
%
% La fórmula teórica es:
%
% y(n+1)=y(n)+h/2*[f(t(n),y(n))+f(t(n+1),y(n+1))]
%
% Como y(n+1) aparece dentro de f,
% debemos resolver una ecuación no lineal.
for n=1:N

    % Valor inicial para Newton.
    %
    % Se utiliza como semilla el valor anterior.
    yi=y(n);

    % Contador de iteraciones de Newton.
    k=1;

    % Evaluación que permanece constante durante
    % todas las iteraciones de Newton de este paso.
    fn=f(t(n),y(n));

    % Método de Newton para resolver:
    %
    % g(yi)=0
    %
    % donde g representa la ecuación implícita
    % de Crank-Nicholson.
    while (k<kmax)

        % Función no lineal asociada al método.
        %
        % g(yi)=0 equivale a satisfacer
        % la fórmula de Crank-Nicholson.
        g = yi - y(n) - h/2*( fn + f(t(n+1),yi) );

        % Derivada de g respecto de yi.
        %
        % Necesaria para aplicar Newton.
        dg = 1 - h/2*dfdy(t(n+1),yi);

        % Iteración de Newton:
        %
        % yi_nuevo = yi - g/dg
        y(n+1) = yi - g/dg;

        % Criterio de convergencia.
        %
        % Si dos iteraciones consecutivas son
        % suficientemente parecidas, detenemos
        % Newton.
        if(abs(y(n+1)-yi)<tol)
            break;
        endif

        % Avanzamos a la siguiente iteración.
        k+=1;

        % Actualizamos la aproximación.
        yi=y(n+1);

    endwhile

endfor

%{
Ejemplo:
    f = @(t,y) -y;
    dfdy = @(t,y) -1;

    [t,y] = CN_newton(f,dfdy,0,1,1,20);

Observaciones:
    - Implementa Crank-Nicholson mediante Newton.
    - Es un método implícito.
    - Utiliza la pendiente al inicio y al final
      del intervalo.
    - Es de orden 2.
    - Tiene error global O(h^2).
    - Tiene error local O(h^3).
    - Es más preciso que Euler.
    - Tiene la misma precisión teórica que RK2.
    - Es incondicionalmente estable.
    - Requiere conocer df/dy.
    - Puede utilizarse cuando Euler explícito
      presenta problemas de estabilidad.

   - Esta implementación está diseñada para
     ecuaciones diferenciales escalares.

   - Para sistemas de EDO sería necesario
     reemplazar Newton escalar por Newton para
     sistemas y utilizar el Jacobiano.


Relación con otros métodos:
    - Puede interpretarse como una versión implícita
      del método del trapecio.
    - Utiliza Newton para resolver la ecuación
      implícita generada en cada paso.
    - Comparte el mismo orden que RK2.
    - Suele ser más robusto que Euler para
      problemas rígidos.
    - Euler atrás también es implícito pero de
      orden 1.

Cómo puede aparecer en un ejercicio:
    - "Resuelva mediante Crank-Nicholson."
    - "Utilice el método del trapecio implícito."
    - "Aplique un método implícito de orden 2."
    - "Resuelva utilizando Newton en cada paso."
    - "Compare Euler y Crank-Nicholson."
    - "Estudie estabilidad numérica."
    - "Analice el comportamiento para h grande."

Trampas frecuentes:
    - Olvidar proporcionar dfdy.
    - Implementar incorrectamente g.
    - Implementar incorrectamente dg.
    - No actualizar yi dentro de Newton.
    - No verificar convergencia de Newton.
    - Confundir estabilidad con precisión.
    - Pensar que incondicionalmente estable
      significa exacto.
    - Creer que siempre supera a RK4 en precisión.

Traducción de consigna:
    - "Crank-Nicholson"          -> CN_newton(...)
    - "Crank-Nicolson"           -> CN_newton(...)
    - "Trapecio implícito"       -> CN_newton(...)
    - "Método implícito orden 2" -> CN_newton(...)
    - "Resolver con Newton"      -> CN_newton(...)

Resumen:
    Tipo          : Implícito
    Orden         : 2
    Error global  : O(h^2)
    Error local   : O(h^3)
    Estabilidad   : Incondicional
    Costo         : Newton en cada paso
    Requiere      : f(t,y) y df/dy

%}
endfunction
