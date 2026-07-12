%tiempo [s] posicion [m] velocidad [m/s]
format long;
t = [0 3 5 8 12];
x = [0 80 140 220 350];
v = [22 26 28 24 32];
[x_f,dx_f,ddx_f]=funcion_spline(t,x,v(1),v(end));

%inciso a
t_segundo_int= linspace(t(2),t(3),4);
x_segundo_int = x_f(t_segundo_int);
pol2 = polyfit(t_segundo_int,x_segundo_int,3);
pol2(2)
%ans = 4.51
%La respuesta correcta es: 4.51


t_tercer_int = linspace(t(3),t(4),4);
x_tercer_int = x_f(t_tercer_int);
pol3 = polyfit(t_tercer_int,x_tercer_int,3);
pol3(4)
%ans = -95.74
%La respuesta correcta es: -95.74

%inciso b
figure(1)
hold on;
tt = linspace(t(1),t(end),100);
plot(tt,ddx_f(tt));
plot([t(1) t(end)] , [0 0]);
%hay 3 valores que podrias corresponder con la velocidad maxima
%la velocidad al inicio no es la maxima (ya se puede ver en los datos)
%la velocidad al final tampoco es la maxima pq termina decreciendo
[p1,_,_] = Biseccion(ddx_f,0,4,1000,0.5e-6);
dx_f(p1)
[p2,_,_] = Biseccion(ddx_f,4,8,1000,0.5e-6);
dx_f(p2)
[p3,_,_] = Biseccion(ddx_f,8,12,1000,0.5e-6);
dx_f(p3)
p3
%la velocidad maxima se obtiene en 10.506457 y es de 33.74
%La respuesta correcta es: 33.74
%La respuesta correcta es: 10.506457

%inciso c
error_rel = abs(v(4)-dx_f(8))/v(4)
%error_rel = 0.2016
%La respuesta correcta es: 0.2016

%inciso d
[v_f,dv_f,ddv_f] = funcion_spline(t,v);



L = 10;
total_ant = intNCcompuesta(v_f,0,10,L,2);
while(true)
    L=2*L;
    total = intNCcompuesta(v_f,0,10,L,2);
    cond1 = abs(total-total_ant)<0.5e-2
    if(cond1)
        break;
    endif
    total_ant = total;
endwhile
total
%total = 253.74
%La respuesta correcta es: 253.74

error_rel = abs(x_f(10)-total)/abs(x_f(10))
%error_rel = 0.1046
%La respuesta correcta es: 0.1046