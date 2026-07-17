addpath('..');
A = [1 1+0.5e-15 3; 2 2 20; 3 6 4];
n = length(A);

[L1, U1] = doolittle(A);

[L2, U2, ~, P, r] = doolittle_p(A);

disp("A-L1*U1");
disp(A-L1*U1);
printf("\n")
disp("P*A-L2*U2");
printf("\n")
disp(P*A-L2*U2);
