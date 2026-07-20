addpath('../../../TP4');
addpath('../../../TP3');
addpath('../../../TP2');
format long;

p = @(x) 230*x.^4 + 18*x.^3 + 9*x.^2 -221*x - 9;
x = linspace(-20,20,1000);
plot(x,p(x))

%No se ve bien donde estan las raices
for i = 1:length(x)-1
    if p(x(i))*p(x(i+1)) < 0
        i
        i+1
    endif
endfor
%con eso vemos las raices

%ITEM A
x1 = [x(499), x(500)]
x2 = [x(524), x(525)]
tol = 5e-6;
kmax = 1000;
[r1, err1, it1] = biseccion(p,x1(1),x1(2),kmax,tol);
r1
it1
[r2, err2, it2] = biseccion(p,x2(1),x2(2),kmax,tol);
r2
it2
%r1 = -0.0406608
%r2 = 0.962403
%En ambos casos se necesito 13 iteraciones
%Se uso error absoluto


%ITEM B
dp = @(x) 920*x.^3 + 54*x.^2 + 18*x - 221;
for i = 1:length(x)-1
    if dp(x(i))*dp(x(i+1)) < 0
        i
        i+1
    endif
endfor


x1 = [x(515), x(516)]
tol = 5e-6;
kmax = 1000;
[r1, err1, it1] = biseccion(dp,x1(1),x1(2),kmax,tol);
r1
p(r1)
%r1 = 0.592521
%r2 = -104.693666
%Se uso error absoluto

%ITEM C
f = @(x) p(x) - x;
df = @(x) dp(x) -1;
tol = 5e-6;
kmax = 1000;
[r1, err1, it1] = newton(f,df,0,kmax,tol);
r1
%Se uso error absoluto
%r1 = -0.040476