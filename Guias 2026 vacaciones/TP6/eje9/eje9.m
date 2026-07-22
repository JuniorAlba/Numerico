addpath('..');
a = 0;
b = 1;
f = @(x) x.^2.*exp(-x);
v_exacto = 2-5*exp(-1);
int_NC = intNCcompuesta(f,a,b,1,2);
int_CG = cuad_gauss_c(f,a,b,1,2);
E_CG_N2 = abs(v_exacto - int_CG)/abs(v_exacto);
E_NC_N2 = abs(v_exacto - int_NC)/abs(v_exacto);

fprintf('=== EJERCICIO 9: CUADRATURA DE GAUSS VS NEWTON-COTES ===\n');
fprintf('Para n = 2:\n');
fprintf('Error Relativo Cuadratura de Gauss: %.4e\n', E_CG_N2);
fprintf('Error Relativo Newton-Cotes       : %.4e\n', E_NC_N2);

int_NC = intNCcompuesta(f,a,b,1,3);
int_CG = cuad_gauss_c(f,a,b,1,3);
E_CG_N3 = abs(v_exacto - int_CG)/abs(v_exacto);
E_NC_N3 = abs(v_exacto - int_NC)/abs(v_exacto);

fprintf('\nPara n = 3:\n');
fprintf('Error Relativo Cuadratura de Gauss: %.4e\n', E_CG_N3);
fprintf('Error Relativo Newton-Cotes       : %.4e\n', E_NC_N3);
