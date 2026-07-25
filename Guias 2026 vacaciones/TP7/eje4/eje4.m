addpath('..');
y_exacta = @(t) t.*exp(3*t)./5 - exp(3*t)./25 + exp(-2*t)./25;
f = @(t,y) t.*exp(3*t) - 2*y;
dfdy = @(t,y) -2 + 0*t.*y;
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

fprintf('\n=== EJERCICIO 4: ANÁLISIS DE ERROR Y ORDEN ===\n');
fprintf('Aproximación de y(1) y cálculo del error relativo.\n');
fprintf('------------------------------------------------------------------------------------------\n');
fprintf('   L (paso h) |   Err Rel Euler   | Err Rel Back-Euler | Err Rel C-Nicholson \n');
fprintf('------------------------------------------------------------------------------------------\n');
for i=1:3
    fprintf(' %2d (h=%.2f) |    %.4e    |    %.4e    |    %.4e\n', ...
        L(i), (tf-t0)/L(i), abs(valor - y_euler(i))/abs(valor), ...
        abs(valor - y_backeuler(i))/abs(valor), abs(valor - y_CN(i))/abs(valor));
end
fprintf('------------------------------------------------------------------------------------------\n');
fprintf('\nCONCLUSIÓN:\n');
fprintf('- Euler y Backward Euler reducen su error a la mitad al dividir h a la mitad (Orden O(h)).\n');
fprintf('- Crank-Nicholson reduce su error a la cuarta parte al dividir h a la mitad (Orden O(h^2)).\n');