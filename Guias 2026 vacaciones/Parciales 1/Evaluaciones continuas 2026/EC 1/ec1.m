addpath('../../../TP4');
addpath('../../../TP3');
addpath('../../../TP2');
format long;

b = 1.5*[1:40]' -6;
A = 2*diag(ones(40,1),0) - 1*diag(ones(39,1),1) -1*diag(ones(39,1),-1);

%ITEM A
x = gauss1(A,b);
x(20)
%resultado x(20) = 5145

%ITEM B
w = 1.85;
tol = 1e-5;
kmax = 10000;
x0 = zeros(40,1);
[x,it,r_h] = SOR(A,b,x0,kmax,tol,w);
it
[x,it,r_h] = jacobi(A,b,x0,kmax,tol);
it
[x,it,r_h] = gauss_seidel(A,b,x0,kmax,tol);
it


%resultados (error relativo)
# it = 98
# it = 1934
# it = 1088