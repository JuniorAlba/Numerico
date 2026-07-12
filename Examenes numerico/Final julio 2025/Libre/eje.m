format long;
z = [0 0.5 1.0 1.5 2.0 2.5 3]';
T = [70 68 55 22 13 11 10]';
%Necesitamos averiguar en que punto se anula la segunda deriva de la temperatura con respecto a la profundidad
%Debido a que no conocemos la funcion de la temperatura, la aproximamos con splines cubicos
%utilizando los datos
[T_s,dT_s,ddT_s] = funcion_spline(z,T);
zz = linspace(0,3,100);
figure(1)
hold on;
plot([0 3],[0 0],'-b');
plot(zz,ddT_s(zz),'-r');
%En el grafico de la derivada segunda se ve que pasa por 0 dentro del int [1 1.5]
[p,h,it] = Biseccion(ddT_s,1,1.5,1000,0.5e-5);
%Respuesta item A
%p = 1.2314
p
%Respuesta item B
%39.460
T_s(p)

%Respues item C
%-73.315

k=0.02;
%me piden el flujo en la interfaz (el punto que divide las dos zonas del tanque)
%pero me lo piden en cal/(s*cm^2), dado que esta expresado en centimetros, deberia 
%para que las unidades correspondan al resultado solicitado hace falta hacer el cambio de unidad
% [dT/dz] =  °C/m -> [dT/dz * 1/100] = °C/cm        Notar que uso [] para denotar las unidades de la expresion


J = -k*dT_s(p)/100