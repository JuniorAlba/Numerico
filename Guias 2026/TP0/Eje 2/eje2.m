x = [-4 -1 -pi/8 0 sqrt(2)/4 pi/2 9*pi/5];
y = @(x1) sin(2*x1)./(x1.*(x1+1));
printf("La funcion evaluada en %1.0f \n",x(1));
y(x(1))

printf("La funcion evaluada en %1.0f \n",x(2));
y(x(2))

printf("La funcion evaluada en %f \n",x(3));
y(x(3))

printf("La funcion evaluada en %1.0f \n",x(4));
y(x(4))

printf("La funcion evaluada en %f \n",x(5));
y(x(5))

printf("La funcion evaluada en %f \n",x(6));
y(x(6))

printf("La funcion evaluada en %f \n",x(7));
y(x(7))


printf("El dominio de la funcion es (-inf,-1) U (-1,0) U (0,inf) \n")
printf("El compilador da como resulado NaN cuando intentamos evaluar la funcion en una indeterminacion \n")
printf("El compilador da como resultado Inf cuando intentamos evaluar la funcion en una asintota \n")

