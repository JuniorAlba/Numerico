b = [1 2 3]';
% Matriz A1
A1 = [8, 4, 1; 2, 6, 2; 2, 4, 8];

% Matriz A2 (usando notación científica como en la imagen)
A2 = [5.00e-02, 5.57e+02, -4.00e-02;
      1.98e+00, 1.94e+02, -3.00e-03;
      2.74e+02, 3.11e+00, 7.50e-02];

% Matriz A3
A3 = [1, 2, -1; 2, 4, 0; 0, 1, 1];



%%EJEMPLO 1
%LUx=b Ux==y(sust atras) => Ly=b(sust adelante)

%aplicando ambos algoritmos a A1
[L,U]=doolitle_p(A1);
[y] = sust_adelante_vec(L,b);
[x] = sust_atras_vec(U,y);
b1_nop = A1*x

%PAx = Pb => PLUx = Pb luego Ux = y and PLy = Pb

[L,U,A1_r,r,P]=doolitle_p(A1);
[y] = sust_adelante_vec(L,P*b);
[x] = sust_atras_vec(U,y);
b1_p = A1*x


%%EJEMPLO 2
[L,U]=doolitle_p(A2);
[y] = sust_adelante_vec(L,b);
[x] = sust_atras_vec(U,y);
b2_nop = A2*x

[L,U,A2_r,r,P]=doolitle_p(A2);
[y] = sust_adelante_vec(L,P*b);
[x] = sust_atras_vec(U,y);
b2_p = A2*x


%%EJEMPLO 3
[L,U] = doolitle_nop(A3);
[y] = sust_adelante_vec(L,b);
[x] = sust_atras_vec(U,y);
b3_nop = A3*x

[L,U,A3_r,r,P]= doolitle_p(A3);
[y] = sust_adelante_vec(L,P*b);
[x] = sust_atras_vec(U,y);
b3_p = A3*x



