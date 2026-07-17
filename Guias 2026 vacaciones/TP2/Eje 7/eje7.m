addpath('..');
n=100;
A = zeros(n,n);
b = [0;1/(n^2)*ones(98,1);0];
diag1 = [-1*ones(n-2,1);0];
diag2 =  [1;2*ones(n-2,1);1];
diag3 =  [0;-1*ones(n-2,1)];
A = A + diag(diag1,-1)+diag(diag2,0)+diag(diag3,1);

disp("Solucion con gauss con pivoteo:");
[x_p, r] = gauss_p(A,b);
disp(x_p(1:5)); % mostramos los primeros 5

disp("Solucion con gauss sin pivoteo:");
x_nop = gauss1(A,b);
disp(x_nop(1:5)); % mostramos los primeros 5
