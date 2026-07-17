addpath('..');
N=100;
columnas = [-1*ones(N,1) 2*ones(N,1) -1*ones(N,1)];
A = spdiags(columnas, [-1 0 1], N,N);
A(1,1) = 1;
A(N,N)= 1;
A(1,2)=0;
A(N,N-1)=0;
A = full(A);

b = [];
for i=1:1:10
    b_col = 1/(N^i).*ones(N,1);
    b_col(1) = 0;
    b_col(N) = 0;
    b = [b b_col];
end

xmax = [];
n = length(A);
[L, U] = doolittle(A);

for i=1:1:10
    y = sust_adelante(L, b(:,i));
    x = sust_atras(U, y);
    xmax = [xmax; max(x)];
end
semilogy((1:1:10), xmax)
disp("Valores maximos:");
disp(xmax);
