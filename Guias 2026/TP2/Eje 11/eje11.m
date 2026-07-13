addpath('..');
A = [1 1+0.5e-15 3; 2 2 20; 3 6 4];
n = length(A);

A_nop = doolittle(A);
L1 = eye(n) + tril(A_nop, -1);
U1 = triu(A_nop);

[A_p, r] = doolittle_p(A);
PA = A_p(r, :);
L2 = eye(n) + tril(PA, -1);
U2 = triu(PA);
P = eye(n)(r, :);

disp("A-L1*U1");
disp(A-L1*U1);
printf("\n")
disp("P*A-L2*U2");
printf("\n")
disp(P*A-L2*U2);
