function p = coef_indeterminados(x, y)
% COEF_INDETERMINADOS  Polinomio interpolante por el método de coeficientes indeterminados.
%
% Arma el sistema de Vandermonde V*p = y y lo resuelve con \.
% La j-ésima columna de V es x.^(n-j), así que el resultado es
% directamente compatible con polyval.
%
% Entradas:
%   x  - Vector de abscisas (deben ser todas distintas), tamaño n
%   y  - Vector de ordenadas, tamaño n
%
% Salidas:
%   p  - Vector de n coeficientes del polinomio de grado n-1 (formato polyval)
%
% Ejemplo de uso: ver al final del archivo (seleccionar y presionar F9)

  % --- Configuración interna ---
  medir_tiempo    = false; % true: muestra tiempo de ejecución
  opcion_verbose  = 0;     % 0: silencioso | 1: imprime el sistema y solución
  opcion_warnings = false;  % true: avisa si la matriz está mal condicionada

  TOL_COND = 1e10; % por encima de esto el sistema de Vandermonde es sospechoso

  % --- Inicio ---
  if medir_tiempo
    tic_handle = tic;
  endif

  x = x(:); % columna
  y = y(:);
  n = length(x);

  % armo la matriz de Vandermonde: V(i,j) = x(i)^(n-j)
  % la columna 1 es x^(n-1), la columna n es x^0 = 1
  potencias = (n-1):-1:0;
  V = x .^ potencias; % broadcasting: n×n

  % Vandermonde mal condicionada es esperable para n grande — aviso si es el caso
  if opcion_warnings && cond(V) > TOL_COND
    printf("ADVERTENCIA (coef_indeterminados): cond(V) = %e — el sistema puede ser inestable.\n", cond(V));
    printf("  Considerá usar lagrange_interp o polyfit para n grande.\n");
  endif

  % resuelvo V*p = y
  p = (V \ y)';

  % --- Reporte ---
  if medir_tiempo
    tiempo = toc(tic_handle);
  endif

  if opcion_verbose >= 1
    printf("--- Resumen coef_indeterminados ---\n");
    printf("n = %d puntos → polinomio de grado %d\n", n, n-1);
    printf("cond(V) = %e\n", cond(V));
    printf("Coeficientes (grado decreciente):\n");
    disp(p);
    if medir_tiempo
      printf("Tiempo: %f s\n", tiempo);
    endif
    printf("----------------------------------\n");
  endif

endfunction

%{
% =========================================================
% EJEMPLO DE USO — seleccionar bloque y presionar F9
% =========================================================

x = [3, 5, 7, 9];
y = [1.2, 1.7, 2.0, 2.1];

pL  = lagrange_interp(x, y);
pCI = coef_indeterminados(x, y);

% los dos métodos deben dar exactamente el mismo polinomio
printf("Diferencia máxima entre coeficientes: %e\n", max(abs(pL - pCI)));

% verifico interpolación
printf("\nVerificación en los nodos:\n");
for i = 1:length(x)
  printf("  pL(%g)  = %.6f  |  pCI(%g) = %.6f  |  esperado: %.6f\n", ...
         x(i), polyval(pL, x(i)), x(i), polyval(pCI, x(i)), y(i));
endfor

% Resultado esperado:
%   Diferencia entre coeficientes ~ eps (orden 1e-16)
%   Ambos evalúan exactamente en los nodos
% =========================================================
%}
