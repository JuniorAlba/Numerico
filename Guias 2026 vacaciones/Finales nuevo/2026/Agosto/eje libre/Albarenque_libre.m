addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;

%ITEM A-------------
t = 2;
T = [40 45 50 55 60 65 70]';
Concentracion = [0.12 0.2 0.29 0.37 0.45 0.41 0.36]';
f1 = 1.*T.^0;
f2 = t./T;
f3 = T;
M = [f1 f2 f3];
A = M'*M;
b = M'*Concentracion;
coef_a = A\b;

k1_a = coef_a(1)
k2_a = coef_a(2)
k3_a = coef_a(3)
%resultado:
%k1 = 3.1416
%k2 = -43.7718
%k3 = -0.0215

%ITEM B ----------
%ajuste para t = 6
t2 = 6;
C_t6 = [0.3 0.37 0.44 0.51 0.42 0.25 0.07]';

f1_6 = 1.*T.^0;
f2_6 = t2./T;
f3_6 = T;
M_6 = [f1_6 f2_6 f3_6];
A_6 = M_6'*M_6;
b_6 = M_6'*C_t6;
coef_b_6 = A_6\b_6;

% ajuste para t = 12
t3 = 12;
C_t12 = [0.47 0.45 0.43 0.41 0.22 0.11 0.002]';

f1_12 = 1.*T.^0;
f2_12 = t3./T;
f3_12 = T;
M_12 = [f1_12 f2_12 f3_12];
A_12 = M_12'*M_12;
b_12 = M_12'*C_t12;
coef_b_12 = A_12\b_12;

% evaluando los errores
err_2 = sum((M * coef_a - Concentracion).^2)
err_6 = sum((M_6 * coef_b_6 - C_t6).^2)
err_12 = sum((M_12 * coef_b_12 - C_t12).^2)
% el que tiene menor error cuadratico es que utiliza las mediciones de t=12

% prrediccion a 9 minutos y 62 grados
t_itemb = 9;
T_itemb = 62;
C_itemb = coef_b_12(1) + coef_b_12(2)*(t_itemb/T_itemb) + coef_b_12(3)*T_itemb

%resultado = 0.56980

%ITEM C-------

C_itemc = 0.35;
T_itemc = 57;

k1 = coef_b_12(1);
k2 = coef_b_12(2);
k3 = coef_b_12(3);

t_itemc = (C_itemc - k1 - k3*T_itemc) * T_itemc / k2
%resultado = 11.76
