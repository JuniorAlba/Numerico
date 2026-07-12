format long;
L = 4;
volum = 1.5;
ye = 1;
k = 1.2;
yr=0.9;
A_datos = [1.25 1.4 1.0 1.11]';
x_datos = [0 1 3 4]';
c = polyfit(x_datos,A_datos,3);
A = @(x) c(1)*x.^3 + c(2)*x.^2+c(3)*x.^1+c(4);
dA = @(x) 3*c(1)*x.^2+2*c(2)*x+c(3);
p = @(x) dA(x)./(A(x).^2);
q = @(x) volum./(A(x));
r = @(x) -volum*ye./(A(x));
f = @(x) [p(x) q(x) r(x)];


%inciso a
alpha = 0.8;
[x_ant,y_ant]=dif_fin_rob(f,[0 L],alpha,[1 k k*yr],2500);
[x,y]=dif_fin_rob(f,[0 L],alpha,[1 k k*yr],5000);
[valor_ant,indice_ant] = max(y_ant);
[valor,indice] = max(y);
abs(valor - valor_ant)<0.5e-6
abs(x(indice)- x_ant(indice_ant))<0.5e-4
h = L/5000;
[valor, indice] = max(y(:));
valor
x(indice)

%inciso B
% 1. Calculamos el vector de la derivada y_prima para todos los nodos
subint = 5000;
yp = zeros(subint+1, 1);
% Extremo inicial (hacia adelante de 3 puntos)
yp(1) = (-3*y(1) + 4*y(2) - y(3)) / (2*h);
% Nodos interiores (centrada de 3 puntos)
yp(2:subint) = (y(3:subint+1) - y(1:subint-1)) / (2*h);
% Extremo final (hacia atrás de 3 puntos)
yp(subint+1) = (3*y(subint+1) - 4*y(subint) + y(subint-1)) / (2*h);
flujo_longi = -1/A(x)*yp;
flujo_longi(end)

%inciso c


