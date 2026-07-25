addpath('..');
fprintf('\n=== EJERCICIO 10: PÉNDULO SIMPLE ===\n');

% Sistema: x(1) = phi, x(2) = phi'
% x1' = x2
% x2' = -sin(x1)
f = @(t,x) [x(2) ; -sin(x(1))];
inter = [0 20];
L = 400; % h = 0.05

condiciones = {
    [0.1; 0],   'a) Pequeña oscilación (armónica)'
    [0.7; 0],   'b) Oscilación moderada'
    [3.0; 0],   'c) Oscilación amplia (cerca de pi)'
    [3.5; 0],   'd) Oscilación amplia (inicia pasada de pi)'
    [0; 1.0],   'e) Impulso moderado desde abajo'
    [0; 1.99],  'f) Impulso crítico (apenas no da la vuelta)'
    [0; 2.0],   'g) Impulso justo para quedar arriba (inestable)'
    [0; 2.01],  'h) Impulso fuerte (da la vuelta completa)'
};

figure(1); clf;
for i=1:length(condiciones)
    x0 = condiciones{i}{1};
    titulo = condiciones{i}{2};
    
    [t, x] = rk4(f, inter, x0, L);
    
    subplot(4, 2, i);
    plot(t, x(:,1), 'b-', 'LineWidth', 1.5);
    title(titulo);
    xlabel('t'); ylabel('\phi(t)');
    grid on;
end
sgtitle('Evolución del ángulo \phi(t) para distintas condiciones');

% Respuestas físicas a imprimir
fprintf('\nEXPLICACIÓN FÍSICA DE LOS CASOS:\n');
fprintf('a) y b): El péndulo se suelta desde un ángulo pequeño/moderado y oscila de un lado a otro como un péndulo normal.\n');
fprintf('c) y d): Se suelta desde muy alto (casi vertical arriba). Oscila bajando con mucha velocidad y subiendo al otro lado.\n');
fprintf('e): El péndulo arranca abajo (phi=0) pero con velocidad inicial. Sube hasta cierta altura y vuelve a caer, oscilando.\n');
fprintf('f): Velocidad inicial casi límite. El péndulo sube casi hasta la vertical superior (pi), pero la gravedad lo frena justo a tiempo y vuelve a caer.\n');
fprintf('g): Caso teórico. La energía es exactamente la necesaria para llegar al punto más alto y quedarse ahí estático (equilibrio inestable).\n');
fprintf('h): Se le da tanta velocidad abajo que la gravedad no llega a frenarlo. Da vueltas completas continuamente (phi sigue creciendo indefinidamente).\n');
