coef = -80/pi;
f = @(t,x) [x(2) ; coef*(x(1)./(sqrt(x(1).^2 + x(3).^2).^3)) ;  x(4) ; coef*(x(3)./(sqrt(x(1).^2 + x(3).^2).^3))];
y0 = [1.382; 0; 0; 5.573];
inter = [0 50];

L = 100;
[t,y_ant] = rk4(f,inter,y0,L);
pos_ant = [y_ant(end,1) y_ant(end,3)];

L=2*L;
[t,y] = rk4(f,inter,y0,L);
pos_actual = [y(end,1) y(end,3)];

dif = [ norm(pos_actual-pos_ant)];
pos_ant = pos_actual;
while(L<10000 && dif(end)> 0.5e-3)
    L = 2*L;
    [t,y] = rk4(f,inter,y0,L);
    pos_actual = [y(end,1) y(end,3)];
    dif = [dif; norm(pos_actual-pos_ant)];
    pos_ant = pos_actual;
endwhile

%inciso a
[t_a,y_a] = rk4(f,[0 1.5], y0, L);
[y_a(end,1) y_a(end,3)]
%  -2.7268   3.1930

%inciso b
ff = @(x,y) sqrt(x.^2 + y.^2);
[ymax, indice]=max(ff(y(:,1),y(:,3)));
xmax = y(indice,1) %xmax
ymax = y(indice,3) %ymax
tmax = t(indice)


figure(2)
hold on
plot(t,y(:,1)-1.382)
vueltas =5
hold off
%vueltas = 5;

%inciso d
[t_d,y_d] = rk4(f,[0 10], y0, L);
rapidez = sqrt( y_d(:,2).^2 + y_d(:,4).^2 );
distancia_recorrida = trapcomp(t_d,rapidez)



% --- DEFINICION DE FUNCION Y DATOS ---
% Definimos todo compacto
coef = -80/pi;
dist3 = @(x,y) (x.^2 + y.^2).^1.5; % Funcion auxiliar para no escribir tanto
f = @(t,u) [u(2); coef*u(1)/dist3(u(1),u(3)); u(4); coef*u(3)/dist3(u(1),u(3))];

y0 = [1.382; 0; 0; 5.573]; 

% --- PARAMETRO DE "FUERZA BRUTA" ---
L_seguro = 50000; % Un numero alto asegura precision sobrada

% --- INCISO A (t=1.5) ---
[t,y] = rk4(f, [0 1.5], y0, L_seguro);
fprintf('A) Posicion en 1.5: x=%.4f, y=%.4f\n', y(end,1), y(end,3));

% --- INCISO B (Afelio) y C (Vueltas) ---
% Calculamos 50 años de una vez
[t,y] = rk4(f, [0 50], y0, L_seguro);

% Para el afelio: Buscamos la distancia maxima
distancias = sqrt(y(:,1).^2 + y(:,3).^2);
[d_max, idx] = max(distancias);

fprintf('B) Afelio: Distancia=%.4f, Tiempo=%.4f\n', d_max, t(idx));
fprintf('   Coord Afelio: x=%.4f, y=%.4f\n', y(idx,1), y(idx,3));

% --- INCISO C (Grafico de la Orbita) ---
% TRUCO: No grafiques t vs x. Grafica X vs Y para ver la forma real.
figure(1);
plot(y(:,1), y(:,3)); 
title('Orbita Real (X vs Y)'); grid on; axis equal;
% CUENTA VISUALMENTE LAS ELIPSES QUE SE DIBUJAN

% --- INCISO D (Distancia) ---
% Solo necesitamos los primeros 10 años.
% Como ya calculamos hasta 50, podemos recortar el vector o calcular de nuevo rapido.
% Para asegurar, calculamos de nuevo rapido:
[t_d, y_d] = rk4(f, [0 10], y0, L_seguro);
vel = sqrt(y_d(:,2).^2 + y_d(:,4).^2);
dist = trapz(t_d, vel); % Octave tiene trapz nativo, usalo si puedes
fprintf('D) Distancia recorrida: %.4f\n', dist);