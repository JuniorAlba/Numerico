addpath('..');
A = [10 5 0 0; 5 10 -4 0; 0 -4 8 -1; 0 0 -1 5];
b = [6 25 -11 11]';

printf('\n\nCalculando el wOptimo\n')
tic;
w_min = wOptimo(A, b, zeros(size(A,1),1), 1e-10, 10000);
toc_wOptimo = toc;
w_min

printf('\n\n--- Resolviendo con SOR (w optimo) ---\n')
[x_sor,it_sor,rh_sor]= SOR(A,b,zeros(size(A,1),1),10000,1e-10,w_min);
printf('Iteraciones SOR: %d\n', it_sor);
printf('Error SOR: %e\n', rh_sor(end));

printf('\n\n--- Resolviendo con Gauss Seidel ---\n')
[x_gs,it_gs,rh_gs]= gauss_seidel(A,b,zeros(size(A,1),1),10000,1e-10);
printf('Iteraciones Gauss Seidel: %d\n', it_gs);
printf('Error Gauss Seidel: %e\n', rh_gs(end));


%La matriz es estrictamente diagonal dominante
%lo que garantiza la convergencia de Jacobi y Gauss Seidel
%ademas es simetrica definida positiva
%esto ya que es simetrica, estrictamente diagonal dominante,
%y los elementos de su diagonal son positivos (>0).
%con lo cual es simetrica definida positiva
%luego si 0 < w < 2, se garantiza la convergencia de SOR

% SOR suele converger en menos iteraciones que Gauss Seidel cuando w es optimizado.
% La relacion entre SOR con gauss seidel esta dada por el parametro w, el cual regula
% cuanto de la prediccion de gauss seguimos o cuanto de la estimacion anterior seguimos

