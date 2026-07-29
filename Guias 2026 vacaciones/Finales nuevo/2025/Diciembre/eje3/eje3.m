addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
D0 = 1.2e-4;
alfa = 0.15;
v = 2e-3;
k = 1.2e-3;
D = @(x) D0*(1+alfa*x);
dD = @(x) D0*alfa;
f = @(x,C) [C(2) ; (-dD(x)-v)./(D(x)).*C(2)-k./(D(x)).*C(1).^2];
inter = [1.5 3];
C0 = [5.4 10.3];

%ITEM A --------------------
h = 0.5e-4;
pasos = (inter(2)-inter(1))/h;
[x,C] = rk4(f,inter,C0,pasos);
[Cmax,idx] = max(C(:,1));
Cx_ant = [Cmax,x(idx)];

[x,C] = rk4(f,inter,C0,pasos*2);
[Cmax,idx] = max(C(:,1));
Cx = [Cmax,x(idx)];


error_A = norm(Cx-Cx_ant,inf) <0.5e-4
Cmax
xmax = x(idx)
%resultado Cmax = 5.5580
%xmax = 1.5329

%ITEM B -------------------
h = 0.5e-4;
pasos = (inter(2)-inter(1))/h;
[x,C] = rk4(f,inter,C0,pasos);
flujo_dif = -D(x).*C(:,2);
[Jmax,idx] = max(abs(flujo_dif));
valor_C_ant = [Jmax,x(idx),C(idx,1)];

[x,C] = rk4(f,inter,C0,pasos*2);
flujo_dif = -D(x).*C(:,2);
[Jmax,idx] = max(abs(flujo_dif));
valor_C = [Jmax,x(idx),C(idx,1)];

error_B = norm(valor_C - valor_C_ant,inf) < 0.5e-4
Jmax
Xjmax = x(idx)
C_xjmax = C(idx,1)

%resutlados:
%Jmax = 0.0018
%Xjmax = 1.6570
%C_jmax = 4.4884


%ITEM C --------------------
h = 0.5e-2;
pasos = (inter(2)-inter(1))/h;
[x,C] = rk4(f,inter,C0,pasos);
ddC = (-dD(x)-v)./(D(x)).*C(:,2)-k./(D(x)).*C(:,1).^2;
difusion_axial = D(x).*ddC;
plot(x,abs(difusion_axial)-0.001)
idx_mayores = find(abs(difusion_axial) >= 0.001);
idx_final = idx_mayores(end) + 1;
valor_punto_ant = x(idx_final)




[x,C] = rk4(f,inter,C0,pasos*2);
ddC = (-dD(x)-v)./(D(x)).*C(:,2)-k./(D(x)).*C(:,1).^2;
difusion_axial = D(x).*ddC;
idx = find(abs(difusion_axial)-0.001 < 0)(1);
idx_mayores = find(abs(difusion_axial) >= 0.001);
idx_final = idx_mayores(end) + 1;
valor_punto = x(idx_final)

error_C = abs(valor_punto-valor_punto_ant)<0.5e-2
valor_punto
%resultado
%x = 2.14


