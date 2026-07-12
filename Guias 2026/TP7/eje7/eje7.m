inter = [0 20];
f = @(t,x) [-t*x(2) ; t*x(1) - t*x(2)];
x0 = [1; -1]
L = 400;
[t,x] = euler(f,inter,x0,L);

% --- FIGURA 1: Evolución Temporal (Ambas variables juntas) ---
figure(1); clf; % clf limpia la figura si ya existía
plot(t, x(:,1), 'b-', 'LineWidth', 2); hold on;
plot(t, x(:,2), 'r--', 'LineWidth', 2);
hold off;

title('Evolución Temporal de x_1 y x_2');
xlabel('Tiempo (t)');
ylabel('Valor de las variables');
legend('x_1 (Decaimiento)', 'x_2 (Respuesta)', 'Location', 'best');
grid on;
grid minor; % Cuadrícula más fina opcional
axis([0 5 -1.2 1.2]); % Hacemos zoom en la parte interesante (t de 0 a 5)

% --- FIGURA 2: Plano de Fase (Trayectoria) ---
figure(2); clf;
plot(x(:,1), x(:,2), 'k-', 'LineWidth', 2); hold on;

% Marcamos el inicio y el fin para que se entienda la dirección
plot(x(1,1), x(1,2), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g'); % Punto verde inicio
plot(x(end,1), x(end,2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Punto rojo fin

title('Plano de Fase: Trayectoria del Sistema');
xlabel('Estado x_1');
ylabel('Estado x_2');
legend('Trayectoria', 'Inicio', 'Fin');
grid on;