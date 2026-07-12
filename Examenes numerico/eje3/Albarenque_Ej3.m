format long;

%inciso a
y0 = [1.382 0 0 5.573];
f = @(t,z) [ z(2); -z(1)./((z(1).^2 + z(3).^2).^(3/2))*80/pi ; z(4) ; -z(3)./((z(1).^2 + z(3).^2).^(3/2))*80/pi];
[t,y_ant] = rk4(f,[0 1.5], y0,1000);
pos_ant = [y_ant(end,1) y_ant(end,3)];
[t,y] = rk4(f,[0 1.5], y0,2000);
pos_actual = [y(end,1) y(end,3)];
dif = norm(pos_actual-pos_ant);
dif<1e-3
y(end,1)
y(end,3)

%inciso b
inter = [0 12]; %vi ploteando que en este intervalo llega a completar una vuelta
[t_ant,y_ant] = rk4(f,inter,y0,1000);
distancia_ant = sqrt(y_ant(:,1).^2 + y_ant(:,3).^2);
[valor_ant, indice_ant] = max(distancia_ant);
disp("inciso b")
[t,y] = rk4(f,inter,y0,2000);
distancia = sqrt(y(:,1).^2 + y(:,3).^2);
[valor, indice] = max(distancia);
abs(valor - valor_ant)<1e-3
abs(t_ant(indice_ant)-t(indice))<1e-3
abs(y_ant(indice_ant,1)-y(indice,1))<1e-3
abs(y_ant(indice_ant,3)-y(indice,3))<1e-3
t(indice)
y(indice,1)
y(indice,3)


%item C
inter = [0 50];
y0 = [1.382 0 0 5.573];
L = 100;
[t,y_ant] = rk4(f,inter,y0,L);
pos_ant = [y_ant(end,1) y_ant(end,3)];

L=2*L;
[t,y] = rk4(f,inter,y0,L);
pos_actual = [y(end,1) y(end,3)];

dif = [ norm(pos_actual-pos_ant)];
pos_ant = pos_actual;
while(L<10000 && dif(end)>= 0.5e-3)
    L = 2*L;
    [t,y] = rk4(f,inter,y0,L);
    pos_actual = [y(end,1) y(end,3)];
    dif = [dif; norm(pos_actual-pos_ant)];
    pos_ant = pos_actual;
endwhile
plot(t,y(:,1))
%se observan 4 vueltas completadas


%item d

[t,y] = rk4(f,[0 10],y0,L);
vel = sqrt(y(:,2).^2 + y(:,4).^2);
dist = trapcomp(t,abs(vel))
