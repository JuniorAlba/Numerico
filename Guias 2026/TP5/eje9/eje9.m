% --- DATOS ---
x = [-1 0 1 2];
y = [-1.1 -0.4 -0.9 -2.7];

% --- 1. TRANSFORMACIÓN (LINEARIZACIÓN) ---
% El modelo es y = -e^(ax^2+bx+c)
% Despejamos el exponente: ln(-y) = ax^2 + bx + c
ln_y = log(-y); 

% --- 2. AJUSTE POR CUADRADOS MÍNIMOS ---
% Ajustamos un polinomio de grado 2 a los datos transformados
p = polyfit(x, ln_y, 2); 

% --- 3. EVALUACIÓN Y TRANSFORMACIÓN INVERSA ---
x_graph = linspace(-1.5, 2.5, 100);


log_estimado = polyval(p, x_graph);
% Volvemos a la escala original: y = -e^(poly)
y_estimado = -exp(log_estimado);

% --- 4. GRAFICACIÓN ---
figure(1); clf; hold on; grid on;
plot(x, y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Datos reales');
plot(x_graph, y_estimado, 'g-', 'linewidth', 2, 'DisplayName', 'Modelo Exponencial');

legend('Location', 'southwest');
xlabel('x'); ylabel('y');
title('Ajuste No Lineal mediante Transformación Logarítmica');

%{
  =============================================================================
  COMENTARIO TEÓRICO: AJUSTE DE CURVA NO LINEAL
  =============================================================================
  
  1. EL PROBLEMA:
     Se sospecha que los datos siguen la forma f(x) = -e^(ax^2+bx+c).
     Este es un modelo NO LINEAL en sus parámetros, por lo que no podemos usar
     polyfit directamente sobre 'y'.

  2. LA SOLUCIÓN (LINEARIZACIÓN):
     Para resolverlo, aplicamos una transformación que convierta el problema
     en uno polinómico estándar:
     
     a) Multiplicamos por -1:  -y = e^(ax^2+bx+c)
     b) Aplicamos ln:          ln(-y) = ax^2 + bx + c
     
     Ahora, la nueva variable dependiente z = ln(-y) se comporta como una
     parábola (polinomio de grado 2) respecto a x.

  3. EL PROCEDIMIENTO:
     - Calculamos z = ln(-y) para cada dato.
     - Usamos polyfit(x, z, 2) para encontrar a, b y c (Cuadrados Mínimos).
     - Para graficar, evaluamos el polinomio y aplicamos la inversa:
       y_pred = -exp( polyval(p, x) )
       
  4. CONCLUSIÓN VISUAL:
     La curva verde ajusta suavemente los puntos negros, confirmando que la
     hipótesis del modelo exponencial cuadrático es razonable para estos datos.
  =============================================================================
%}