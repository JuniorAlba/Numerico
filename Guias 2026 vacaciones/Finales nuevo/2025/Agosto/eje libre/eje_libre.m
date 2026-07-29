addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
horas= [0.00000000e+00 3.00000000e+00 6.00000000e+00 9.00000000e+00 1.20000000e+01 1.50000000e+01 1.80000000e+01 2.10000000e+01 2.40000000e+01];
concentracion = [0.00000000e+00 6.77785127e+01 1.73792374e+02 1.98904274e+02 1.36240006e+02 6.39495531e+01 3.37687332e+01 1.37994266e+01 5.55864899e+00];
%ITEM A
[S,dS,ddS] = funcion_spline(horas,concentracion);
horas_plot = linspace(horas(1),horas(end),100);
figure(1)
plot(horas_plot,S(horas_plot));
[p,h,it] = biseccion(dS,5,10,10000,5e-7);
p
S(p)
%resultados:
%p = 8.181741
%S(p) = 202.7678


%ITEM B
figure(2)
plot(horas_plot,S(horas_plot)-50);
[p,h,it] = biseccion(@(x)(S(x)-50),10,20,10000,5e-7);
p
%resultados:
%p = 16.00943
