addpath('..');
A = [1 -1 2 -1; 0 2 -1 1; 0 0 -1 -1; 0 0 0 2];
b = [-8; 6; -4; 4];
x = sust_atras(A,b);

printf("Prueba sustitucion atras \n");
A*x
printf("\nPrueba sustitucion adelante \n");
x = sust_adelante(A',b);
A'*x

