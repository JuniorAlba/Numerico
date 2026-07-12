k0 =1;
fuente=@(x) 20*sin(5*(x-1));
p = @(x) 0.*x;
q = @(x) 0.*x;
% q = @(x) 2 ./k0  + 0 .*x;
r = @(x) -fuente(x)./k0;
f = @(x) [p(x) q(x) r(x)];

Long= 3;
inter = [0 Long];
yc = 21;
rob = [1 0 0];

%itero dos veces antes para tener un error antes de empezar

h=0.1;
L = (inter(2)-inter(1))/h;
[x_ant,y_ant] = dif_fin_rob(f,inter,yc,rob,L);

h = h/2;
L = (inter(2)-inter(1))/h;
[x,y] = dif_fin_rob(f,inter,yc,rob,L);
error_metodo = [abs(y(end)-y_ant(end))];

y_ant = y;
hmin = 1/(10^5);
i = 1;
while(h>hmin && error_metodo(end) >=0.5e-2)
    h=h/2;
    L = (inter(2)-inter(1))/h;
    [x,y] = dif_fin_rob(f,inter,yc,rob,L);
    error_metodo = [error_metodo (abs(y(end)-y_ant(end)))];
    y_ant = y;
    i++;
endwhile
h
error_metodo(end)

[temp_max, indice] = max(y);
posicion_max = x(indice);

fprintf('Temperatura máxima: %.4f en x = %.4f\n', temp_max, posicion_max);

