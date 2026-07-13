function [t,y]=rk2(f, inter, y0, L)
#{
 Resuelve numéricamente un Problema de Valor Inicial (PVI)
 utilizando el Método de Runge-Kutta de orden 2 (RK2).

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

% Método de Runge-Kutta de orden 2.
%
% Calcula dos pendientes:
%
% k1 -> pendiente al inicio
% k2 -> pendiente al final estimada usando k1
%
% Luego utiliza el promedio de ambas pendientes.
%
% Este esquema también es conocido como
% Método de Heun mejorado.
for n=1:L

  % Pendiente al inicio del intervalo
  k1 = h * f(t(n)  , y(:,n));

  % Pendiente al final estimada
  k2 = h * f(t(n+1), y(:,n)+k1);

  % Promedio de pendientes
  y(:,n+1) = y(:,n) + (k1 + k2)/2;

end

% Cada fila representa un instante temporal.
y=y';

%{
Ejemplo:
    f = @(t,y) -y;
    [t,y] = rk2(f,[0 1],1,10);

Observaciones:
    - Es un método de un paso.
    - Es un método explícito.
    - Utiliza 2 evaluaciones de f por paso.
    - Puede utilizarse para ecuaciones escalares
      y sistemas de EDO.
    - Es más preciso que Euler.
    - Es menos preciso que RK4.
    - Su error global es O(h^2).
    - Su error local es O(h^3).
    - Es de orden 2.
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

   No se necesita una función distinta para
   resolver sistemas.

Relación con otros métodos:
    - Euler utiliza una sola pendiente.
    - RK2 utiliza dos pendientes.
    - RK4 utiliza cuatro pendientes.
    - Puede interpretarse como una mejora natural
      del método de Euler.
    - Crank-Nicholson también es de orden 2, pero
      es implícito.

Cómo puede aparecer en un ejercicio:
    - "Resuelva utilizando RK2."
    - "Utilice Runge-Kutta de orden 2."
    - "Aplique el método de Heun."
    - "Utilice un método explícito de orden 2."
    - "Compare RK2 con Euler y RK4."
    - "Estime el orden experimental."

Trampas frecuentes:
    - Olvidar dividir por 2.
    - Calcular k2 usando y(:,n) en lugar de y(:,n)+k1.
    - Confundirlo con Euler mejorado de otra variante.
    - Confundir error global con error local.
    - Pensar que tiene estabilidad incondicional.

Traducción de consigna:
    - "RK2"                      -> rk2(...)
    - "Runge-Kutta orden 2"      -> rk2(...)
    - "Heun"                     -> rk2(...)
    - "Método explícito orden 2" -> rk2(...)

Resumen:
    Tipo          : Explícito
    Orden         : 2
    Error global  : O(h^2)
    Error local   : O(h^3)
    Estabilidad   : Condicional
    Costo         : 2 evaluaciones de f por paso

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
