x = [0 200 400 600 800 1000 1200];
p = [4 3.95 3.89 3.80 3.60 3.41 3.30];
A = [100 103 106 110 120 133 149.6];
L = 1200;
int_simp = simpsoncomp(x,p.*A)
int_trap = trapcomp(x,p.*A)

dif = abs(int_simp-int_trap)/abs(int_simp)
%como la diferencia es chica podes confiar en los resultados

simpsoncomp([1 2 3],[1 4 9])

