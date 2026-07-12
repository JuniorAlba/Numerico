format long;
cons = 80/pi;
f = @(t,r) [r(2) ; -r(1)./((r(1).^2 + r(3).^2).^(3/2))*cons ; r(4) ; -r(3)./((r(1).^2 + r(3).^2).^(3/2))*cons];
y0 = [1.382 0 0 5.573];
tol = 1e-3;

%inciso a
inter = [0 1.5];
L=10;
[t,r]=rk4(f,inter,y0,L);
while(true)
    L=2*L;
    t_ant = t;
    r_ant = r;
    [t,r]=rk4(f,inter,y0,L);
    cond1 = abs(r(end,1) - r_ant(end,1))<tol;
    cond2 = abs(r(end,3) - r_ant(end,3))<tol;
    if(cond1 && cond2)
        break;
    endif
endwhile
r(end,1)
% x(1.5) = -2.726
%La respuesta correcta es: -2.7267722

r(end,3)
%La respuesta correcta es: 3.1929545
% y(1.5) = 3.192

%inciso b'
%plot(x,y)
inter = [0 11];
%probando intervalos para ver cuando completaba la orbita, vemos que en 11 añoa la completa
%es decir, solo hace falta ver en que momento dentro de esos 11 años se da el afelio
dist = @(x,y) sqrt(x(:).^2 + y(:).^2);
[t_ant,r_ant]=rk4(f,inter,y0,L);
[val_ant, indice_ant] = max(dist(r_ant(:,1), r_ant(:,3)));

while(true)
    L = L*2;
    [t, r] = rk4(f, inter, y0, L);
    [val, indice] = max(dist(r(:,1), r(:,3)));
    cond1 = abs(r(indice,1) - r_ant(indice_ant,1)) < 0.5e-3;
    cond2 = abs(r(indice,3) - r_ant(indice_ant,3)) < 0.5e-3;
    cond3 = abs(t(indice) - t_ant(indice_ant)) < 0.5e-3;
    if(cond1 && cond2 && cond3)
        break;
    endif
    r_ant = r;
    t_ant = t;
    indice_ant = indice;
endwhile
r(indice,1)
%-7.408
%La respuesta correcta es: -7.408425
r(indice,3)
%-0.00425
%La respuesta correcta es: -0.001
t(indice)
%5.740
%La respuesta correcta es: 5.7375



%inciso c
inter = [0 50];
[t,r]=rk4(f,inter,y0,1000);
plot(t,r(:,1))
%se observan 4 vueltas
%La respuesta correcta es: 4


%inciso d
inter = [0 10];
[t,r]=rk4(f,inter,y0,1000);
datos = dist(r(:,2),r(:,4));
total = trapcomp(t,datos)
%18.360
%La respuesta correcta es: 18.3609331
