addpath('../../../TP4');
addpath('../../../TP3');
addpath('../../../TP2');
format long;
A = [2 2 -1 0 2;
    -2 2 -1 0 2;
    1 -2 3 -1 1;
    0 1 -2 3 -2;
    0 -1 -1 -1 3];
b = [-2; 0; -1; 4; -1];

%ITEM A
x_g=gauss1(A,b)

%ITEM B
tol=1e-4;
itmax=1000;


[x,it,h] = gauss_seidel(A,b,zeros(length(b),1),itmax,tol);
x
it

[x,it,h] = jacobi(A,b,zeros(length(b),1),itmax,tol);
x
it

%ITEM C
norm(x-x_g,inf)/norm(x_g,inf)

%7.402300872287142e-05