D0 = 1.2e-4;
alfa = 0.15;
v = 2e-3;
k = 1.2e-3;
y0 = [5.4 10.3];
D = @(x) D0*(1+alfa*x);
f = @(x,y) [y(2) ;  y(2).*(-v-D0*alfa)./D(x) - (y(1)).^2*k./(D(x))];

%[x,y] = rk4(f,[1.5,3],y0,1000);
%[yPrima_max_ant,indice] = max(y(:,2));
%ymax_ant = y(indice,1)

[x,y] = rk4(f,[1.5,3],y0,2000);
[Cmax, indice_a] = max(y(:,1));
Cmax = y(indice_a,1)
indice_a
%abs(ymax-ymax_ant)
%plot(x,y_ant(:,1))

%item b

J = abs(-D(x).*y(:,2)); %segun geminis hay que usar valor abs, no entiendo bien pq
%plot(x,J)
[Jmax,indice_b] = max(J)
Xjmax = x(indice_b)
Cjmax = y(indice_b,1)


%item c
flujo = abs(y(:,2).*(-v-D0*alfa) - (y(:,1)).^2*k);  %segun geminis hay que usar valor abs, no entiendo bien pq
dato = flujo - 0.001;   
%plot(x,flujo)
indice =1;
for i =1:1:length(dato)
    if(dato(i)<0)
        indice = i;
        break;
    endif
endfor
indice
x(indice)