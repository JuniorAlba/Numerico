addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
P = [0.985 1.108 1.363 1.631];
V = [25000 22200 18000 15000];
R = 82.05;
T = 303;

%ITEM A -------------------
datos = P.*V.^3./(R*T) - V.^2;
[pol] = polyfit(V,datos,1);
A1 = pol(1)
A2 = pol(2)
%RESULT:
%A1 = -234.127
%A2 = -58270.7

%ITEM B -------------------
P = @(V) (1+A1./V+A2./(V.^2)).*R*T./(V);
tol = 5e-5;
itmax = 10000;
VV = linspace(25000,1000,1000);
plot(VV,P(VV))

[p,h,it] =  biseccion(@(v) P(v)-2 , 11000,15000,10000,5e-5);
p
[p,h,it] =  biseccion(@(v) P(v)-0.5 ,48500,50000,10000,5e-5);
p
%resultados:
%p1:12187
%p2:49485

%ITEM C --------------------------
L =1000;
Q_ant = intNCcompuesta(P,10000,30000,L,3);

L =2*L;
Q = intNCcompuesta(P,10000,30000,L,3);
error_C = abs(Q-Q_ant)/abs(Q_ant)<5e-7
Q
%resultados:
%Q = 26918.28
