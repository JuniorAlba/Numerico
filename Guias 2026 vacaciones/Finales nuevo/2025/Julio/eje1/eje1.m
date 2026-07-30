addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
k = 50;
u = 0.3;
g = 9.8;
tita = pi/180*30;
m = 1;
Fr = @(v) u*m*g*cos(tita).*(v<0) - u*m*g*cos(tita).*(v>0);
Px = m*g*sin(tita);
f = @(t,x) [x(2) ; -k/m*x(1) + Fr(x(2))/m - Px/m];
x0 = [0.5 0];
inter = [0 1];

%ITEM A------------------------------
pasos = 1000;
[t,x_ant] = rk4(f,inter,x0,pasos);

pasos = 2*pasos;
[t,x] = rk4(f,inter,x0,pasos);
error_A = abs(x(end,1)-x_ant(end,1))<0.5e-3
x(end,1)
x(end,2)
%resultados:
%0.195
%baja

%ITEM B----------------------------
h = 0.5e-3;
pasos = (inter(2)-inter(1))/h;
[t,x] = rk4(f,inter,x0,pasos);
idx = find(x(1:end-1,2).*x(2:end,2)<0)(1);
v_ant = [t(idx) x(idx,1)];

pasos = pasos*2;
[t,x] = rk4(f,inter,x0,pasos);
idx = find(x(1:end-1,2).*x(2:end,2)<0)(1);
v = [t(idx) x(idx,1)];

error_B = norm(v-v_ant,inf)<0.5e-3
x(idx,1)
t(idx)

%result:
%distancia=0.594
%t=0.444



%ITEM C------------------------------
F_roz_max = u*m*g*cos(tita);

inter = [0 5];
h = 0.5e-3; 
pasos = (inter(2)-inter(1))/h;
[t,x] = rk4(f,inter,x0,pasos);

% Encontrar TODOS los cruces por cero de la velocidad
cruces = find(x(1:end-1,2).*x(2:end,2) <= 0);
% De todos esos cruces, buscar el PRIMERO donde la fuerza neta no supera al rozamiento
idx_cruce = find(abs(-k*x(cruces,1) - Px) <= F_roz_max)(1);
% Recuperar el índice original
idx = cruces(idx_cruce);
vector_c_ant = [x(idx,1) t(idx)];

% Volver a hacer lo mismo para el doble de pasos
pasos = 2*pasos;
[t,x] = rk4(f,inter,x0,pasos);
cruces = find(x(1:end-1,2).*x(2:end,2) <= 0);
idx_cruce = find(abs(-k*x(cruces,1) - Px) <= F_roz_max)(1);
idx = cruces(idx_cruce);
vector_c = [x(idx,1) t(idx)];

error_c = norm(vector_c - vector_c_ant, inf) < 0.5e-3
vector_c

%resultados correctos de la simulación
%pos= -0.111
%tiempo = 2.67







