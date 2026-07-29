addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
coef_intercambio = 1.5;
L = 4;
ye = 1;
k = 1.2;
yr = 0.9;

x_tabla = [0 1 3 4];
y_tabla = [1.25 1.4 1.0 1.11];
[coef]= polyfit(x_tabla,y_tabla,3);
coef_d = [3*coef(1) 2*coef(2) coef(3)];
A =@(x) polyval(coef,x);
dA =@(x) polyval(coef_d,x);
p = @(x) dA(x)./(A(x));
q = @(x) A(x)*coef_intercambio;
r = @(x) -1*A(x)*coef_intercambio*ye;
f = @(x) [p(x) q(x) r(x)];
inter = [0 L];
ycd = 0.8;
rob = [1/k 1 yr];
pasos = 1000;

%ITEM A -------------
[x y] = dif_fin_rob(f,inter,ycd,rob,pasos);
[val ind] = max(y);
[x(ind) y(ind)]

%resultados:
%altura: 0.9868
%a 2.412 metros de la entrada

%ITEM B ---------------
%hay que estimar la derivada de y con diferencias finitas
pasos = 2000;
[x y] = dif_fin_rob(f,inter,ycd,rob,pasos);
dy = aproximar_derivada(x,y);
q = -1./(A(x)).*dy;
q_ant = q(end);

pasos = pasos*2;
[x y] = dif_fin_rob(f,inter,ycd,rob,pasos);
dy = aproximar_derivada(x,y);
q = -1./(A(x)).*dy;
q= q(end);

error_B = abs(q- q_ant)/abs(q)

%el flujo especifico:
q(end)
%resultado:
%5.58726e-2

%ITEM C ------------
p=@(x) f(x)(:,1);
q=@(x) f(x)(:,2);
r=@(x) f(x)(:,3);

# division del intervalo
deltax=0.1;
pasos = (inter(2)-inter(1))/deltax;
x=linspace(inter(1),inter(2),pasos+1)';
h=(inter(2)-inter(1))/pasos;

# construccion de la matriz
col=[-1-h/2*p(x(3:end)) 2+h^2*q(x(2:end-1)) -1+h/2*p(x(1:end-2))];
col=[col;0 2+h^2*q(x(end)) -1+h/2*p(x(end-1))];
A = spdiags(col, [-1 0 1], pasos+1, pasos+1);
A(end-1,end)=-1+h/2*p(x(end));
A(end,end-2:end)=[-rob(1) 2*h*rob(2) rob(1)];

# construccion del vector de terminos idependientes
b = -h^2*r(x(2:end));
b(1)+=(1+h/2*p(x(2)))*ycd;
b(end+1)=2*h*rob(3);

tol = 1e-6;
x0 = ycd*ones(length(x),1);
[x,it,r_h] = gauss_seidel(A,b,x0,10000,tol);
it
max(x)
r_h(end)
%resultado: it=407


