%p(x) = 0;
%q(x) = (1/k0)*Cr(x);
%r(x) = -(1/k0)*fuente(x)
%Condicion de robin: A*u'(L) + B*u(L) = C
% A = k0    B = H   C = H;  condicion de robin con ley de enfriamiento
Long = 5;   %longitud de la barra
k0 = 0.9;  %conductividad del material
ue = 4;     %temperatura del exterior
H = 15;     %coeficiente de transferencia del calor

%fuente y coeficiente reactivo
fuente = @(x) 5.*x.*(5-x);
cr = @(x) 1.05.*x+2;

%ecuacion diferencial para difusion de calor con reaccion
p = @(x) x*0;
q = @(x) (1/k0).*cr(x);
r = @(x) -(1/k0).*fuente(x);
f = @(x) [p(x) q(x) r(x)];

%temperatura para el lado izquierod de la barra
yc = 6;

%intervalo
inter = [0 Long];

%condicion de robin con ley de enfriamiento
rob = [k0 H H*ue];

%item b) nos piden que la solucion tenga 4 cifras decimales exactas
% para la temperatura en el punto medio de la barra, x=2.5, para esto
% el metodo debe dividir a la barra en un numero impar de puntos, es decir
% en un numero par de subintervalos, para ello elegimos L = 10 y vamos aumentando
% hasta que el error en iteraciones seguidas sea menor a 0.5e-4;


h = 0.1;
L = 10;
[x,y] = dif_fin_rob(f,inter,yc,rob,L);
valor_medio_anterior = y(L/2 +1);

L = 2*L;
[x,y] = dif_fin_rob(f,inter,yc,rob,L);
valor_medio = y(L/2 +1);
error_metodo = [abs(valor_medio - valor_medio_anterior)];
valor_medio_anterior = valor_medio;

Lmax = 10000;
while(L<Lmax && error_metodo(end)>= 0.5e-4)
    L = 2*L;
    [x,y] = dif_fin_rob(f,inter,yc,rob,L);
    valor_medio = y(L/2 +1);
    error_metodo = [error_metodo abs(valor_medio - valor_medio_anterior)];
    valor_medio_anterior = valor_medio;
endwhile
error_metodo(end)
y(L/2+1)
