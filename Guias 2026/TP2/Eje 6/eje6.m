addpath('..');
A = [80 -50 -30 0;
    -50 100 -10 -25;
    -30 -10 65 -20;
    0 -25 -20 100];
b = [-120; 0; 0; 0];

disp("Resolviendo usando eliminacion de Gauss");
x = gauss1(A, b);

disp("Las corrientes i1, i2, i3 e i4 son:");
disp(x);
