format long;
A = [2 2 -1 0 2;
    -2 2 -1 0 2;
    1 -2 3 -1 1;
    0 1 -2 3 -2;
    0 -1 -1 -1 3];
b = [-2;0;-1;4;-1];
[A_r,x_gauss] = gauss1(A,b);
x_gauss

tol = 1e-4;
x0 = zeros(5,1);
maxit = 10000;

[x_j,it,h] = jacobbi(A,b,x0,maxit,tol);
it

[x,it,h] = gauss_seidel(A,b,x0,maxit,tol);
it
%no converge

norm(x_gauss-x_j,inf)/norm(x_gauss,inf)