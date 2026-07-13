function [t,y] = euler(f,inter,y0,L)
#{
Resuelve numéricamente un Problema de Valor Inicial (PVI)
utilizando el Método de Euler (Euler hacia adelante).

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
% Generamos los puntos de la malla temporal:
% t(1)=t0, t(end)=TF
t = linspace(inter(1),inter(2),L+1)';

% Tamaño de paso:
% h=(TF-t0)/L
h = (inter(2)-inter(1))/L;

% Reservamos memoria para almacenar la solución.
%
% Cada columna corresponde inicialmente a un instante.
% Si y0 es vectorial, cada fila representa una variable
% del sistema.
y = zeros( length(y0), L+1 );

% Imponemos la condición inicial:
%
% y(:,1)=y0
%
% Corresponde a:
% y(t0)=y0
y(:,1) = y0;

% Método de Euler:
%
% y_(n+1)=y_n+h*f(t_n,y_n)
%
% En cada paso:
% 1) Se evalúa la pendiente en el punto actual.
% 2) Se avanza una distancia h utilizando dicha pendiente.
%
% Interpretación geométrica:
% Se sigue la recta tangente a la solución.
for n = 1:L

    % Pendiente en el extremo izquierdo del intervalo
    pendiente = f(t(n),y(:,n));

    % Fórmula de Euler
    y(:,n+1) = y(:,n) + h*pendiente;

end

% Transponemos para obtener el formato habitual:
%
% Cada fila corresponde a un instante t(i).
%
% Esto facilita:
% plot(t,y)
% y(end)
% tablas de resultados
y = y';

%{
Ejemplo:
    f = @(t,y) -y;
    [t,y] = euler(f,[0 1],1,10);

Observaciones:
    - Es un método de un paso.
    - Es un método explícito.
    - Utiliza una única evaluación de f por paso.
    - Es el método más simple para resolver PVI.
    - Puede utilizarse tanto para ecuaciones escalares
      como para sistemas de EDO.
    - Su error global es O(h).
    - Su error local es O(h^2).
    - Es de orden 1.
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
    - Es la base conceptual de RK2 y RK4.
    - RK2 mejora la precisión de Euler.
    - RK4 mejora significativamente la precisión de RK2.
    - Euler atrás utiliza una idea similar pero es implícito.
    - Crank-Nicholson puede verse como una mejora de Euler
      atrás utilizando un promedio de pendientes.

Cómo puede aparecer en un ejercicio:
    - "Resuelva el PVI mediante Euler."
    - "Aproxime y(tf) usando Euler."
    - "Utilice un método explícito de orden 1."
    - "Obtenga una aproximación usando paso h."
    - "Realice una iteración de Euler."
    - "Compare Euler con RK2 o RK4."
    - "Estudie el error para distintos tamaños de paso."

Trampas frecuentes:
    - Confundir L (cantidad de pasos) con cantidad de nodos.
    - Calcular incorrectamente h.
    - Evaluar f en t(n+1) en lugar de t(n).
    - Olvidar que Euler utiliza la pendiente inicial
      del intervalo.
    - Pensar que un h grande siempre funciona.
    - Olvidar que es condicionalmente estable.

Traducción de consigna:
"Euler" "Euler hacia adelante" "Forward Euler"
"Método explícito orden 1"
"Método de un paso orden 1"

-> euler(...)

Resumen:
    Tipo          : Explícito
    Orden         : 1
    Error global  : O(h)
    Error local   : O(h^2)
    Estabilidad   : Condicional
    Costo         : 1 evaluación de f por paso

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
