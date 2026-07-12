n=100;
A = zeros(n,n);
b = [0;1/(n^2)*ones(98,1);0]
diag1 = [-1*ones(n-2,1);0];
diag2 =  [1;2*ones(n-2,1);1];
diag3 =  [0;-1*ones(n-2,1)];
A = A + diag(diag1,-1)+diag(diag2,0)+diag(diag3,1);
%este algoritmo de gauss opera la matriz y el vector b, los devuelve operados
[Ag, bg] = gauss2(A,b);
x = sust_atras_vec(Ag,bg);
A*x
x

%este algoritmo de gauss opera la matriz y el vector b, devuelve la solucion al sistema
[Ag,x]=gauss1(A,b);
x
A*x

