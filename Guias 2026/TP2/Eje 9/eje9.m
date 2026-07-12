A = [1 -2 3 0; 3 -6 9 3; 2 1 4 1; 1 -2 2 -2]

[L,U,Ar,r,P] = doolitle_p(A);
disp("L*U:")
L*U
Ar
disp("P*A:")
P*A
