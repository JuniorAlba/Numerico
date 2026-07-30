addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
%ITEM A--------
yc = [1 1]; % y(-1)=1, y(1)=1
inter = [-1 1];
f = @(x) [2*x./(1-x.^2) -42./(1-x.^2) x.*0];
% Hay que elegir L para que haya un x=0 exacto (L par asegura esto)
L=8000;
[x,y] = dif_fin_dir(f,inter,yc,L);
idx = find(x==0);
yval_ant = y(idx);


L = 2*L;
[x,y] = dif_fin_dir(f,inter,yc,L);
idx = find(x==0);
yval = y(idx);


error_A = abs(yval-yval_ant)<0.5e-6
yval
% Resultados:
% yval = -0.312500


%ITEM B--------
% Ajuste polinomial de grado 6
p = polyfit(x, y, 6);
% polyfit devuelve [a6, a5, a4, a3, a2, a1, a0]
a0 = p(7)
a1 = p(6)
a2 = p(5)
a3 = p(4)
a4 = p(3)
a5 = p(2)
a6 = p(1)
%resultados:
%a0 = -0.313
%a1 = 0
%a2 = 6.563
%a3 = 0
%a4 = -19.688
%a5 = 0
%a6 = 14.438



%ITEM C--------
% Raíces del polinomio de grado 6
[p1,h,it]  = biseccion(@(x) polyval(p,x),0,0.5,1000,0.5e-8);
[p2,h,it]  = biseccion(@(x) polyval(p,x),0.5,0.75,1000,0.5e-8);
[p3,h,it]  = biseccion(@(x) polyval(p,x),0.75,1,1000,0.5e-8);
p1
p2
p3
%resultados:
%p1=0.23861918
%p2=0.66120937
%p3=0.93246950