%------------------------------ejercicio 5--------------------------------------
A = [16.87 0.1650 0.2019 0.3170 0.2340 0.1820 0.1100; 0.0 27.70 0.8620 0.0620 0.0730 0.1310 0.1200; 0.0 0.0 22.35 13.05 4.420 6.001 3.043; 0.0 0.0 0.0 11.28 0.0 1.110 0.3710; 0.0 0.0 0.0 0.0 9.850 1.1684 2.108; 0.0 0.0 0.0 0.0 0.2990 15.98 2.107; 0.0 0.0 0.0 0.0 0.0 0.0 4.670];
b = [ 17.1 65.1 186.0 82.7 84.2 63.7  119.7];
[L,U,Ar,r,P] = doolitle_p(A);
y = sust_adelante_vec(L,b);
x = sust_atras_vec(U,y);
disp("presiones parciales"); disp(x);
disp("presion total");
n = length(x);
suma = 0;
for i= 1:1:n
  suma = suma + x(i);
endfor
disp(suma);

%------------------------------ejercicio 6--------------------------------------
A = [80 -50 -30 0; -50 100 -10 -25; -30 -10 65 -20; 0 -25 -20 100];
b = [-120;0;0;0];
[L,U,Ar,r,P] = doolitle_p(A);
y = sust_adelante_vec(L,b);
x = sust_atras_vec(U,y);
disp("Las corrientes que circulan por el circuito son:")
n = length(x);
for i= 1:1:n
  printf("Corriente ");printf("%d",i);printf(":");disp(x(i));
endfor

%------------------------------ejercicio 7--------------------------------------

N =100;
unos = ones(N,1);
columnas = [-1*unos 2*unos -1*unos];
A = spdiags(columnas, [-1 0 1], N, N);
A(1,1)=1;
A(1,2)=0;
A(N,N-1)=0;
A(N,N)=1;
 % full(A); para ver la matriz, la matriz que creamos antes no guarda en memoria los ceros

b = (1/(N^2))*ones(N,1);
b(1)=0;
b(N)=0;

[L,U,Ar,r,P] = doolitle_p(A);
y = sust_adelante_vec(L,b);
x = sust_atras_vec(U,y);
disp(x);
