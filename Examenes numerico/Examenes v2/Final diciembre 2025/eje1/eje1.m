k0 = 16.2;
k=0.2;
c=0.4;
Q = @(r) sin(pi*r);
p = @(r) (-r-2*k*r)./(r.^2 + k*r.^2);
q = @(r) (-r*c)./(r.^2 + k*r.^2);
resto = @(r) Q(r)./(r.^2 + k*r.^2);
f = @(r) [p(r) q(r) resto(r)];
inter = [1 2];
alpha = 300;
rob = [1 0 -1/k0*750];

%inciso a y b
%b) queremos calcular el flujo en r=1, para ello necesitamos usar la formula de diferencias finitas progresivas
L = 10;
[r,T] = dif_fin_rob(f,inter,alpha,rob,L);
h = 1/L;
T_prima = (-3*T(1) +4*T(2) -T(3))/(2*h);
flujo = -k0*T_prima;
while(true)
    L=2*L;

    T_ant = T;
    r_ant = r;
    flujo_ant = flujo;

    [r,T] = dif_fin_rob(f,inter,alpha,rob,L);
    h = 1/L;
    T_prima = (-3*T(1) +4*T(2) -T(3))/(2*h);
    flujo = -k0*T_prima;

    condicion1 = abs(T(end)-T_ant(end))/abs(T(end))<0.5e-5;
    condicion2 = abs(flujo - flujo_ant)/abs(flujo)<0.5e-4;
    if(condicion1 && condicion2)
        break;
    endif
endwhile
T(end);
%ans = 270.22
flujo;
%flujo = 15.676




%inciso C
%integramos la temperatura a lo largo de la placa y la dividimos por la longitud de la misma
t_promedio = trapcomp(r,T);
%no hace falta dividir por que el largo de la placa es 1m
while(true)
    L = L*2;

    t_promedio_ant = t_promedio;

    [r,T] = dif_fin_rob(f,inter,alpha,rob,L);

    t_promedio = trapcomp(r,T);

    condicion = abs(t_promedio-t_promedio_ant)<0.5e-2;
    if(condicion)
        break;
    endif
endwhile
t_promedio;
%t_promedio = 288.68