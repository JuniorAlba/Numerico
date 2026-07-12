format long;
alturas=0:1000:5000;
rhos=[1.225 1.112 1.007 0.909 0.819 0.736];

m=80;        #masa
Cd = 0.8;    #Coeficiente de arrastre
A=0.7;       #area frontal
g=9.81;      #gravedad

#Hay que realizar un interpolacion por splines cubicos para la densidad
[p,dp,ddp] = funcion_spline(alturas,rhos);


%Ahora se requiere saber en que instante de tiempo el paracaidista toca el suelo
%Vemos que nuestra ecuacion depende de la velocidad y de la altura
%Por lo cual si quisiera resolver para encontrar v(t) no puedo
%Deberia armar un sistema de ecuaciones para encontrar la altura
%ec1: da = v
%ec2: dv = -g + 1/(2*m)*p(a)*Cd*A*v
f = @(t,a) [a(2); -g + 1./(2*m).*p(a(1)).*Cd.*A.*a(2).^2];

%Para obtener el t final probar con un t cualquiera, ver si la altura llega a hacerse negativa
%sino, aumentar el intervalo
t0 = 0;
t1 = 100;
h = 0.1;
L = (t1-t0)/h;
[t,a] = rk4(f,[t0 t1], [5000 0], L);
plot(t,a(:,2))
% disp([t,a(:,1)]);
%    9.6100e+01   4.0194e+00
%    9.6200e+01  -7.9125e-01
%    9.6300e+01  -5.6669e+00

%Con L mas grande
% 9.6180e+01   1.7079e-01
% 9.6190e+01  -3.1056e-01
% 9.6200e+01  -7.9290e-01

disp("Para una mayor cantidad de intervalos solo se mantienen 2 cifras del resultado")
disp("Tiempo: 96.2")

t1=30;
h=0.05;
L = (t1-t0)/h;
[t,a] = rk4(f,[t0 t1], [5000 0], L);
% con h= 0.5  acel=0.172984971123267
% con h= 0.1  acel=0.172985073584583
% con h= 0.05 acel=0.172985073721536
% con h = 0.05 se logran mas de 6 cifras significativas
disp(f(t(end),[a(end,1); a(end,2)])(2))
% abs(a(end,1)-a_ant(end,1))/abs(a(end,1))<0.5e-6

%item C
%Con el plot que hicimos en el item a sabemos que el maximo esta entre [0 30]
% === ITEM C ===
disp('--- Resolviendo Item C ---');

% t0 = 0;
% t1 = 30; % Sabemos por el plot que el pico está en este rango

% %necesitamos el tiempo tenga 4 cifras exactas para ello: (t1-t0)/L<tol -> L > (t1-t0)/tol
% L = (t1-t0)/(0.5e-4)+1;
% [t,a] = rk4(f,[t0 t1], [5000 0], L);
% [valor,indice]=max(abs(a(:,2)));
% valor
% t(indice)
%NO SE PUEDE RESOLVER POR FUERZA BRUTA,
% === ITEM C ===
disp('--- Resolviendo Item C ---');

t0 = 0;
t1 = 17; % Sabemos por el plot que el pico está en este rango
L = 100; % Empezamos con una malla amigable

% Primera corrida base
[t, a_rk] = rk4(f, [t0 t1], [5000 0], L);
[vel_max, idx] = max(abs(a_rk(:,2)));
t_max = t(idx);

while (1)
    % Guardamos los valores de la iteración anterior
    t_max_ant = t_max;
    vel_max_ant = vel_max;

    L = L * 2; % Refinamos la malla
    [t, a_rk] = rk4(f, [t0 t1], [5000 0], L);

    % Buscamos el nuevo máximo
    [vel_max, idx] = max(abs(a_rk(:,2)));
    t_max = t(idx);

    % Calculamos el error absoluto para ambas variables
    error_t = abs(t_max - t_max_ant);
    error_v = abs(vel_max - vel_max_ant);

    % Condición de corte: 4 cifras decimales exactas para ambos
    if (error_t < 0.5e-4 && error_v < 0.5e-4)
        break;
    endif
endwhile

fprintf('Tiempo de máxima velocidad: %.4f s\n', t_max);
fprintf('Magnitud de la velocidad máxima: %.4f m/s\n', vel_max);
fprintf('(Convergencia alcanzada con L = %d)\n', L);