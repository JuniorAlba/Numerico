addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
t = [0 3 5 8 12];
x = [0 80 140 220 350];
v = [22 26 28 24 32];
[S,dS,ddS] = funcion_spline(t,x,v(1),v(end));

%ITEM A -------------
t_2 = linspace(t(2),t(3),4);
[p_2] = polyfit(t_2,S(t_2),3);
p_2(2)

t_3 = linspace(t(3),t(4),4);
[p_3] = polyfit(t_3,S(t_3),3);
p_3(4)
%resultados:
%4.51
%-95.74

%ITEM B --------------
t_fine = linspace(0, 12, 1000);
plot(t_fine, ddS(t_fine));
%tiene 3 raices
%entre 0 y 5
%entre 5 y 8
%entre 8 y 12
%pero solo una corresponde al maximo en el intervalo [0,12], la que esta entre
% 8 y 12
tol = 0.5e-6;
itmax = 10000;
[p,h,it]=biseccion(ddS,8,12,itmax,tol);
dS(p)
p
%resultados:
%velocidad = 33.74
%p = 10.506458

%ITEM C --------------------
error_rel = abs(v(4)-dS(8))/abs(v(4))
%resultado:
%error_rel = 0.2016


%ITEM D -------------------
[S2,dS2,ddS2] = funcion_spline(t,v);
L = 1000;
n = 3;
q = intNCcompuesta(S2,0,10,L,n)
error_rel = abs(S(10)-q)/abs(S(10))
%resultado:
%pos = 253.75
%error_rel = 0.1047

