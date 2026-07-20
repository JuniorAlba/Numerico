addpath('../../../TP4');
addpath('../../../TP3');
addpath('../../../TP2');
format long;
lambda = 1.25;
h = 1/99;
j = [1:1:100]';
x = (j-1)*h;
w = zeros(size(x));
w(1) = h/3;
w(2:2:50) = 4*h/3;
w(3:2:49) = 2*h/3;
w(51) = 5*h/6;
w(52:99)  =h;
w(100) = h/2;
delta = @(x,y) 1*(x==y);
K = @(x,y) 1./((1+5*(x-y).^2));
A =zeros(length(x),length(x));
for i = 1:1:length(x)
    for j = 1:1:length(x)
        A(i,j) = delta(i,j)-K(x(i),x(j))*lambda*w(j);
    end
end
f = x.^2 + 0.5;


%ITEM A
[y,it,h] = jacobi(A,f,zeros(length(x),1),100,1e-12);
h(20)
[y,it,h] = gauss_seidel(A,f,zeros(length(x),1),100,1e-12);
h(20)

%resultados (residuo)
%jacobi: 3.35e-02
%gauss_seidel: 2.38e-03

%ITEM B
tol = 1e-5;
[y,it,h] = jacobi(A,f,zeros(length(x),1),1000,tol);
it

[y,it,h] = gauss_seidel(A,f,zeros(length(x),1),1000,tol);
it
%resultados (error absoluto)
%jacobi: 70
%gauss_seidel: 37


%ITEM C
w = wOptimoMinRadEspect(A,3);
w
[x,it,h] = SOR(A,f,zeros(length(x),1),1000,tol,w);
it
%resultados (error absoluto)
%w: 1.367
%it: 16

%ITEM D
u = gauss1(A,f);
u(1)
u(end)

%resultados
%u(0) = 3.811400
%u(1) = 5.077458
