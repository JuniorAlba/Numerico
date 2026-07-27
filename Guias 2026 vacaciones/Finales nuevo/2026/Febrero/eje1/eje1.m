addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
fase = 0.02;
w = 1;
l1 = 1;
l0 = 10;
g = 9.81;
l = @(t) l0 + l1*cos(w*t + fase);
dl = @(t) -w*l1*sin(w*t + fase);
p = @(t) -2*dl(t)./l(t);
q = @(t) -g./l(t);
r = @(t) t*0;
f = @(t) [p(t)  q(t) r(t)];

%ITEM A --------------

inter = [0 5];
alpha = 0.5;
rob = [0 1 0];
L_A = 1000;
[x,y] = dif_fin_rob(f,inter,alpha,rob,L_A);
%usamos la formula de diferencias finitas progresivas
h = (inter(2)-inter(1))/L_A;
dy_0 = (-3*y(1)+4*y(2)-y(3))/(2*h);
error_A = [inf];

while(error_A(end)>0.5e-3)
    dy_old = dy_0;
    L_A = 2*L_A;
    [x,y] = dif_fin_rob(f,inter,alpha,rob,L_A);
    h = (inter(2)-inter(1))/L_A;
    dy_0 = (-3*y(1)+4*y(2)-y(3))/(2*h);
    error_A = [error_A; abs(dy_0 - dy_old)];
endwhile
error_A(end)
dy_0
%resultados:
%dy(0) = 0.121


%ITEM B --------------

inter = [0 5];
%elijo un intervalo par para que caiga un nodo justo en t=2.5
L_B = 1000;
[x,y_ant] = dif_fin_rob(f,inter,alpha,rob,L_B);
error_B = [inf];
while(error_B(end)>0.5e-5)
    L_B = 2*L_B;
    [x,y] = dif_fin_rob(f,inter,alpha,rob,L_B);
    error_B = [error_B; abs(y(L_B/2+1)-y_ant(L_B/4+1))];
    y_ant = y;
endwhile
error_B(end)
y(L_B/2+1)
%resultados:
%el pendulo se encuentra a la izquierda (signo menos)
%con una vertical de amplitud 0.38188


%ITEM C --------------

inter = [0 5];
rob = [0 1 0];
L_C = 50;
[x,y] = dif_fin_rob(f,inter,alpha,rob,L_C);
%vamos a aproximar la derivada de y (en todo el intervalo) con las formula de 3 puntos
dy = aproximar_derivada(x,y);   %utiliza la regla de tres puntos
q = trapcomp(x,abs(dy));
error_C = [inf];
while(error_C(end)>5e-5)
    q_old = q;
    L_C = 2*L_C;
    [x,y] = dif_fin_rob(f,inter,alpha,rob,L_C);
    dy = aproximar_derivada(x,y);   
    q = trapcomp(x,abs(dy));
    error_C = [error_C; abs(q - q_old)/q];
endwhile
L_C
error_C(end)
q
%resultados:
%1.7867
