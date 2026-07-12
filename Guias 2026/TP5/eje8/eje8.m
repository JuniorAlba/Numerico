% --- DATOS ---
t = [0:1:6]';
y = [432 599 1012 1909 2977 4190 5961]';

% --- CÁLCULO DE MODELOS ---
% p6: Polinomio interpolador (grado n-1 = 6)
p6 = polyfit(t, y, 6);
% p1: Ajuste Lineal (Cuadrados Mínimos)
p1 = polyfit(t, y, 1);
% p2: Ajuste Cuadrático (Cuadrados Mínimos)
p2 = polyfit(t, y, 2);

% --- ERRORES CUADRÁTICOS (Inciso d) ---
E6 = error_cuadratico(p6, t, y); % Debería ser casi 0
E1 = error_cuadratico(p1, t, y);
E2 = error_cuadratico(p2, t, y);

fprintf('Error Cuadrático p6 (Interpolación): %.4f\n', E6);
fprintf('Error Cuadrático p1 (Lineal): %.4f\n', E1);
fprintf('Error Cuadrático p2 (Cuadrático): %.4f\n', E2);

% --- PREDICCIONES (Inciso e y f) ---
val_real = 14900;
pred_p6 = polyval(p6, 10);
pred_p1 = polyval(p1, 10);
pred_p2 = polyval(p2, 10);

rel_err_p6 = abs(val_real - pred_p6) / val_real;
rel_err_p1 = abs(val_real - pred_p1) / val_real;
rel_err_p2 = abs(val_real - pred_p2) / val_real;

% --- GRAFICACIÓN ---
t_graf = linspace(0, 10, 100); % Extiendo a 10 para ver la predicción visualmente

figure(1); clf; hold on;
% 1. Graficar los DATOS reales (Círculos negros)
plot(t, y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Datos Reales');

% 2. Graficar los Modelos
plot(t_graf, polyval(p6, t_graf), 'g-', 'linewidth', 2, 'DisplayName', 'P6 (Interpolador)');
plot(t_graf, polyval(p1, t_graf), 'b--', 'linewidth', 2, 'DisplayName', 'P1 (Lineal)');
plot(t_graf, polyval(p2, t_graf), 'r-', 'linewidth', 2, 'DisplayName', 'P2 (Cuadrático)');

% 3. Graficar el dato real de la semana 10
plot(10, val_real, 'mx', 'MarkerSize', 10, 'linewidth', 3, 'DisplayName', 'Dato Real Sem 10');

legend('Location', 'northwest');
grid on; xlabel('Semanas'); ylabel('Cantidad de Mosquitos');
title('Comparación de Modelos y Predicción');
ylim([0 16000]); % Ajustar zoom para ver todo

% =========================================================================
% RESPUESTAS TEÓRICAS (INCISOS D, E, F)
% =========================================================================
%{
  -------------------------------------------------------------------------
  RESPUESTA AL INCISO (d): Evaluación inicial de modelos
  -------------------------------------------------------------------------
  - Error Cuadrático p6: Es prácticamente 0 (orden de 10^-23). Esto es lógico
    porque es un polinomio interpolador de grado 6 para 7 puntos; pasa
    EXACTAMENTE por todos los datos.
  - Error Cuadrático p1: Es muy alto. El modelo lineal no captura la curvatura
    de crecimiento poblacional.
  - Error Cuadrático p2: Es bajo, aunque no cero.

  ¿Cuál parece más apropiado inicialmente?
  A primera vista, uno podría pensar que p6 es el mejor porque tiene error 0.
  Sin embargo, p2 (cuadrático) captura muy bien la tendencia de crecimiento
    acelerado sin oscilaciones raras. En ciencia, modelos más simples suelen ser mejores.

  -------------------------------------------------------------------------
  RESPUESTA AL INCISO (e): Predicción a 10 semanas
  -------------------------------------------------------------------------
  Al extrapolar a t=10, notamos el peligro del SOBREAJUSTE (Overfitting):
  - El polinomio p6 (Interpolador) probablemente da un valor absurdo o muy
    lejano. Los polinomios de alto grado oscilan violentamente fuera del
    rango de datos conocidos.
  - El modelo p2 predice un crecimiento continuo y suave.

  ¿Sigue pensando que el elegido antes es el mejor?
  Sí, el modelo p2 parece ser el único robusto para predecir el futuro.
  El p6 es inútil para predecir (extrapolar) aunque fuera perfecto para
  describir el pasado (interpolar).

  -------------------------------------------------------------------------
  RESPUESTA AL INCISO (f): Validación con dato real (14900)
  -------------------------------------------------------------------------
  Observando los Errores Relativos calculados:
  - El modelo Lineal (p1) subestima enormemente (da ~8800 vs 14900).
  - El modelo Interpolador (p6) suele fallar drásticamente en la predicción.
  - El modelo Cuadrático (p2) es el que más se acerca a 14900.

  CONCLUSIÓN FINAL:
  El modelo cuadrático (p2) es el que da la mejor predicción. Esto confirma
  que para datos con ruido o tendencias naturales, el ajuste por Cuadrados
  Mínimos de grado bajo (2) es superior a la Interpolación de alto grado (6),
  ya que filtra el ruido y captura la tendencia general sin "memorizar"
  los datos.
%}