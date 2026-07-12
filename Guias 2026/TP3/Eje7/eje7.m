columnas = [0.25*(1:1000)' 0.5*(1:1000)' 2*(1:1000)' 0.5*(1:1000)' 0.25*(1:1000)'];
A = spdiags(columnas,[-4 -2 0 2 4],1000,1000);
full(A);
b = pi*ones(1000,1);
x0 = zeros(1000,1)';


disp("-------METODO DE JACOBBI-------")

id=tic;
[x,it,r_h]=jacobbi(A,b,x0',1000,1e-5);
toc(id)
figure(1);
hold on;
semilogy(1:1:it,r_h,'-r');

disp("norm(A*xk-b, inf)")
residuo = norm(A*x-b,inf)

disp("-------METODO DE GAUSS SEIDEL-------")
id=tic;
[x,it,r_h]=gauss_seidel(A,b,x0',1000,1e-5);
toc(id)

semilogy(1:1:it,r_h,'-b');


disp("norm(A*xk-b, inf)")
residuo = norm(A*x-b,inf)

disp("-------METODO DE SOR-------")
%[w] = wOptimoExperimental(A,b,x0',1000,1e-5)
w = 0.8455
id=tic;
[x,it,r_h]=SOR(A,b,x0',1000,1e-5,w);
toc(id)
disp("norm(A*xk-b, inf)")
residuo = norm(A*x-b,inf)
semilogy(1:1:it,r_h,'-g');

L = tril(A,-1);
U = triu(A,1);
D = diag(diag(A));
Tw = inv(D + w.*L)*((1-w).*D-w.*U);
printf("Radio espectral: ")
x = max([abs(eig(Tw))])

%{
  =========================================================================
  ANÁLISIS DE RESULTADOS Y CONCLUSIONES
  =========================================================================

  1. ELECCIÓN DEL MÉTODO MÁS CONVENIENTE:
     Se concluye que el método SOR (con w experimental = 0.8455) es la
     opción más eficiente.
     - Evidencia: Mayor pendiente en la gráfica semilogarítmica (rápida
       reducción del error) y menor tiempo de cómputo (0.20s).

  2. JUSTIFICACIÓN DE LA CONVERGENCIA:
     - Para Jacobi y Gauss-Seidel: Convergencia asegurada por ser la matriz
       Estrictamente Diagonal Dominante (|aii| > suma|aij|).
     
     - Para SOR: Se verifican las condiciones de convergencia:
       a) Condición Necesaria (Teorema de Kahan): Se cumple que 0 < w < 2.
          Como vemos en la teoría, rho(Tw) >= |w-1|, por lo que es imposible
          converger fuera de este rango. Nuestro w = 0.8455 lo respeta.
       b) Verificación Espectral: Se comprobó numéricamente que el Radio
          Espectral de la matriz de iteración es menor a 1 (rho < 1), lo
          cual confirma la convergencia asintótica para este sistema no simétrico.

  3. SOBRE LA PRECISIÓN:
     Aunque el residuo es bajo (1e-5), para validar la precisión real de la
     solución confiamos en la contracción monótona del error garantizada
     por rho < 1, más que solo en el residuo, evitando falsos positivos
     por mal condicionamiento.
  =========================================================================
%}

