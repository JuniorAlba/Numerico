a = 0;
b = 1;
f = @(x) x.^2.*exp(-x);
v_exacto = 2-5*exp(-1);
int_NC = intNCcompuesta(f,a,b,1,2);
int_CG = cuad_gauss_c(f,a,b,1,2);
E_CG_N2 = abs(v_exacto - int_CG)/abs(v_exacto)
E_NC_N2 = abs(v_exacto - int_NC)/abs(v_exacto)

int_NC = intNCcompuesta(f,a,b,1,3);
int_CG = cuad_gauss_c(f,a,b,1,3);
E_CG_N3 = abs(v_exacto - int_CG)/abs(v_exacto)
E_NC_N3 = abs(v_exacto - int_NC)/abs(v_exacto)
