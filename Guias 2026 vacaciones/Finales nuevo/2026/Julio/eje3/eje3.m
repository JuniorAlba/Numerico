addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;

A = 0.5*diag(ones(49,1),1) + 0.5*diag(ones(49,1),-1) -1*diag(ones(50,1),0);
A(1,2) = 0;
A(end,end-1) = 0;
b = zeros(50,1);
b(1)=-1;


%ITEM A
[x] = gauss1(A,b);
x(25)

%resultado item A, la probabilidad es: 0.5102


%ITEM B
w = 1.5;
v0 = zeros(50,1);
tol = 1e-5;
maxit = 10000;
[_,it,_] = jacobi(A,b,v0,maxit,tol);
it

[_,it2,_] = gauss_seidel(A,b,v0,maxit,tol);
it2

[_,it3,_] = SOR(A,b,v0,maxit,tol,w);
it3

%resultados item b
# it = 2708
# it2 = 1175
# it3 = 383


%ITEM C
w = wOptimoMinRadEspect(A,4)
%Lo calcula encontrando la matriz de iteracion del metodo y viendo 
%cual w tiene el menor radio espectral.
%Mi funcion recibe los decimales para ver el paso con el que tiene que armar
%el vector de valores w (entre 0 y 2) con el que va a probar.
%Osea, si pones decimales = 4, va a probar w = 0.0001, 0.0002, ..., 1.9998, 1.9999