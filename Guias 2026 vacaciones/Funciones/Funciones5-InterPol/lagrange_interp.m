function p = lagrange_interp(x, y)
% LAGRANGE_INTERP  Polinomio interpolante por la forma de Lagrange.
%
% Construye el polinomio que pasa por los n puntos (x_i, y_i) como
% combinación lineal de los polinomios base de Lagrange:
%   p(x) = sum_k y_k * L_k(x)
% donde L_k(xi) = 1 si i==k, 0 si i!=k.
% Devuelve los coeficientes en formato polyval (grado decreciente).
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
  medir_tiempo   = false; % true: muestra tiempo de ejecución
  opcion_verbose = 0;     % 0: silencioso | 1: imprime grado y norma de p

  % --- Inicio ---
  if medir_tiempo
    tic_handle = tic;
  endif

  x = x(:)'; % fuerzo fila para que poly() se porte bien
  y = y(:)';
  n = length(x);
  p = zeros(1, n); % acá voy acumulando la suma

  for k = 1:n
    % raíces del numerador de L_k: todos los x_i excepto x_k
    raices = x([1:k-1, k+1:n]);

    % poly(raices) da el polinomio mónico con esas raíces — exactamente el numerador
    Lk = poly(raices);

    % el denominador es el producto (x_k - x_i) para i != k
    denominador = prod(x(k) - raices);

    % L_k normalizado, escalado por y_k, y lo sumo al acumulador
    p = p + y(k) * (Lk / denominador);
  endfor

  % --- Reporte ---
  if medir_tiempo
    tiempo = toc(tic_handle);
  endif

  if opcion_verbose >= 1
    printf("--- Resumen lagrange_interp ---\n");
    printf("n = %d puntos → polinomio de grado %d\n", n, n-1);
    printf("Coeficientes (grado decreciente):\n");
    disp(p);
    if medir_tiempo
      printf("Tiempo: %f s\n", tiempo);
    endif
    printf("-------------------------------\n");
  endif

endfunction

%{
% =========================================================
% EJEMPLO DE USO — seleccionar bloque y presionar F9
% =========================================================

x = [3, 5, 7, 9];
y = [1.2, 1.7, 2.0, 2.1];

p = lagrange_interp(x, y);

% verifico que interpola exactamente los nodos
printf("Verificación en los nodos:\n");
for i = 1:length(x)
  printf("  p(%g) = %.6f  (esperado: %.6f)\n", x(i), polyval(p, x(i)), y(i));
endfor

% Resultado esperado: p(xi) ≈ y(i) con error del orden de eps
% =========================================================
%}
