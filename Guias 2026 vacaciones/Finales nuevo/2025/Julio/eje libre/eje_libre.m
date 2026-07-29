addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
z_tabla = [0 0.5 1 1.5 2 2.5 3];
T_tabla = [70 68 55 22 13 11 10];


[T,dT,ddT] = funcion_spline(z_tabla,T_tabla);

z_interp = linspace(z_tabla(1),z_tabla(end),1000);
figure(1)
plot(z_interp,dT(z_interp))

%item A -----------------------

[p,h,it] = biseccion(ddT,1,1.5,10000,5e-5);
p
%result
%1.2314


%item B-------------------
T(p)
%result
%39.46

%item C------------------
flujo_interfaz = -0.02*dT(p)
%result
%1.4663
