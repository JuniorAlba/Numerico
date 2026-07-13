function res = analizar_orden_convergencia(h, opcion_verbose)
% ANALIZAR_ORDEN_CONVERGENCIA  Estima el orden de convergencia a partir
%   de un vector de errores usando ajuste log-log.
%
%   El modelo subyacente es:  e_{n+1} ≈ C * e_n^p
%   → en escala log: log(e_{n+1}) = p * log(e_n) + log(C)
%   Eso es una recta; polyfit da la pendiente p (el orden).
%
% Entradas:
%   h              - Vector de errores (fila o columna). La función detecta
%                    si está en orden creciente o decreciente y lo acomoda.
%                    Debe tener al menos 4 elementos para un análisis útil.
%   opcion_verbose - (Opcional) 0: silencioso | 1: resumen | 2: detallado.
%                    Default: 1.
%
% Salidas:
%   res  - Struct con los campos:
%            .orden            → string: 'lineal', 'superlineal',
%                                'cuadratico', 'supercuadratico',
%                                'sublineal', 'irregular', 'indeterminado'
%            .p                → exponente estimado (pendiente del ajuste)
%            .coef             → C tal que e_{n+1} ≈ C * e_n^p
%            .r_squared        → R² del ajuste log-log (bondad de ajuste)
%            .tipo_convergencia → descripción legible del resultado
%
% Ejemplo de uso: ver al final del archivo

  % --- Configuración interna ---
  medir_tiempo = false;  % true: muestra cuánto tarda el análisis
  graficar     = true;   % true: abre figura con historial + recta ajustada
  TOL_R2       = 0.90;   % R² mínimo para confiar en la clasificación
  TOL_P_LIN    = 0.20;   % si |p - 1| < esto → lineal
  TOL_P_CUAD   = 0.25;   % si |p - 2| < esto → cuadrático
  MIN_PARES    = 3;      % mínimo de pares (e_n, e_{n+1}) válidos

  % --- arg opcional ---
  if nargin < 2
    opcion_verbose = 1;
  endif

  if medir_tiempo
    tic_h = tic;
  endif

  % --- Inicializar resultado por defecto (por si salgo antes) ---
  res.orden             = 'indeterminado';
  res.p                 = NaN;
  res.coef              = NaN;
  res.r_squared         = NaN;
  res.tipo_convergencia = 'No se pudo determinar (datos insuficientes o inconsistentes).';

  % --- Limpieza del vector ---
  h = h(:);
  h = h(isfinite(h) & h > 0);  % saco NaN, Inf, y ceros (log no está definido)

  if length(h) < MIN_PARES + 1
    if opcion_verbose >= 1
      printf('[analizar_orden_convergencia] ADVERTENCIA: muy pocos datos (%d). ', length(h));
      printf('Se necesitan al menos %d puntos positivos y finitos.\n', MIN_PARES + 1);
    endif
    return;
  endif

  % --- Orientar como secuencia decreciente (convergiendo) ---
  % si el primer error es menor al último, está al revés
  if h(1) < h(end)
    h = flipud(h);
    if opcion_verbose == 2
      printf('[analizar_orden_convergencia] Vector invertido (era ascendente).\n');
    endif
  endif

  % --- Armar pares (e_n, e_{n+1}) ---
  en  = h(1:end-1);
  en1 = h(2:end);

  % pueden quedar pares inválidos si hay no-monotonicidad local
  validos = (en > 0) & (en1 > 0);
  en  = en(validos);
  en1 = en1(validos);

  if length(en) < MIN_PARES
    if opcion_verbose >= 1
      printf('[analizar_orden_convergencia] ADVERTENCIA: pares válidos insuficientes (%d).\n', length(en));
    endif
    return;
  endif

  % --- Ajuste log-log: log(e_{n+1}) = p * log(e_n) + log(C) ---
  log_en  = log(en);
  log_en1 = log(en1);

  coefs = polyfit(log_en, log_en1, 1);  % → [p, log(C)]
  p_est = coefs(1);
  C_est = exp(coefs(2));

  % --- R² del ajuste en escala log ---
  log_en1_fit = polyval(coefs, log_en);
  ss_res = sum((log_en1 - log_en1_fit).^2);
  ss_tot = sum((log_en1 - mean(log_en1)).^2);

  if ss_tot < eps
    r2 = 1;  % todos iguales → trivialmente perfecto (pero no útil)
  else
    r2 = 1 - ss_res / ss_tot;
  endif

  % --- Guardar en el struct ---
  res.p         = p_est;
  res.coef      = C_est;
  res.r_squared = r2;

  % --- Clasificar según p y R² ---
  if r2 < TOL_R2
    res.orden             = 'irregular';
    res.tipo_convergencia = sprintf( ...
      'Convergencia IRREGULAR (R²=%.3f < %.2f). Patrón no ajusta bien; datos ruidosos o método inestable.', ...
      r2, TOL_R2);

  elseif p_est < 1 - TOL_P_LIN
    res.orden             = 'sublineal';
    res.tipo_convergencia = sprintf( ...
      'Convergencia SUBLINEAL (p≈%.3f). Converge muy despacio; el ratio e_{n+1}/e_n → 1.', p_est);

  elseif abs(p_est - 1) <= TOL_P_LIN
    res.orden             = 'lineal';
    res.tipo_convergencia = sprintf( ...
      'Convergencia LINEAL (p≈%.3f, C≈%.4f). Ratio e_{n+1}/e_n ≈ C constante. Típico: bisección, Jacobi.', ...
      p_est, C_est);

  elseif p_est > 1 + TOL_P_LIN && p_est < 2 - TOL_P_CUAD
    res.orden             = 'superlineal';
    res.tipo_convergencia = sprintf( ...
      'Convergencia SUPERLINEAL (p≈%.3f, C≈%.4f). Ratio → 0 pero más lento que cuadrático. Típico: secante (p≈1.618).', ...
      p_est, C_est);

  elseif abs(p_est - 2) <= TOL_P_CUAD
    res.orden             = 'cuadratico';
    res.tipo_convergencia = sprintf( ...
      'Convergencia CUADRÁTICA (p≈%.3f, C≈%.4f). e_{n+1} ≈ C * e_n^2. Típico: Newton-Raphson.', ...
      p_est, C_est);

  else
    res.orden             = 'supercuadratico';
    res.tipo_convergencia = sprintf( ...
      'Convergencia SUPER-CUADRÁTICA (p≈%.3f, C≈%.4f). Orden > 2. Raro; revisar si los datos son correctos.', ...
      p_est, C_est);
  endif

  % --- Reporte ---
  if opcion_verbose >= 1
    printf('--- Análisis de Orden de Convergencia ---\n');
    printf('Puntos usados:      %d pares\n', length(en));
    printf('Orden estimado (p): %.4f\n', p_est);
    printf('Coeficiente C:      %.4e\n', C_est);
    printf('R² del ajuste:      %.4f\n', r2);
    printf('Clasificación:      %s\n', res.orden);
    if opcion_verbose == 2
      printf('Descripción: %s\n', res.tipo_convergencia);
    endif
    printf('-----------------------------------------\n');
  endif

  if opcion_verbose == 2
    % imprimir ratios uno por uno para ver si convergen a algo o a 0
    ratios = en1 ./ en;
    printf('Ratios e_{n+1}/e_n (deben → constante si lineal, → 0 si superlineal):\n');
    for k = 1:length(ratios)
      printf('  Iter %2d: %.6f\n', k, ratios(k));
    endfor
  endif

  % --- Gráfico ---
  if graficar

    % líneas de referencia teóricas (p=1 y p=2) ancladas al centroide de los datos
    % para que la comparación visual sea honesta
    cx = mean(log_en);
    cy = mean(log_en1);
    xx = linspace(min(log_en), max(log_en), 60);
    ref_lineal = 1 * (xx - cx) + cy;        % pendiente 1
    ref_cuad   = 2 * (xx - cx) + cy;        % pendiente 2
    ajuste_fit = polyval(coefs, xx);

    figure;

    % subplot superior: historial de error en semilogy
    subplot(2, 1, 1);
    n_iter = length(h);
    semilogy(1:n_iter, h + eps, '-ob', 'MarkerFaceColor', 'b', 'LineWidth', 1.5);
    grid on;
    xlabel('Iteración');
    ylabel('Error');
    title(sprintf('Historial de error  |  Clasificación: %s', res.orden));

    % subplot inferior: log(e_{n+1}) vs log(e_n) con recta ajustada y refs
    subplot(2, 1, 2);
    plot(log_en, log_en1, 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 6);
    hold on;
    plot(xx, ajuste_fit, '-r', 'LineWidth', 2.0);
    plot(xx, ref_lineal, '--k', 'LineWidth', 1.0);
    plot(xx, ref_cuad,   ':m', 'LineWidth', 1.0);
    hold off;
    grid on;
    xlabel('log(e_n)');
    ylabel('log(e_{n+1})');
    title(sprintf('Ajuste log-log: p = %.3f  |  R² = %.4f', p_est, r2));
    legend( ...
      'Datos', ...
      sprintf('Ajuste (p=%.2f)', p_est), ...
      'Ref. lineal (p=1)', ...
      'Ref. cuadrático (p=2)', ...
      'Location', 'northwest');

  endif

  if medir_tiempo
    printf('Tiempo de análisis: %.4f s\n', toc(tic_h));
  endif

endfunction


%{
% =========================================================
% EJEMPLO DE USO — seleccionar bloque y presionar F9
% =========================================================

% --- Caso 1: Bisección sobre f(x) = x^3 - x - 2 en [1,2] ---
% Convergencia lineal esperada (p ≈ 1, C ≈ 0.5)
f1 = @(x) x.^3 - x - 2;
[~, h_bis] = biseccion(f1, 1, 2, 60, 1e-14);
printf('\n=== Bisección ===\n');
res_bis = analizar_orden_convergencia(h_bis, 1);

% --- Caso 2: Newton-Raphson sobre la misma función ---
% Convergencia cuadrática esperada (p ≈ 2)
df1 = @(x) 3*x.^2 - 1;
[~, h_nwt] = newton(f1, df1, 1.5, 30, 1e-14);
printf('\n=== Newton-Raphson ===\n');
res_nwt = analizar_orden_convergencia(h_nwt, 1);

% --- Caso 3: Secante sobre la misma función ---
% Convergencia superlineal esperada (p ≈ 1.618)
[~, h_sec] = secante(f1, 1, 2, 30, 1e-14);
printf('\n=== Secante ===\n');
res_sec = analizar_orden_convergencia(h_sec, 1);

% --- Caso 4: datos sintéticos cuadráticos para verificar ---
h_sint = 1;
for k = 1:10
  h_sint(end+1) = 0.5 * h_sint(end)^2;
  if h_sint(end) < 1e-14, break; endif
endfor
printf('\n=== Sintético cuadrático (C=0.5, p=2) ===\n');
res_sint = analizar_orden_convergencia(h_sint, 1);

% Resultado esperado:
%   Bisección  → lineal,      p ≈ 1.00, C ≈ 0.50
%   Newton     → cuadrático,  p ≈ 2.00
%   Secante    → superlineal, p ≈ 1.618
%   Sintético  → cuadrático,  p ≈ 2.00, C ≈ 0.50
% =========================================================
%}
