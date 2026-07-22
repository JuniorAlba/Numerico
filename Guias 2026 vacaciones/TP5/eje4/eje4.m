clear all; clc;
addpath('..');

x = [1; 2; 3];
y = [0; 4; 22/3];

% Condiciones de frontera sujeta
df_inicial = 3;
df_final = 3;

% Llamamos a la función desarrollada en el inciso a (cubic_spline_clamped)
[a, b, c, d] = cubic_spline_clamped(x, y, df_inicial, df_final);

display("=========================================");
display("COEFICIENTES DEL TRAZADOR CÚBICO SUJETO");
display("=========================================");

display("Coeficientes del Tramo 0 (S_0) para x en [1, 2):");
a0 = a(1)
b0 = b(1)
c0 = c(1)
d0 = d(1)

display("Coeficientes del Tramo 1 (S_1) para x en [2, 3]:");
a1 = a(2)
b1 = b(2)
c1 = c(2)
d1 = d(2)

% Generamos la función para graficar
[S, dS, ddS] = funcion_spline(x, y, df_inicial, df_final);

% Graficamos
x_graf = linspace(1, 3, 100);
figure(1); clf; hold on;
plot(x, y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Datos Reales');
plot(x_graf, S(x_graf), 'r-', 'linewidth', 2, 'DisplayName', 'Trazador Cúbico Sujeto');
grid on;
legend('Location', 'northwest');
title('Ejercicio 4: Interpolación Spline Sujeta');
xlabel('x'); ylabel('S(x)');