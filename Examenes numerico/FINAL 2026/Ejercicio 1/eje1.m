format long;
l = @(t) 10 + 1*cos(1*t+0.02);
dl = @(t) -1*sin(1*t+0.02);
g = 9.81;
p = @(t) -2*dl(t)./l(t);
q = @(t) -g./l(t);
r = @(t) 0*t;
f = @(t) [p(t) q(t) r(t)];
inter = [0 5];
y0 = [0.5 0];


L = 100;
[x,y] = dif_fin_rob(f, inter, y0(1), [0 1 y0(2)], L);
h = (inter(2) - inter(1)) / L;

% Aplicamos derivada hacia adelante de 3 puntos
y_prima = (-3*y(1) + 4*y(2) - y(3)) / (2*h);

while(1)
    y_prima_ant = y_prima;
    L = L * 2;

    [x,y] = dif_fin_rob(f, inter, y0(1), [0 1 y0(2)], L);
    h = (inter(2) - inter(1)) / L;
    y_prima = (-3*y(1) + 4*y(2) - y(3)) / (2*h);

    % Calculamos el error entre esta iteración y la anterior
    error_estimado = abs(y_prima - y_prima_ant);

    % Si el error ya no afecta al 3er/4to decimal, cortamos la ejecución
    if (error_estimado < 0.5e-4)
        break;
    endif
endwhile

% Imprimimos el resultado final
fprintf('La velocidad inicial theta''(0) es: %.4f rad/s\n', y_prima);
fprintf('Se alcanzó la convergencia con L = %d subintervalos\n', L);

L = 100;
[x,y] = dif_fin_rob(f, inter, y0(1), [0 1 y0(2)], L);
while(1)
    yant = y;
    L = L * 2;
    [x,y] = dif_fin_rob(f, inter, y0(1), [0 1 y0(2)], L);
    error = abs(y(L/2 +1) - yant(L/4 +1));
    if (error < 0.5e-5)
        break;
    endif
endwhile
y(L/2 +1)



L = 100;
[x,y] = dif_fin_rob(f, inter, y0(1), [0 1 y0(2)], L);
h = (inter(2) - inter(1)) / L;

% 1. Calculamos el vector de la derivada y_prima para todos los nodos
yp = zeros(L+1, 1);
% Extremo inicial (hacia adelante de 3 puntos)
yp(1) = (-3*y(1) + 4*y(2) - y(3)) / (2*h);
% Nodos interiores (centrada de 3 puntos)
yp(2:L) = (y(3:L+1) - y(1:L-1)) / (2*h);
% Extremo final (hacia atrás de 3 puntos)
yp(L+1) = (-3*y(L+1) + 4*y(L) - y(L-1)) / (2*h);

integrando = abs(yp);
S = trapcomp(x,integrando);

% 4. Entramos al ciclo para asegurar los 5 decimales exactos
while(1)
    S_ant = S;
    L = L * 2; % Manteniendo L par

    [x,y] = dif_fin_rob(f, inter, y0(1), [0 1 y0(2)], L);
    h = (inter(2) - inter(1)) / L;

    % Recalculamos derivadas para la nueva malla
    yp = zeros(L+1, 1);
    yp(1) = (-3*y(1) + 4*y(2) - y(3)) / (2*h);
    yp(2:L) = (y(3:L+1) - y(1:L-1)) / (2*h);
    yp(L+1) = (3*y(L+1) - 4*y(L) + y(L-1)) / (2*h);

    integrando = abs(yp);
    S = trapcomp(x,integrando);
    error_integral = abs(S - S_ant)/S;
    if (error_integral < 0.5e-5)
        break;
    endif
endwhile

fprintf('El desplazamiento angular total acumulado es S = %.6f rad\n', S);
fprintf('Convergencia del item (c) alcanzada con L = %d\n', L);