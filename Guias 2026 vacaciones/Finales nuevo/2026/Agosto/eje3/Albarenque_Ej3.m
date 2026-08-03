addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;


f = @(h) -h.^3+5*sqrt(3)*h.^2-9*h-27*sqrt(3);
df = @(h) -3*h.^2 + 10*sqrt(3)*h-9;
roots([-1 5*sqrt(3) -9 -27*sqrt(3)])
tol = 1e-6;
h0 = 5;
itmax = 10000;

%ITEM A --------------
[x,h,it] = newton(f,df,h0,itmax,tol);
x
it
cocientes = h(2:end) ./ h(1:end-1)
%dado que los resultados son constantes, la convergencia del metodo es lineal
%resultados
%altura = 5.196152

%ITEM B -------------
b = 5;
I = b*x.^3/12
%58.45669


%ITEM C -------------
L = 150;
E = 2e4;
P = 40;
inter = [0 150];
f = @(x,y) [y(2);  (1+y(2).^2).^(3/2).*P/(E*I).*(L-x)];
pasos = 1000;
[x,y] = rk4(f,inter,[0 0],pasos);
[maxy ind] = max(y(:,1));
resultc_ant = [maxy x(ind)];

pasos = 2*pasos;
[x,y] = rk4(f,inter,[0 0],pasos);
[maxy ind] = max(y(:,1));
resultc = [maxy x(ind)];

error_c = norm(resultc-resultc_ant,inf)<0.5e-7
resultc

%resultados
%altura = 40.6417515
%x = 150

%ITEM D------------
[x,y] = rk4(f,inter,[0 0],pasos);
[indice] = find(y(:,2)>0.2)(1);
resultd_ant = y(indice,2);

pasos = 2*pasos;
[x,y] = rk4(f,inter,[0 0],pasos);
[indice] = find(y(:,2)>0.2)(1);
resultd = y(indice,2);

error_d = abs(resultd - resultd_ant)/abs(resultd)<5e-3
x(indice)

%x = 45.0




