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
% Sin pivoteo
[L, U] = doolittle(A1);
y = sust_adelante(L,b);
x = sust_atras(U,y);
b1_nop = A1*x

% Con pivoteo
% Con pivoteo
[L, U, ~, ~, r] = doolittle_p(A1);
y = sust_adelante(L, b(r));
x = sust_atras(U, y);
b1_p = A1*x


%%EJEMPLO 2
n2 = length(A2);
[L, U] = doolittle(A2);
y = sust_adelante(L,b);
x = sust_atras(U,y);
b2_nop = A2*x

[L, U, ~, ~, r] = doolittle_p(A2);
y = sust_adelante(L, b(r));
x = sust_atras(U, y);
b2_p = A2*x


%%EJEMPLO 3
n3 = length(A3);
[L, U] = doolittle(A3);
y = sust_adelante(L,b);
x = sust_atras(U,y);
b3_nop = A3*x

[L, U, ~, ~, r] = doolittle_p(A3);
y = sust_adelante(L, b(r));
x = sust_atras(U, y);
b3_p = A3*x
