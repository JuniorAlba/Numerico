addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;

R = 0.5;
C = 2;
E = @(t) cos(pi*t/2);

t_tabla = [1 2 3 4 5];
L_tabla = [0.5 0.8 1 1.1 1.2];
[L,dL,ddL] = funcion_spline(t_tabla,L_tabla);

p = @(t) -1*(dL(t)./L(t) + R./L(t));
q = @(t) -1*(1./(C*L(t)));
r = @(t) E(t)./L(t);
f = @(t) [p(t) q(t) r(t)];
inter = [1 5];
ycd = 2;
rob = [L(5) 0 0.2];
pasos = 1000;
[x,y] = dif_fin_rob(f, inter, ycd, rob, pasos);


%ITEM A --------------------
% Calculamos I(3) para la primera malla
h = x(2) - x(1);
idx = find(x == 3);
I_3_ant = (y(idx+1) - y(idx-1)) / (2*h);
error_aprox = [inf];
while(error_aprox(end) >= 0.5e-5)
    pasos = 2*pasos;
    [x,y] = dif_fin_rob(f, inter, ycd, rob, pasos);
    
    h = x(2) - x(1);
    idx = find(x == 3);
    I_3 = (y(idx+1) - y(idx-1)) / (2*h);

    error_aprox = [error_aprox; abs(I_3 - I_3_ant)];
    I_3_ant = I_3;
endwhile
% Al salir del bucle, I(3) tiene garantizadas las 5 cifras exactas
%RESULTADO FINAL ITEM A:
%I(3) = -1.5897


%ITEM B --------------------
[x_b,y_b] = dif_fin_rob(f,inter,ycd,rob,80);
y(end)
error_b = abs(y(end)-y_b(end))<0.5e-3
%RESULTADO FINAL ITEM B:
%q(5) = -0.179
%3 decimales exactos


%ITEM C --------------------
%debemos calcular los valores de I
I = zeros(pasos+1,1);
%diferencias finitas progresivas
I(1) = (-3*y(1) + 4*y(2) -1*y(3))/(2*h);
%diferencias finitas centradas
I(2:end-1) = (y(3:end) - y(1:end-2))/(2*h);
%diferencias finitas regresivas
I(end) = (3*y(end) - 4*y(end-1) +1*y(end-2))/(2*h);

Pv = 1/2.*I.^2.*dL(x);
plot(x,Pv)
idx1 = find(x == 2);
idx2 = find(x == 3);
[valor, pos] = max(Pv(idx1:idx2));
idx = idx1 + pos - 1;  % Índice global en el vector original
valor
x(idx)
%RESULTADO FINAL ITEM C:
%Pv = 0.25
%t = 2.52



