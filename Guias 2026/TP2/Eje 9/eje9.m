addpath('..');
A = [1 -2 3 0; 3 -6 9 3; 2 1 4 1; 1 -2 2 -2];
n = length(A);
[Ap, r] = doolittle_p(A);
PA = Ap(r, :);
L = eye(n) + tril(PA, -1);
U = triu(PA);
P = eye(n)(r, :);

disp("L*U:")
L*U
disp("P*A:")
P*A
