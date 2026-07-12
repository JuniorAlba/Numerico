format long;
f = @(x) log(x.^2 + 1) - e.^(x/2).*cos(pi*x)-1.106;
xx = linspace(-6,6,200);
figure(1)
hold on;
plot([-6 6],[0,0]);
plot(xx,f(xx));
%hay que ver si entre -2 y -1.5 hay una raiz o no
x1_a = linspace(-2,-1.5,200);
indice = 1;
for i=1:1:199
    if (f(x1_a(i))*f(x1_a+1)<=0)
        indice = i;
    endif
endfor
indice
%parece que no hay raiz, entonces en total se ven 7 raices
[p,h,it] = Biseccion(f,-1,0,1000,1e-7);
it
p


df = @(x) 2.*x./(x.^2+1) -1/2*exp(x/2).*cos(pi*x)+exp(x/2).*pi*sin(pi*x);
%Si alguna derivada se anula en o es cercana a cero significa que hay raiz multiple
%entonces newton tiene convergencia lineal
[p_1,h,it] = Newton(f,df,3,10000,1e-10);
df(p_1)
[p_2,h,it] = Newton(f,df,3.05,10000,1e-10);
df(p_2)
[p_3,h,it] = Newton(f,df,3.1,10000,1e-10);
df(p_3)
p_1
p_2
p_3


%f(x) = x  luego x-f(x)=0=g(x)
g = @(x) x-f(x);
dg = @(x) 1-df(x);
[p,h,it] = Newton(g,dg,1,10000,1e-7);
p