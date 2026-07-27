addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
f_aux = @(x,y) -80./(pi*(x.^2+y.^2).^(3/2));
f = @(t,r) [r(3) ; r(4) ; f_aux(r(1),r(2)).*r(1) ; f_aux(r(1),r(2)).*r(2)];
inter = [0 1.5];
r0 = [1.382 0 0 5.573];
L = 500;

%ITEM A --------------------
[t,r] = rk4(f,inter,r0,L);
error_A = [inf];
r_ant = r;
while(error_A(end)>=1e-3)
    L = 2*L;
    [t,r]=rk4(f,inter,r0,L);
    error_A = [error_A; norm([r(end,1) r(end,2)] - [r_ant(end,1) r_ant(end,2)],inf)];
    r_ant = r;
endwhile
error_A(end)
[r(end,1) r(end,2)]
%resultados:
%x(1.5) = -2.726
%y(1.5) = 3.192


%ITEM B --------------------
%Primero deberiamos ver si en 1.5años llega a dar una vuelta al sol
inter = [0 12]; %Con este intervalo si llega a dar una vuelta al sol
% ITEM B: Búsqueda del afelio con error < 1e-3
L_B = 1000;
[t, r] = rk4(f, [0 12], r0, L_B);
[max_d, indice] = max(sqrt(r(:,1).^2 + r(:,2).^2));
af_ant = [r(indice,1), r(indice,2), t(indice)];   % [x, y, t] anterior
error_B = inf;
while (error_B >= 1e-3)
    L_B = 2 * L_B;
    [t, r] = rk4(f, [0 12], r0, L_B);
    [max_d, indice] = max(sqrt(r(:,1).^2 + r(:,2).^2));
    af = [r(indice,1), r(indice,2), t(indice)];  % [x, y, t] nuevo
    
    error_B = norm(af - af_ant, inf);
    af_ant = af;
endwhile
af
%resultados:
%x(af_t) = -7.408
%y(af_t) = 5.563e-04
%af_t = 5.736


%ITEM C --------------------
L_C = 10000;
[t, r] = rk4(f, [0 50], r0, L_C);
plot(t,r(:,1))
%se ven 4 vueltas


% ITEM D -------------------
L_D = 1000;
[t, r] = rk4(f, [0 10], r0, L_D);
dist_ant = trapcomp(t, sqrt(r(:,3).^2 + r(:,4).^2));
error_D = inf;
while (error_D >= 1e-3)
    L_D = 2 * L_D;
    [t, r] = rk4(f, [0 10], r0, L_D);
    dist = trapcomp(t, sqrt(r(:,3).^2 + r(:,4).^2));
    
    error_D = abs(dist - dist_ant);
    dist_ant = dist;
endwhile
dist
error_D
% resultado: dist_ant = 18.361 UA