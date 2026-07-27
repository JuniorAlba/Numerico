addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
x1 = [0.0819 ; 0.2192 ; 0.3582 ; 0.3831 ; 0.5256 ; 0.8478 ; 0.9872];
ge = [20 ; 48.6 ; 70.3 ; 72.3 ; 84.1 ; 53.5 ; 5.7];
R = 1.987;
T = 328;

%ITEM A -------------
y = R*T*(x1.*(1-x1))./(ge);
[p] = polyfit(x1,y,1)
A1 = 1/p(2)
A2 = 1/(p(1)+1/A1)
%resultados:
%A1 = 0.393
%A2 = 0.707


%ITEM B --------------
ge = @(x) A1*A2*R*T*x.*(1-x)./(A1*x + A2*(1-x));
ge(0.3)
%62.114


%ITEM C --------------
error_rel_C = abs(80 - ge(0.5))/80
%resultado 2.95e-2

%ITEM D -------------
%ITEM D -------------
ge2 = @(x) ge(x) - 10;
[x1_opt, h, it] = biseccion(ge2, 0.5, 1, 10000, 1e-12);
% Como piden trimetilpentano (x2 = 1 - x1):
x2_opt = 1 - x1_opt
% Resultado con 5 decimales exactos:
% x2_opt = 0.02261