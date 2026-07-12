format long;
t0 = 0;
tf = 2;
y0 = 0;

% Definición de funciones
f = @(t,y) -y+sin(t)+cos(t);
sol_exacta = @(t) sin(t);

error_metodos = [];

% Bucle de iteración para distintos pasos h
for i=1:1:6
    L=20*2^(i-1);   % Empieza en L=20 (h=1/10) y va duplicando pasos
    
    % Llamada a los métodos (asumiendo que tienes los archivos euler.m, rk2.m, rk4.m)
    [t_euler,y_euler] = euler(f,[t0 tf],y0,L);
    [t_rk2,y_rk2] = rk2(f,[t0 tf],y0,L);
    [t_rk4,y_rk4] = rk4(f,[t0 tf],y0,L);
    
    % Guardamos la última aproximación (y en t=2)
    error_metodos = [error_metodos ; y_euler(end) y_rk2(end) y_rk4(end)];
endfor

% --- MOSTRAR RESULTADOS ---

display("     Euler            RK2             RK4             Valor Exacto");
% Mostramos las aproximaciones comparadas con el valor real
display([error_metodos(:,1)  error_metodos(:,2)  error_metodos(:,3)  linspace(sol_exacta(2),sol_exacta(2),6)']);


% --- CÁLCULO DE ERRORES (IMPORTANTE PARA EL TP) ---

% 1. ERROR ABSOLUTO: |y_aprox - y_exacta|
% USA ESTA TABLA para responder cuántos decimales correctos tienes.
% - Para 3 decimales: busca valores menores a 0.0005 (5.0e-04)
% - Para 6 decimales: busca valores menores a 0.0000005 (5.0e-07)
err_abs_euler = abs(error_metodos(:,1) - sol_exacta(2));
err_abs_rk2   = abs(error_metodos(:,2) - sol_exacta(2));
err_abs_rk4   = abs(error_metodos(:,3) - sol_exacta(2));

display("ERROR ABSOLUTO (Mirar este para 'decimales correctos'):");
display("     Err_Abs_Euler    Err_Abs_RK2      Err_Abs_RK4");
display([err_abs_euler  err_abs_rk2  err_abs_rk4]);


% 2. ERROR RELATIVO (Corregido)
% Corregí el paréntesis del RK2 que estaba dividiendo antes de restar.
display("ERROR RELATIVO (Sintaxis corregida):");
display("     Err_Rel_Euler    Err_Rel_RK2      Err_Rel_RK4 ");
display([ ...
    abs(sol_exacta(2) - error_metodos(:,1))/abs(sol_exacta(2)) ... 
    abs(sol_exacta(2) - error_metodos(:,2))/abs(sol_exacta(2)) ...  % <--- AQUÍ ESTABA EL ERROR
    abs(sol_exacta(2) - error_metodos(:,3))/abs(sol_exacta(2)) ...
]);
% RK4: para 3 decimales correctos se necesito L=20 pasos y 20*4 evaluaciones de funcion
% RK4: para 6 decimales correctos se necesito L=40 pasos y 40*4 evaluaciones de funcion

% RK2: para 3 decimales correctos se necesito L=80 pasos y 80*2 evaluaciones de funcion
% RK2: para 6 decimales correctos no se llego a la cantidad de pasos necesarios

% RK2: para 3 decimales correctos no se llego a la cantidad de pasos necesarios
