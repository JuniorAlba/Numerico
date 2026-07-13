function p = pruebapolyfit(f, a, b, n)
% PRUEBAPOLYFIT  Interpola f con n puntos equiespaciados en [a,b] usando polyfit.
%
% Entradas:
%   f  - Handle de la función a interpolar
%   a  - Extremo izquierdo del intervalo
%   b  - Extremo derecho del intervalo
%   n  - Cantidad de puntos de interpolación (grado del polinomio = n-1)
%
% Salidas:
%   p  - Coeficientes del polinomio interpolante en formato polyval (grado n-1)
%
% Ejemplo de uso: ver al final del archivo (seleccionar y presionar F9)

  % --- Configuración interna ---
  medir_tiempo  = false; % true: muestra cuánto tarda
  opcion_verbose = 1;    % 0: silencioso | 1: imprime el error máximo

  % Resolución de la grilla fina para graficar
  N_plot = 200;

  % --- Inicio ---
  if medir_tiempo
    tic_handle = tic;
  endif

  % n puntos equiespaciados donde vamos a interpolar
  X = linspace(a, b, n);
  Y = f(X);

  % polyfit ajusta un polinomio de grado n-1 que pasa exactamente por los n puntos
  p = polyfit(X, Y, n-1);

  % grilla fina para los gráficos
  xx  = linspace(a, b, N_plot);
  fxx = f(xx);
  pxx = polyval(p, xx);

  err        = abs(fxx - pxx);
  max_err    = max(err);

  % --- Reporte ---
  if medir_tiempo
    tiempo = toc(tic_handle);
  endif

  if opcion_verbose >= 1
    printf("--- Resumen pruebapolyfit ---\n");
    printf("Intervalo: [%g, %g] | n = %d puntos (grado %d)\n", a, b, n, n-1);
%    printf("Error máximo: %e\n", max_err);
    printf("Error máximo: %.15g\n", max_err);
    if medir_tiempo
      printf("Tiempo: %f s\n", tiempo);
    endif
    printf("-----------------------------\n");
  endif

  % --- Gráficos ---
  figure(1);
  plot(xx, fxx, 'LineWidth', 2, xx, pxx, 'LineWidth', 2, X, Y, '*');
  legend('función original', 'polinomio interpolante');
  grid on;
  title(sprintf('Interpolación polinomial (n=%d)', n));
  set(gca, 'FontSize', 14);

  figure(2);
  plot(xx, err, 'LineWidth', 2);
  grid on;
  title(sprintf('Error puntual |f(x) - p(x)| (max = %e)', max_err));
  xlabel('x');
  ylabel('error absoluto');
  set(gca, 'FontSize', 14);

endfunction

%{
% =========================================================
% EJEMPLO DE USO — seleccionar bloque y presionar F9
% =========================================================

f = @(x) 1 ./ (1 + 25*x.^2);  % función de Runge — buen caso para ver el fenómeno

p5  = pruebapolyfit(f, -1, 1, 5);   % 5 puntos: bastante bien
p11 = pruebapolyfit(f, -1, 1, 11);  % 11 puntos: empiezan las oscilaciones en los bordes
p15 = pruebapolyfit(f, -1, 1, 15);  % 15 puntos: fenómeno de Runge bien visible

% Resultado esperado:
%   Con n=5 el error máximo es del orden 1e-1
%   Con n=11 el error baja en el centro pero explota en los extremos
%   Con n=15 el error máximo puede superar 1 — el polinomio diverge en los bordes
% =========================================================
%}
