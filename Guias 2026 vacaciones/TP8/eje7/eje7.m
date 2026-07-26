addpath('../');
W1 = 2;
L = 6;
L1 = 4;
D = 0.2;
k = 2.04;
H = 6e-3;
ue = 40;
uw = 200;

%difucion con fuente y reaccion
f_aux = @(x) (1./(L-x)).*L*H/(D*W1*k).*(2*W1*(L-x)+2*D);
p = @(x) 1./(L-x);
q = @(x) f_aux(x);
r = @(x) -f_aux(x)*ue;
f = @(x) [p(x) q(x) r(x)];

rob = [-k -H -H*ue];
inter = [0 L1];
ycd = uw;
pasos = 100;
[x,y] = dif_fin_rob(f,inter,ycd,rob,pasos);
y_ant = y;
error_aprox = [inf];
%voy a buscar una solucion que tenga al menos 4 decimales exactos
%en el extremo x=L, para ello itero hasta que el error sea menor a 0.5e-4
while(error_aprox(end) >= 0.5e-4)
    pasos = 2*pasos;
    [x,y] = dif_fin_rob(f,inter,ycd,rob,pasos);
    error_aprox = [error_aprox ; abs(y(end)-y_ant(end))];
    y_ant = y;
endwhile
error_aprox(end)
y(end)
plot(x,y)

A1 = W1*D;
deltax = L1/pasos;
x1 = deltax;
flujo = -k*A1/deltax*(y(2)-y(1));
flujo