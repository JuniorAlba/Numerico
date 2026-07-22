addpath('..');

% --- Etapa 1: t = 0 a 2 ---
t_etapa1 = [0 1 2]';
x_etapa1 = [0 2 6]';
y_etapa1 = [0 4 6]';

% Trazador sujeto con derivadas 0 en los extremos (reposo al inicio y en t=2)
[x1_func, dx1, ddx1] = funcion_spline(t_etapa1, x_etapa1, 0, 0);
[y1_func, dy1, ddy1] = funcion_spline(t_etapa1, y_etapa1, 0, 0);

% --- Etapa 2: t = 2 a 4 ---
t_etapa2 = [2 3 4]';
x_etapa2 = [6 3 0]';
y_etapa2 = [6 2 0]';

% Trazador sujeto con derivadas 0 en los extremos (reposo en t=2 y al final)
[x2_func, dx2, ddx2] = funcion_spline(t_etapa2, x_etapa2, 0, 0);
[y2_func, dy2, ddy2] = funcion_spline(t_etapa2, y_etapa2, 0, 0);

% --- Evaluaciones para graficar ---
t1_graf = linspace(0, 2, 100);
t2_graf = linspace(2, 4, 100);

x1_eval = x1_func(t1_graf);
y1_eval = y1_func(t1_graf);

x2_eval = x2_func(t2_graf);
y2_eval = y2_func(t2_graf);

% --- Gráficas ---
figure(1); clf; hold on;
plot(t1_graf, x1_eval, 'b-', 'LineWidth', 2, 'DisplayName', 'Etapa 1');
plot(t2_graf, x2_eval, 'r-', 'LineWidth', 2, 'DisplayName', 'Etapa 2');
plot([t_etapa1; t_etapa2(2:3)], [x_etapa1; x_etapa2(2:3)], 'ko', 'MarkerFaceColor', 'k');
title('(a) x vs t');
xlabel('Tiempo (s)'); ylabel('Posición x');
legend('Location', 'best');
grid on;

figure(2); clf; hold on;
plot(t1_graf, y1_eval, 'b-', 'LineWidth', 2, 'DisplayName', 'Etapa 1');
plot(t2_graf, y2_eval, 'r-', 'LineWidth', 2, 'DisplayName', 'Etapa 2');
plot([t_etapa1; t_etapa2(2:3)], [y_etapa1; y_etapa2(2:3)], 'ko', 'MarkerFaceColor', 'k');
title('(b) y vs t');
xlabel('Tiempo (s)'); ylabel('Posición y');
legend('Location', 'best');
grid on;

figure(3); clf; hold on;
plot(x1_eval, y1_eval, 'b-', 'LineWidth', 2, 'DisplayName', 'Trayectoria Etapa 1');
plot(x2_eval, y2_eval, 'r-', 'LineWidth', 2, 'DisplayName', 'Trayectoria Etapa 2');
plot([x_etapa1; x_etapa2(2:3)], [y_etapa1; y_etapa2(2:3)], 'ko', 'MarkerFaceColor', 'k');
title('(c) Trayectoria completa en plano xy');
xlabel('x'); ylabel('y');
legend('Location', 'best');
grid on;