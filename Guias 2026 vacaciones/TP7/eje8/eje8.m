addpath('..');
fprintf('\n=== EJERCICIO 8: MODELO PRESA-DEPREDADOR (Lotka-Volterra) ===\n');

% RESPUESTA TEÓRICA INCISO A:
% Ecuaciones:
% x1'(t) = x1 * (3 - 0.002 * x2)
% x2'(t) = -x2 * (0.5 - 0.0006 * x1)
%
% 1) ¿Qué especie puede sobrevivir sin la otra?
% Si x2 = 0, x1'(t) = 3*x1 (crecimiento exponencial). x1 puede sobrevivir sola.
% Si x1 = 0, x2'(t) = -0.5*x2 (decaimiento exponencial). x2 se extingue sola.
% 2) Conclusión: 
% x1 es la PRESA (crece sin depredadores)
% x2 es el PREDADOR (muere sin presas)

f = @(t,x) [x(1)*(3 - 0.002*x(2)) ; -x(2)*(0.5-0.0006*x(1))];
x0 = [1600; 800];
inter = [0 12];
L = 400; % h = 12/400 = 0.03
[t,x] = rk4(f,inter,x0,L);

fprintf('Simulación completada usando RK4 con %d pasos (h = %.3f).\n', L, (inter(2)-inter(1))/L);

% --- GRÁFICAS ---
figure(1); clf;
plot(t,x(:,1), 'b-', 'LineWidth', 2); hold on;
plot(t,x(:,2), 'r--', 'LineWidth', 2);
title('Evolución de las Poblaciones');
xlabel('Tiempo (Meses)');
ylabel('Población');
legend('Presas (x_1)', 'Depredadores (x_2)');
grid on;

figure(2); clf;
plot(x(:,1), x(:,2), 'k-', 'LineWidth', 2); hold on;
plot(x(1,1), x(1,2), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
title('Plano de Fase (Presas vs Depredadores)');
xlabel('Población de Presas (x_1)');
ylabel('Población de Depredadores (x_2)');
legend('Órbita cerrada', 'Inicio');
grid on;





% Tal como te pide describir el fenómeno, las gráficas muestran perfectamente el
% ciclo de Lotka-Volterra. Cuando hay muchas presas, la población de depredadores
% empieza a dispararse (tienen comida de sobra). Cuando los depredadores crecen
% demasiado, sobre-cazan a las presas y hacen que colapsen. Al colapsar las presas,
% los depredadores se mueren de hambre y colapsan también. Y al haber pocos
% depredadores, las presas vuelven a crecer, cerrando el ciclo. ¡Eso es
% exactamente esa orbita cerrada de la grafica 2