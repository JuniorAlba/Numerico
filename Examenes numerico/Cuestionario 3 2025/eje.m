format long;
x = [-1 1 2 3 4]';
y = [0.23 0.25 0.26 0.14 0.06]';
y1 = 1./y;
f1 = @(x) exp(x);
f2 = @(x) x;
f3 = @(x) 1*x.^0;

% Mt*M*a = Mt*y
M = [f1(x)  f2(x)   f3(x)];
A = M'*M;
b = M'*y1;
a = A\b;

coef_a = (a(3)/7.5)^(-1);
coef_c = a(2)*coef_a;
coef_b = a(1)*coef_a;

figure(1)
f = @(x)    coef_a./(coef_b*f1(x) + coef_c*f2(x) + 7.5);
hold on;
plot(x,y)
xx = linspace(-1,4,100);
plot(xx,f(xx))
coef_a
coef_b
coef_c


[f_s,d_fs,dd_fs]=funcion_spline(x,y);
plot(xx,f_s(xx))
f_s(0)
%error relativo del ajuste por minimos cuadrados
abs(0.23 - f(0))/abs(0.23)

%error relativo de la spline cubica
abs(0.23 - f_s(0))/abs(0.23)