addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
A = 0.01;
k0 = 0.57;
L = 2;
C = 0.217;
P = 2.7;
H = 10;
ue = 4;
f_fuente = @(x) 12*cos(2*x);
Cr = @(x) 5*(x-2);
f = @(x) [0.*x 1/k0*Cr(x) -1/k0*f_fuente(x)];
inter = [0 L];
ycd = 6;
rob = [k0 H H*ue];

%ITEM A ---------------------------

pasos = 2000;
[x,T_ant] = dif_fin_rob(f,inter,ycd,rob,pasos);

pasos = 2*pasos;
[x,T] = dif_fin_rob(f,inter,ycd,rob,pasos);

T(end)
%resultado
%T(end) = 0.1413

error_A = abs(T(end)-T_ant(end))<0.5e-4


%ITEM B ---------------------------

pasos = 2000;
[x,T] = dif_fin_rob(f,inter,ycd,rob,pasos);
dT = aproximar_derivada(x,T);
flujo_ant = -k0*dT(end);


pasos = 2*pasos;
[x,T] = dif_fin_rob(f,inter,ycd,rob,pasos);
dT = aproximar_derivada(x,T);
flujo = -k0*dT(end);

error_B = abs(flujo-flujo_ant)/abs(flujo)<5e-5
flujo
%resultado:
%flujo = -38.587


%ITEM C ---------------------------

E = A*trapcomp(x,C*P*T)
%resultado
%E = -0.0707


%ITEM D ---------------------------

inter = [0 L];
T0 = [6 -48/-k0];
f = @(x,T) [T(2) ; 1/k0*Cr(x).*T(1)-1/k0*f_fuente(x)];

pasos = 1000;
[x,T_ant] = rk4(f,inter,T0,pasos);

pasos = pasos*2;
[x,T] = rk4(f,inter,T0,pasos);
error_D = abs(T(end,1)-T_ant(end,1))/abs(T(end,1))<5e-6
T(end,1)
%resultado
%4.58502