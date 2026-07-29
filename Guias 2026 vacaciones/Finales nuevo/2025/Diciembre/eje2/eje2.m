addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;

%PARA RESOLVER EL ITEM A NO TENGO LOS DATOS, SOLO PLATEO EL PROCEDIMIENTO
k = 0.2;
%t proviene de la tabla de datos
%C proviene de la tabla de datos
f1 =  t.*exp(-k*t);
f2 =  t.^2.*exp(-k*t);
f3 =  -t.*C;
M = [f1 f2 f3];
b = M'*C;
A = M'*M;
coeficientes = A\b;
coeficientes(1) %a
coeficientes(2) %b
coeficientes(3) %c

%ITEM B ---------------------------
