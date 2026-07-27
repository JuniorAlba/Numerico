addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
k0 = 16.2;
k = 0.2;
C = 0.4;
Q_fuente = @(r) sin(pi.*r);
p = @(r) -(1+2*k)./(r*(1+k));
q = @(r) -C./(r*(1+k));
resto = @(r) 1./(r.^2*(1+k)).*Q_fuente(r);
f = @(r) [p(r)  q(r) resto(r)];
inter = [1 2];
ycd = 300;
rob = [1 0 -1/k0*750];

%ITEM A -----------------
L = 1000;
[r,T_ant] = dif_fin_rob(f,inter,ycd,rob,L);

L = 2*L;
[r,T] = dif_fin_rob(f,inter,ycd,rob,L);

error_A = abs(T(end)-T_ant(end))./abs(T(end))<5e-5
T(end)
%resultado T(end) = 270.22



%ITEM B ----------------
L = 1000;
[r,T_ant] = dif_fin_rob(f,inter,ycd,rob,L);
%ahora calculo la derivada en la pared interna
dT = aproximar_derivada(r,T_ant);
flujo_ant = -k0*dT(1);

L = 2*L;
[r,T] = dif_fin_rob(f,inter,ycd,rob,L);
dT = aproximar_derivada(r,T);
flujo = -k0*dT(1);

error_B = abs(flujo-flujo_ant)/abs(flujo)<5e-4
flujo
%resultado: flujo=15.68


%ITEM C --------------

L = 1000;
[r,T] = dif_fin_rob(f,inter,ycd,rob,L);
Tprom_ant = sum(T(1:end))/length(T);

L = 2*L;
[r,T] = dif_fin_rob(f,inter,ycd,rob,L);
Tprom = sum(T(1:end))/length(T);

error_C = abs(Tprom-Tprom_ant)<0.5e-2
Tprom
%resultado Tprom = 288.68

