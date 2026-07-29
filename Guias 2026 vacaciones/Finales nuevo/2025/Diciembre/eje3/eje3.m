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
L = 10000;
[x,C] = rk4(f,inter,C0,L);
[Cmax,idx] = max(C(:,1));
Cx_ant = [Cmax,x(idx)];

[x,C] = rk4(f,inter,C0,L*2);
[Cmax,idx] = max(C(:,1));
Cx = [Cmax,x(idx)];


error_A = norm(Cx-Cx_ant,inf) <0.5e-4
Cmax
xmax = x(idx)
%resultado Cmax = 5.5580
%xmax = 1.5329

%ITEM B -------------------

