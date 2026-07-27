addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;

f = @(t,c) [-0.013*c(1)-1000*c(1).*c(3) ; -2500*c(2).*c(3) ; 0.013*c(1)-2500*c(2).*c(3)-1000*c(1).*c(3)];

%ITEM A -------------------
h = 0.001;  %dado que el intervalo es grande, definimos un tamaño de paso chico
            %para asegurar que el metodo converja.
%vemos que con este paso converge por lo que debe estar por debajo
%del tamaño critico. Recordar que RK4 es un metodo con estabilidad condicional.
pasos = (50-0)/h;
[t,c] = rk4(f, [0,50], [1,1,0], pasos);
c_ant = c;
error_aprox_A = [inf];
error_aprox_B = [inf];
error_aprox_C = [inf];

while (error_aprox_A(end) >= 0.5e-5 || error_aprox_B(end) >= 0.5e-5 || error_aprox_C(end) >= 0.5e-5)
  
  pasos = pasos*2;
  [t,c] = rk4(f, [0,50], [1,1,0], pasos);
  error_aprox_A = [error_aprox_A; abs(c(end,1)-c_ant(end,1))];
  error_aprox_B = [error_aprox_B; abs(c(end,2)-c_ant(end,2))];
  error_aprox_C = [error_aprox_C; abs(c(end,3)-c_ant(end,3))];
  c_ant = c;
endwhile

error_aprox_A(end)
error_aprox_B(end)
error_aprox_C(end)
c(end,1)
c(end,2)

%resultados item A
%Ca = 0.4444
%Cb = 0.6686

%ITEM B---------------------
q=simpsoncomp(t,c(:,2));
q
%resultado ITEM B
%q = 40.74228168758036