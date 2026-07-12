#EJERCICIO 3 FINAL 12/02/26 - Pfeiffer, Valentín Pedro
%obtengo la spline cubica
alturas=0:1000:5000;
rhos=[1.225 1.112 1.007 0.909 0.819 0.736];
[S,dS,ddS]=funcion_spline(alturas,rhos); %asumo que es natural ya que nunca se dan condiciones en las derivadas de la densidad
%fplot(S,[0,5000])
g=9.81;
m=80;
A=0.7;
Cd=0.8;
alt_a=5000; %alt de altura, altura inicial
vel_a=0; %velocidad inicial
sist=@(t,a) [ a(2) ; -g + (Cd.*A)./(2*m) .*S(a(1)) .*(a(2).^2)];
h=0.1;
ta=0;
tb=100; %empiezo probando con un tiempo arbitrario final tb=100;
N=(tb-ta)/h
[t,a]=rk4(sist,[ta,tb],[alt_a,vel_a],N);
plot(t,a(:,1)) %ploteo la altura a lo largo del tiempo. El momento en el que se haga cero corresponde a cuando llega al suelo
%zoomeando el plot anterior veo que el cero se encuentra entre 96 y 97.

%disp([t,a(:,1)]); %observo lado a lado los vectores para ver a cual valor de t le corresponde
%   9.6100e+01   4.0194e+00
%   9.6200e+01  -7.9125e-01
%   9.6300e+01  -5.6669e+00
%el t con paso h=0.1 que me da el valor más cercano a cero es 96,2.
%el t real es más cercano a 96.185. éste coincide en 2 cifras.

%inciso b
%rehago el rk4 pero más refinado, así tengo la precision deseada
h=0.002; %anteriormente probé con h=0.001, ahora con un paso la mitad de chico para verificar que las cifras identicas son las deseadas
N=(30-ta)/h %ajusto el t final a 30 para ya tener los valores de mi interes al final de los vectores
[t,a]=rk4(sist,[ta,30],[alt_a,vel_a],N);
acel_30=-g+(Cd.*A)./(2*m)*S(a(end,1))*(a(end,2)^2)

%inciso c
plot(t,a(:,2)); %ploteo la velocidad.
[vel_min,idx]=min(a(:,2)) %la mayor velocidad de caida va a ser negativa, asi que hallo el minimo en el vector
t(idx) %tiempo al alcanzar la velocidad máxima: 16.63200000000000
%velocidad máxima: 59.27267640402139

