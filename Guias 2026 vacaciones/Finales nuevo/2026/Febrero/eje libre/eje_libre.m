addpath('../../../../TP8');
addpath('../../../../TP7');
addpath('../../../../TP6');
addpath('../../../../TP5');
addpath('../../../../TP4');
addpath('../../../../TP3');
addpath('../../../../TP2');
format long;
w = [0.2 ; 0.5 ; 0.8 ; 1.1; 1.4 ; 1.7 ; 2.0];
A = [2.33 ; 2.06  ; 1.78; 1.53; 1.31; 1.13; 0.98];
%ITEM A --------------------

b = A.*(1+w.^2);
f1 = w;
f2 = ones(length(w),1);
f3 = -A.*w;
M = [f1 f2 f3];
C = M'*M;
Y = M'*b;
coef = C\Y
%Resultados:
%beta=1.9425
%alfa=2.3060
%y_rara=0.6423


%ITEM B -----------------
A = @(w) (coef(1)*w + coef(2))./(1+coef(3)*w+w.^2);
dA = @(w) (coef(1)*(1+coef(3)*w+w.^2)-(coef(1).*w+coef(2)).*(coef(3)+2.*w))./((1+coef(3)*w+w.^2).^2);
w_plot = linspace(0,2,1000);
plot(w_plot, A(w_plot), 'b', 'LineWidth',2);
hold on;
%esta entre 0 y 1
[p,h,it] = biseccion(dA,0,1,1000,0.5e-8);
p
A(p)
dA(p)
%resultados
%Amax= 2.3275300
%p=9.6130509e-2

