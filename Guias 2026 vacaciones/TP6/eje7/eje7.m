addpath('..');
x = [0 200 400 600 800 1000 1200];
p = [4 3.95 3.89 3.80 3.60 3.41 3.30];
A = [100 103 106 110 120 133 149.6];
L = 1200;
int_simp = simpsoncomp(x,p.*A);
int_trap = trapcomp(x,p.*A);

dif = abs(int_simp-int_trap)/abs(int_simp);

fprintf('=== EJERCICIO 7: MASA DE BARRA DE DENSIDAD VARIABLE ===\n');
fprintf('Masa total (Simpson)  : %.2f g\n', int_simp);
fprintf('Masa total (Trapecio) : %.2f g\n', int_trap);
fprintf('Diferencia relativa   : %.4e\n', dif);
fprintf('Como la diferencia relativa es muy pequeña, podemos confiar en que la estimación es precisa.\n');
