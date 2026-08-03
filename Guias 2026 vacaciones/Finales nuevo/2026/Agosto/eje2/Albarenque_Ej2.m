addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;



b = 1.5*[1:40]' -6;
A = 2*diag([1:40]',0) - 1*diag(ones(39,1),1) -1*diag(ones(39,1),-1);

%ITEM A
x = gauss1(A,b);
x(1)
%resultado x(1) = -3.076118

%ITEM B
w = 1.05;
tol = 1e-5;
kmax = 10000;
x0 = zeros(40,1);
[x,it,r_h] = jacobi(A,b,x0,kmax,tol);
it
[x,it,r_h_gauss] = gauss_seidel(A,b,x0,kmax,tol);
it
[x,it,r_h] = SOR(A,b,x0,kmax,tol,w);
it
%resultados:
%Jacobi = 16
%Gauss_seidel = 8
%SOR = 6

%  err = norm(A*x-b,inf); %residuo



%ITEM C 
[x,it,r_h_gauss] = gauss_seidel(A,b,x0,kmax,tol);
%err=norm(x-x0,inf); %error absoluto
r_h_gauss(3)
%result = 0.140625;


