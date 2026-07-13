addpath('..');
b = [1 2 3]';
% Matriz A1
A1 = [8, 4, 1; 2, 6, 2; 2, 4, 8];

% Matriz A2
A2 = [5.00e-02, 5.57e+02, -4.00e-02;
      1.98e+00, 1.94e+02, -3.00e-03;
      2.74e+02, 3.11e+00, 7.50e-02];

% Matriz A3
A3 = [1, 2, -1; 2, 4, 0; 0, 1, 1];

%%EJEMPLO 1
n1 = length(A1);

%P = eye(n1)(r,:)
% Sin pivoteo
A1_nop = doolittle(A1);
L = eye(n1) + tril(A1_nop, -1);
U = triu(A1_nop);
y = sust_adelante(L,b);
x = sust_atras(U,y);
b1_nop = A1*x

% Con pivoteo
[A1_p, r] = doolittle_p(A1);
PA1 = A1_p(r, :);
L = eye(n1) + tril(PA1, -1);
U = triu(PA1);
y = sust_adelante(L, b(r));
x = sust_atras(U, y);
b1_p = A1*x


%%EJEMPLO 2
n2 = length(A2);
A2_nop = doolittle(A2);
L = eye(n2) + tril(A2_nop, -1);
U = triu(A2_nop);
y = sust_adelante(L,b);
x = sust_atras(U,y);
b2_nop = A2*x

[A2_p, r] = doolittle_p(A2);
PA2 = A2_p(r, :);
L = eye(n2) + tril(PA2, -1);
U = triu(PA2);
y = sust_adelante(L, b(r));
x = sust_atras(U, y);
b2_p = A2*x


%%EJEMPLO 3
n3 = length(A3);
A3_nop = doolittle(A3);
L = eye(n3) + tril(A3_nop, -1);
U = triu(A3_nop);
y = sust_adelante(L,b);
x = sust_atras(U,y);
b3_nop = A3*x

[A3_p, r] = doolittle_p(A3);
PA3 = A3_p(r, :);
L = eye(n3) + tril(PA3, -1);
U = triu(PA3);
y = sust_adelante(L, b(r));
x = sust_atras(U, y);
b3_p = A3*x
