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
p = @(x) dA(x)./A(x);
q = @(x) volum*(A(x));
r = @(x) -volum*ye*(A(x));
f = @(x) [p(x) q(x) r(x)];


%inciso a
alpha = 0.8;
subint=50;
[x,y]=dif_fin_rob(f,[0 L],alpha,[1 k k*yr],subint);
while(true)
    subint=2*subint;
    x_ant = x;
    y_ant = y;
    [x,y]=dif_fin_rob(f,[0 L],alpha,[1 k k*yr],subint);
    [valor_ant,indice_ant] = max(y_ant);
    [valor,indice] = max(y);
    if(abs(valor - valor_ant)<0.5e-6 && abs(x(indice)- x_ant(indice_ant))<0.5e-4)
        break;
    endif
endwhile
[valor,indice] = max(y);
valor
x(indice)




%inciso B
% 1. Calculamos el vector de la derivada y_prima para todos los nodos
h = L/subint;
xx = [0:h:L];
yp = zeros(subint+1, 1);
% Extremo inicial (hacia adelante de 3 puntos)
yp(1) = (-3*y(1) + 4*y(2) - y(3)) / (2*h);
% Nodos interiores (centrada de 3 puntos)
yp(2:subint) = (y(3:subint+1) - y(1:subint-1)) / (2*h);
% Extremo final (hacia atrás de 3 puntos)
yp(subint+1) = (3*y(subint+1) - 4*y(subint) + y(subint-1)) / (2*h);
flujo_longi = -1./A(xx).*yp;
flujo_longi(end)

%inciso c
#division del intervalo
inter = [0 L];
x=linspace(inter(1),inter(2),L+1)';
h=(inter(2)-inter(1))/L;

%inciso d
#construccion de la matriz
h=0.1;
x = [0:h:L];
rob = [1 k k*yr];
col=[-1-h/2*p(x(3:end)) 2+h^2*q(x(2:end-1)) -1+h/2*p(x(1:end-2))];
col=[col;0 2+h^2*q(x(end)) -1+h/2*p(x(end-1))];
A = spdiags(col, [-1 0 1], subint+1, subint+1);
A(end-1,end)=-1+h/2*p(x(end));
A(end,end-2:end)=[-rob(1) 2*h*rob(2) rob(1)];
#construccion del vector de terminos idependientes
b = -h^2*r(x(2:end));
b(1)+=(1+h/2*p(x(2)))*alpha;
b(end+1)=2*h*rob(3);

[y,it,r_h]=gauss_seidel(A,b,x0,5000,1e-6);
y



