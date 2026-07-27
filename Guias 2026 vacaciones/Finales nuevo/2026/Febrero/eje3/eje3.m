addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
alturas=0:1000:5000;
densidades=[1.225 1.112 1.007 0.909 0.819 0.736];
m = 80;
[P,dP,ddP] = funcion_spline(alturas,densidades);
A = 0.7;
g = 9.81;
Cd = 0.8;
inter = [0 300];
f = @(t,x) [x(2) ; 1/(2*m)*P(x(1))*Cd*A*(x(2)).^2-g];
x0 =[5000 0];

%ITEM A -------------------
h = 0.1;
L = (inter(2)-inter(1))/h;
[t,y] = rk4(f,inter,x0,L);
pos_cruce=find(y(1:end-1,1).*y(2:end,1)<=0);
tc_ant=t(pos_cruce(1))

[t,y] = rk4(f,inter,x0,L*2);
pos_cruce=find(y(1:end-1,1).*y(2:end,1)<=0);
tc=t(pos_cruce(1))
abs(tc-tc_ant)

%resultado: error = 4.99999999999971e-2
%entonces dos cifras exactas
%tc = 96.15

%ITEM B -------------------
L=100;
inter = [0 30];
[t,y] = rk4(f,inter,x0,L);
aceleracion = f(30,y(end,:))(2);
error_B = [inf];
while(error_B(end) >= 5e-6)
    aceleracion_ant = aceleracion;
    L = 2*L;
    [t,y] = rk4(f,inter,x0,L);
    aceleracion = f(30,y(end,:))(2);
    error_B = [error_B abs(aceleracion-aceleracion_ant)/abs(aceleracion)];
endwhile
aceleracion
% Resultado exacto: 0.172985


%ITEM C ------------------
plot(t,y(:,2))
%Si ploteamos la velocidad en el item B, podemos ver es creciente
%en magnitud hasta que empieza a decaer al rededor de los 16s
%por lo que el intervalo de integracion actual es mas que suficiente
L=100;
[t,y] = rk4(f,inter,x0,L);
[_,idx] = max(abs(y(:,2)));
max_t_v = [t(idx) y(idx,2)];
error_B = [inf];
while(error_B(end) >= 5e-4)
    max_t_v_ant = max_t_v;
    L = 2*L;
    [t,y] = rk4(f,inter,x0,L);
    [_,idx]  = max(abs(y(:,2)));
    max_t_v = [t(idx) y(idx,2)];
    error_B = [error_B norm(max_t_v-max_t_v_ant,inf)/norm(max_t_v,inf)];
endwhile
max_t_v

%resultados:
%t=16.63
%v=59.27