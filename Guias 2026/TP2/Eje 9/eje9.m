addpath('..');
A = [1 -2 3 0; 3 -6 9 3; 2 1 4 1; 1 -2 2 -2];
n = length(A);
[L, U, ~, P, r] = doolittle_p(A);

disp("L*U:")
L*U
disp("P*A:")
P*A
