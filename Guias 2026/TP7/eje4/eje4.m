y_exacta = @(t) t*exp(3*t)./5-exp(3*t)./25+exp(-2*t)./25;
f = @(t,y) t*exp(3*t) -2*y;
dfdy = @(t,y) -2 + 0*t*y;
t0 = 0;
tf = 1;
y0 = 0;

L = [5 10 20];
y_backeuler =[];
y_euler = [];
y_CN = [];
for i =1:1:3
    L1 = L(i);
    [_, aux_backeuler] = back_euler(f, dfdy,t0,tf,y0,L1);
    [_,aux_euler] = euler(f,[t0 tf],y0,L1);
    [_,aux_CN] = CN_newton(f,dfdy,t0,tf,y0,L1);
    y_backeuler = [y_backeuler ; aux_backeuler(end)];
    y_euler = [y_euler ; aux_euler(end)];
    y_CN = [y_CN ; aux_CN(end)];

endfor
valor = y_exacta(1);

display([ abs(valor - y_backeuler)/abs(valor)   abs(valor - y_euler)/abs(valor) abs(valor - y_CN)/abs(valor)])
% segun los resultados euler O(h) - backeuler O(h) - CN_newton O(h^2)