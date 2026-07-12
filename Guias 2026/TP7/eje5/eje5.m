y_exacta = @(t) t*exp(3*t)./5-exp(3*t)./25+exp(-2*t)./25;
f = @(t,y) t*exp(3*t) -2*y;
dfdy = @(t,y) -2 + 0*t*y;
t0 = 0;
tf = 1;
y0 = 0;

L = [5 10 20];
y_predictorcorrector =[];
y_rk4 = [];
for i =1:1:3
    L1 = L(i);
    [_, aux_predictorcorrector] = PredictorCorrectorAdams(f,t0,tf,y0,L1);
    [_,aux_rk4] =rk4(f,[t0 tf],y0,L1);
    y_predictorcorrector = [y_predictorcorrector ; aux_predictorcorrector(end)];
    y_rk4 = [y_rk4 ; aux_rk4(end)];

endfor
valor = y_exacta(1);

display([ abs(valor - y_predictorcorrector)/abs(valor)   abs(valor - y_rk4)/abs(valor) ])
% segun los resultados predictor corrector O(h^4) - RK4 O(h^4)