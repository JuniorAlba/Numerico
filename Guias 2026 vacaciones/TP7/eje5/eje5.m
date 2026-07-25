addpath('..');
y_exacta = @(t) t.*exp(3*t)./5 - exp(3*t)./25 + exp(-2*t)./25;
f = @(t,y) t.*exp(3*t) - 2*y;
dfdy = @(t,y) -2 + 0*t.*y;
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

fprintf('\n=== EJERCICIO 5: RK4 vs PREDICTOR-CORRECTOR ADAMS ===\n');
fprintf('Aproximación de y(1) y cálculo del error relativo.\n');
fprintf('----------------------------------------------------------------\n');
fprintf('   L (paso h) |   Err Rel RK4    | Err Rel Predictor-Corrector \n');
fprintf('----------------------------------------------------------------\n');
for i=1:3
    fprintf(' %2d (h=%.2f) |   %.4e   |    %.4e\n', ...
        L(i), (tf-t0)/L(i), abs(valor - y_rk4(i))/abs(valor), abs(valor - y_predictorcorrector(i))/abs(valor));
end
fprintf('----------------------------------------------------------------\n');
fprintf('\nCONCLUSIÓN:\n');
fprintf('- Ambos métodos son teóricamente de orden O(h^4).\n');
fprintf('- Se observa que el error decrece en un factor cercano a 16 al dividir h a la mitad.\n');
fprintf('- RK4 resulta tener una constante de error menor que el Predictor-Corrector en este problema.\n');