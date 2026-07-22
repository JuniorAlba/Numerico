% Definición de h (vector columna)
h = (10.^(-1:-1:-11))';

valor_exacto = 4;

x0 = 0;
f = @(x) exp(x) - 2*x.^2 + 3.*x - 1;

% Fórmula progresiva de dos puntos: (f(x+h) - f(x)) / h
% Nota: Al pasarle el vector h, Octave calcula todo el vector de golpe
derivada_aprox = (f(x0 + h) - f(x0)) ./ h;

% Cálculo del error absoluto
error_abs = abs(derivada_aprox - valor_exacto);

% Mostrar resultados en tabla [h, aproximación, error]
disp('       h         Aproximación      Error Abs');
disp([h, derivada_aprox, error_abs]);

% --- INCISO A: GRAFICAR ---
figure(1);
hold on
loglog(h, error_abs, '-o', 'LineWidth', 2, 'DisplayName', 'progresiva 2 (ptos) O(h)');
grid on;
xlabel('Tamaño de paso (h)');
ylabel('Error Absoluto');
title('Comparacion formula de 3 puntos vs formula de 2 puntos');
set(gca, 'XDir', 'reverse'); % Invertir eje X para ver h disminuyendo hacia la derecha

%Al disminuir el h tambien disminuye el error de truncamiento, pero para un h muy pequeño
%predomina el error de redondeo, por lo que no tiene sentido seguir disminuyendo h
%En resumen: No siempre un $h$ más pequeño garantiza un mejor resultado.
%Existe un valor óptimo (en este caso cercano a $10^{-8}$, que coincide
%con la raíz cuadrada de la precisión de máquina $\sqrt{\epsilon}$) donde
%se logra el equilibrio mínimo entre el error matemático de la fórmula y
%las limitaciones de precisión de la computadora."

%b
% --- INCISO B: VERIFICACIÓN DE COTA (h = 0.1) ---
h_b = 0.1;
error_real_b = abs(derivada_aprox(1) - valor_exacto);

% 2. Cálculo de la cota teórica
% La segunda derivada es f''(x) = exp(x) - 4
% Su máximo absoluto en [0, 0.1] ocurre en x=0, donde |1 - 4| = 3.
max_f2 = 3;
cota_teorica = (max_f2 / 2) * h_b;

fprintf('\n--- Inciso B: Verificación con h=0.1 ---\n');
fprintf('Error Real     : %.5f\n', error_real_b);
fprintf('Cota Teórica   : %.5f\n', cota_teorica);

if error_real_b <= cota_teorica
    disp('VERIFICADO: El error real es menor o igual a la cota teórica.');
else
    disp('FALLO: El error real supera la cota teórica.');
end




% c. Fórmula Centrada (Inciso c) - O(h^2)
% f'(x) approx (f(x+h) - f(x-h)) / 2h
derivada_centrada = (f(x0 + h) - f(x0 - h)) ./ (2 * h);
error_cent = abs(derivada_centrada - valor_exacto);

% Mostrar tabla comparativa
disp('       h         Error Progresiva     Error Centrada');
disp([h, error_abs, error_cent]);

% --- GRÁFICA COMPARATIVA ---
loglog(h, error_cent, '-s', 'LineWidth', 2, 'DisplayName', 'Centrada (3 ptos) O(h^2)');
legend('Location', 'best');

% --- CONCLUSIÓN INCISO C ---
% 1. La fórmula centrada O(h^2) converge mucho más rápido hacia el valor
%    exacto que la fórmula progresiva O(h). Esto se evidencia en que para 
%    el mismo tamaño de paso, el error de la centrada es notablemente menor.
% 2. Sin embargo, al alcanzar valores de h sumamente pequeños (alrededor 
%    de 10^-5 o 10^-6), la fórmula centrada choca antes con los errores de 
%    redondeo de la máquina. La pérdida de significancia (cancelación catastrófica) 
%    por restar números muy similares hace que el error de la centrada 
%    vuelva a crecer y se dispare, de forma incluso más pronunciada que la 
%    fórmula progresiva para h muy chicos (como 10^-11).