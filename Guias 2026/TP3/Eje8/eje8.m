% --- 1. CONFIGURACIÓN GRÁFICA ---
% Si falla qt, usamos gnuplot
graphics_toolkit("gnuplot");
Nh=10;          %cantidad de subintervalos
P = 1.0326e+4; %carga por unidad de long
w = 0.07;       %ancho de seccion rectangular
s = 0.14;       %altura de seccion rectangular
J = w*s^3/12;   %momento inercia de la viga
E = 210e+9;    %modulo de young del acero
fj = P/(E*J);   %funcion que describe la carga en el nodo J sobre la viga
                %debido a que la carga es uniforme y el momento inercia constante 
                %fj es una constante
L = 5;
h = L/(Nh);  %h es el paso para llegar de un nodo nj a otro, nodos = subintervalos + 1
                %a la viga la divido en 101 nodos, eso me deja 100 subintervalos, separados por una distancia h

% --------------- MATRICES ---------------%

colum = ones(Nh+1,1);
A = spdiags([1*colum -4*colum 6*colum -4*colum 1*colum],[-2 -1 0 1 2],Nh+1,Nh+1);
A(1,1:end) = zeros(1,Nh+1);
A(2,1:end) = zeros(1,Nh+1);
A(Nh+1,1:end) = zeros(1,Nh+1);
A(Nh,1:end) = zeros(1,Nh+1);
A(1,1) = 1;
A(2,2) = 1;
A(Nh,Nh) = 1;
A(Nh+1,Nh+1) = 1;

full(A);
b = h^4*fj*ones(Nh+1,1);
b(1:2)=0;
b(Nh:Nh+1)=0;

tol = 1e-8;
x0 = zeros(Nh+1,1);
maxit = 10000;
figure(1);
hold on;
grid on;
% --------------- JACOBBI ---------------%
tic;
[x, it, r_h] =jacobbi(A,b,x0,maxit,tol);
it
toc_jacobbi = toc
semilogy(1:1:it,r_h,'-g');


% --------------- GAUSS SEIDEL ---------------%
tic;
[x, it, r_h] =gauss_seidel(A,b,x0,maxit,tol);
it
toc_GS = toc

semilogy(1:1:it,r_h,'-b');

% --------------- SOR ---------------%
%[w] = wOptimoExperimental(A,b,x0,maxit,tol)
w = 1.6273

tic;
[x, it, r_h] =SOR(A,b,x0,maxit,tol,1);
it
toc_SOR = toc

semilogy(1:1:it,r_h,'-r');


% --------------- GAUSS ---------------%

tic;
[_,x]=gauss1(A,b);
toc_gauss = toc

%{
  =========================================================================
  DISCUSIÓN: ¿POR QUÉ NO CONVERGEN LOS MÉTODOS ITERATIVOS?
  =========================================================================

  OBSERVACIÓN:
  Se detectó que Jacobi, Gauss-Seidel y SOR terminan su ejecución alcanzando 
  el límite de iteraciones (maxit = 10000) sin lograr la tolerancia de 1e-8.
  
  DIAGNÓSTICO: MAL CONDICIONAMIENTO NUMÉRICO
  Este comportamiento NO es un error del código, sino una propiedad intrínseca 
  de la ecuación de cuarto orden de la viga (d^4u/dx^4) discretizada.

  1. Crecimiento del Número de Condición:
     La "dificultad" de la matriz (número de condición) escala con N^4.
     Para N=100, la matriz es extremadamente rígida (stiff). Esto hace que 
     el Radio Espectral de la matriz de iteración sea casi 1 (ej: 0.9999...).

  2. Velocidad de Convergencia:
     Al ser el radio espectral tan cercano a 1, la reducción del error en 
     cada paso es minúscula. Para bajar el error a 1e-8 se requieren 
     cientos de miles de iteraciones (>> 10000).

  CONCLUSIÓN:
  Para problemas unidimensionales de vigas con mallados finos (N >= 100), 
  los métodos iterativos clásicos son ineficientes. 
  La solución óptima es utilizar el MÉTODO DIRECTO (Eliminación Gaussiana / 
  operador backslash), que resuelve el sistema instantáneamente aprovechando 
  que la matriz es banda, sin sufrir por la lenta tasa de convergencia.
  =========================================================================
%}