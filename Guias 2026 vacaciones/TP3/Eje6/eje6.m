addpath('..');
addpath('../../TP2');
%% Sistemas de ecuaciones lineales - Análisis completo

% Primer sistema de ecuaciones:
% 3x + y + z = 5
% x + 3y - z = 3
% 3x + y - 5z = -1

A1 = [3  1  1;
      1  3 -1;
      3  1 -5];

b1 = [5; 3; -1];

% Segundo sistema (reordenado):
% 3x + y + z = 5
% 3x + y - 5z = -1
% x + 3y - z = 3

A2 = [3  1  1;
      3  1 -5;
      1  3 -1];

b2 = [5; -1; 3];
disp("_________MATRIZ 1_________")
disp("Solucion con gauss sin pivoteo")
[x1_gauss] = gauss1(A1,b1);
x1_gauss

disp("Solucion con gauss con pivoteo")
x1_gauss_p = gauss_p(A1,b1);
x1_gauss_p

disp("Solucion con gauss seidel")
[x1_gauss_seidel,it,r_h] = gauss_seidel(A1,b1,[0 0 0]',100,1e-9);
x1_gauss_seidel

disp("radio espectral de la matriz 1:")
T = -inv(diag(diag(A1))+tril(A1,-1))*triu(A1,1);
radio = max(abs(eig(T)))

disp("_________MATRIZ 2_________")
disp("Solucion con gauss sin pivoteo")
[x2_gauss]= gauss1(A2,b2);
x2_gauss

disp("Solucion con gauss con pivoteo")
x2_gauss_p = gauss_p(A2,b2);
x2_gauss_p

disp("Solucion con gaussseidel")
[x2_gauss_seidel,it,r_h] = gauss_seidel(A2,b2,[0 0 0]',100,1e-9);
x2_gauss_seidel

disp("radio espectral de la matriz 2: ")
T = -inv(diag(diag(A2))+tril(A2,-1))*triu(A2,1);
radio = max(abs(eig(T)))

%{
  =========================================================================
  JUSTIFICACIÓN Y ANÁLISIS DE RESULTADOS
  =========================================================================
  
  El ejercicio demuestra la importancia del ordenamiento de las ecuaciones
  para los métodos numéricos. Ambos sistemas son matemáticamente idénticos
  (solo se intercambiaron las filas 2 y 3), pero numéricamente se comportan
  de forma totalmente distinta:

  1. MATRIZ 1 (Sistema Original):
     - Es Estrictamente Diagonal Dominante (EDD), ya que los elementos más 
       grandes (3, 3 y -5) están posicionados en la diagonal principal.
     - Gauss sin pivoteo: Funciona bien porque no genera divisiones por cero.
     - Gauss con pivoteo: Funciona y llega al mismo resultado.
     - Gauss-Seidel: CONVERGE porque, al ser EDD, se garantiza matemáticamente 
       que el radio espectral de la matriz de iteración T es menor a 1.

  2. MATRIZ 2 (Filas 2 y 3 intercambiadas):
     - Al desordenar las filas, la matriz dejó de ser EDD.
     - Gauss sin pivoteo: FALLA (da NaN) porque durante la eliminación se 
       produce un cero en la diagonal (posición 2,2) provocando una división 
       por cero en el siguiente paso.
     - Gauss con pivoteo: FUNCIONA porque el algoritmo detecta el cero, busca 
       el máximo en la columna y vuelve a intercambiar las filas por su cuenta,
       restaurando el sistema al formato de la Matriz 1 de forma transparente.
     - Gauss-Seidel: DIVERGE (explota a números gigantes) porque la pérdida
       de la propiedad EDD causó que el radio espectral de su matriz de iteración
       se disparase, multiplicando el error en cada paso.
  =========================================================================
%}
