function [t,y]=rk4(f, inter, y0, L)
#{
 Resuelve numéricamente un Problema de Valor Inicial (PVI)
 utilizando el Método de Runge-Kutta de orden 4 (RK4).

 Aproxima la solución de:
    y' = f(t,y)
    y(t0) = y0

 Entradas:
   f     : Handle de la función f(t,y).

           Problema escalar:
               y' = f(t,y)

           Sistema de EDO:
               y1' = f1(t,y1,y2,...)
               y2' = f2(t,y1,y2,...)
               ...

           En caso de sistema, f debe devolver
           un vector columna con la misma cantidad
           de componentes que y.

   inter : Vector [t0 TF] con el intervalo
           de integración.

   y0    : Condición inicial.

           Escalar:
               y0 = 1

           Sistema:
               y0 = [y1(0);
                     y2(0);
                     ...]

   L     : Cantidad de pasos de integración.

    IMPORTANTE:

 L representa la cantidad de pasos,
 NO el tamaño de paso.

 Si se conoce h:

     L = (TF-t0)/h;

 Si se conoce L:

     h = (TF-t0)/L;

 Salidas:
   t : Vector de tiempos.

   y : Aproximación numérica de la solución.

       Problema escalar:
           y(i) aproxima y(t(i))

       Sistema:
           y(i,j) aproxima la variable j
           en el instante t(i)
#}
% Generamos la malla temporal.
t = linspace(inter(1),inter(2),L+1)';

% Tamaño de paso.
h = (inter(2)-inter(1))/L;

% Reservamos memoria para la solución.
y = zeros( length(y0), L+1 );

% Imponemos la condición inicial.
y(:,1) = y0;

% Método de Runge-Kutta de orden 4.
%
% Calcula cuatro pendientes:
%
% k1 -> pendiente al inicio
% k2 -> pendiente en el punto medio usando k1
% k3 -> pendiente en el punto medio usando k2
% k4 -> pendiente al final usando k3
%
% Luego combina dichas pendientes mediante
% un promedio ponderado.
%
% Es uno de los métodos más utilizados por su
% excelente relación precisión/costo.
for n=1:L

  % Pendiente al comienzo del intervalo
  k1 = h * f(t(n)  , y(:,n));

  % Primera estimación en el punto medio
  k2 = h * f(t(n)+h/2, y(:,n)+k1/2);

  % Segunda estimación en el punto medio
  k3 = h * f(t(n)+h/2, y(:,n)+k2/2);

  % Pendiente al final del intervalo
  k4 = h * f(t(n+1), y(:,n)+k3);

  % Promedio ponderado de pendientes
  y(:,n+1) = y(:,n) + (k1+2*k2+2*k3+k4)/6;

end

% Cada fila representa un instante temporal.
y=y';

%{
Ejemplo:
    f = @(t,y) -y;
    [t,y] = rk4(f,[0 1],1,10);

Observaciones:
    - Es un método de un paso.
    - Es un método explícito.
    - Utiliza 4 evaluaciones de f por paso.
    - Puede utilizarse para ecuaciones escalares
      y sistemas de EDO.
    - Tiene muy buena precisión incluso con pasos
      relativamente grandes.
    - Es uno de los métodos más usados en la práctica.
    - Su error global es O(h^4).
    - Su error local es O(h^5).
    - Es de orden 4.
    - Es condicionalmente estable.
    - Sistemas de EDO:

  Si el problema tiene varias ecuaciones:

   x' = -t*y
   y' = t*x - t*y

 Se define:

   F = @(t,u) [
       -t*u(2);
        t*u(1)-t*u(2)
   ];

 donde:

   u(1) = x
   u(2) = y

 La condición inicial se arma respetando
 exactamente el mismo orden:

   x(0)=1
   y(0)=2

   u0 = [1;
         2];

 Luego:

   [t,u] = rk4(F,[0 1],u0,100);

 La salida queda:

   u(:,1) -> aproximación de x(t)
   u(:,2) -> aproximación de y(t)

 Por ejemplo:

   x = u(:,1);
   y = u(:,2);

   plot(t,x)
   plot(t,y)

 Regla práctica:

   Ecuación 1 -> u(1)
   Ecuación 2 -> u(2)
   Ecuación 3 -> u(3)
   ...

 El orden de las ecuaciones,
 el vector inicial y la salida
 siempre debe coincidir.

Relación con otros métodos:
    - RK2 puede verse como una versión más simple
      de Runge-Kutta.
    - RK4 mejora significativamente la precisión de RK2.
    - Euler utiliza una única pendiente.
    - RK4 utiliza cuatro pendientes para aproximar
      mejor la solución exacta.
    - Suele utilizarse para generar valores iniciales
      en métodos multipaso.

Cómo puede aparecer en un ejercicio:
    - "Resuelva utilizando RK4."
    - "Utilice Runge-Kutta de orden 4."
    - "Obtenga una aproximación de orden 4."
    - "Compare Euler, RK2 y RK4."
    - "Verifique experimentalmente el orden."
    - "Estudie el error para distintos h."

Trampas frecuentes:
    - Olvidar multiplicar por h en los k.
    - Intercambiar k2 y k3.
    - Utilizar mal los coeficientes 1-2-2-1.
    - Confundir orden 4 con error O(h^5).
    - El error global es O(h^4).
    - Pensar que es incondicionalmente estable.

Traducción de consigna:
    - "RK4"                      -> rk4(...)
    - "Runge-Kutta orden 4"      -> rk4(...)
    - "Método de orden 4"        -> rk4(...)
    - "Método explícito orden 4" -> rk4(...)

Resumen:
    Tipo          : Explícito
    Orden         : 4
    Error global  : O(h^4)
    Error local   : O(h^5)
    Estabilidad   : Condicional
    Costo         : 4 evaluaciones de f por paso

Plantilla rápida para sistemas:

 F = @(t,u) [
     ecuacion_1;
     ecuacion_2;
     ...
     ecuacion_n
 ];

 u0 = [
     variable_1(0);
     variable_2(0);
     ...
     variable_n(0)
 ];

 [t,u] = metodo(F,[a b],u0,L);

 variable_1 = u(:,1);
 variable_2 = u(:,2);
 ...
 variable_n = u(:,n);

%}

endfunction
