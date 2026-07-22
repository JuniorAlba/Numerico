clear all; clc;
addpath('..');

display("=========================================");
display("RESOLUCIÓN INCISO (C) MEDIANTE SISTEMA LINEAL");
display("=========================================");
% Queremos hallar b, c y d para el segundo tramo S1(x).
% S0(x) = 1 + 2x - x^3
% S1(x) = 2 + b(x-1) + c(x-1)^2 + d(x-1)^3

% Planteamos un sistema de ecuaciones M * v = k, donde v = [b; c; d]

% 1. Continuidad 1ra Derivada en x=1: S0'(1) = S1'(1)
% S0'(x) = 2 - 3x^2 => S0'(1) = -1
% S1'(x) = b + 2c(x-1) + 3d(x-1)^2 => S1'(1) = b
% Ecuación: 1*b + 0*c + 0*d = -1

% 2. Continuidad 2da Derivada en x=1: S0''(1) = S1''(1)
% S0''(x) = -6x => S0''(1) = -6
% S1''(x) = 2c + 6d(x-1) => S1''(1) = 2c
% Ecuación: 0*b + 2*c + 0*d = -6

% 3. Frontera Natural en x=2: S1''(2) = 0
% S1''(2) = 2c + 6d(2-1) = 2c + 6d
% Ecuación: 0*b + 2*c + 6*d = 0

M = [1  0  0; 
     0  2  0; 
     0  2  6];
     
k = [-1; -6; 0];

% Resolvemos el sistema
v = M \ k;

b_hallado = v(1)
c_hallado = v(2)
d_hallado = v(3)


display("=========================================");
display("VERIFICACIÓN USANDO LA FUNCIÓN DEL INCISO (B)");
display("=========================================");
% Si b=-1, c=-3, d=1, entonces el punto final es:
% y(2) = S1(2) = 2 + b(1) + c(1)^2 + d(1)^3 = 2 - 1 - 3 + 1 = -1
% Vamos a darle esos puntos a tu función cubic_spline_natural para ver si devuelve 
% exactamente los mismos coeficientes de S0 y S1.

x_nodos = [0; 1; 2];
y_nodos = [1; 2; -1]; % y(0)=1, y(1)=2, y(2)=-1

[a, b, c, d] = cubic_spline_natural(x_nodos, y_nodos);

display("Coeficientes del Tramo 2 (S1) según cubic_spline_natural:");
b_tramo2 = b(2)
c_tramo2 = c(2)
d_tramo2 = d(2)

if (abs(b_tramo2 - b_hallado) < 1e-10 && abs(c_tramo2 - c_hallado) < 1e-10 && abs(d_tramo2 - d_hallado) < 1e-10)
    display("¡Verificación exitosa! Los coeficientes coinciden perfectamente.");
end
