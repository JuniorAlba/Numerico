x = [-0.5 7 2];
z = [2 ; -1 ; 3];

printf("\n(a) 2*x \n")
2*x

printf("\n(b) y = x - 1 \n")
y = x - 1

printf("\n(c) x.*y \n")
x.*y

printf("\n(d) x./y \n")
x./y

printf("\n(e) y.^2 \n")
y.^2

printf("\n(f) x' + 5*z \n")
x' + 5*z 

printf("\n(g) x + 5*z \n")
x + 5*z
n1 = [x(1) x(2) x(3); x(1) x(2) x(3); x(1) x(2) x(3)];
n2 = [5*z(1) 5*z(1) 5*z(1); 5*z(2) 5*z(2) 5*z(2); 5*z(3) 5*z(3) 5*z(3)];
printf("Realizar esta operacion involucra convertir anmbos vectores en una matriz \n")
printf("Es como si se estirara cada vector para hacer posible la operacion, equivalente a sumar las siguientes matrices: \n")
n1
n2

n1 + n2

printf("\n(h) y - z'/3 \n")
y - z'/3

printf("\n(i) v = [x,y] \n")
v = [x,y]
printf("Esta operacion concatena los elementos de ambos vectores fila y los guarda en un vector\n")
printf("\n(j) v(2:5) \n")
v(2:5)
printf("Esta operacion muestra del 2do al 5to elemento del vector v\n")

printf("\n(k) v(5:6) +(z(1:2))' \n")
v(5:6) +(z(1:2))'

printf("\n(l) w = [x;y] \n")
w = [x;y]
printf("Esta operacion concatena los elementos de ambos vectores fila en 2 columnas separadas, creando una matriz de 2x3\n")
