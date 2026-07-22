% --- DEFINICIÓN DEL PROBLEMA ---
addpath('..');
f = @(x) 20.*x - (x.^3)./5;
df = @(x) 20 - 0.6.*x.^2;

% Integrando para el área de revolución
g = @(x) 2.*pi .* f(x) .* sqrt(1 + (df(x)).^2);

a = 0;
b = 2;

fprintf('=== EJERCICIO 10: ÁREA DE SUPERFICIE DE REVOLUCIÓN ===\n\n');

% ---------------------------------------------------------
% 1. VALOR DE REFERENCIA (con quad)
% ---------------------------------------------------------
area_exacta = quad(g, a, b);
fprintf('Valor de referencia (quad): %.6f\n', area_exacta);
fprintf('--------------------------------------------------\n');

% ---------------------------------------------------------
% 2. CUADRATURA DE GAUSS (n=3)
% ---------------------------------------------------------

area_gauss = cuad_gauss_c(g,a,b,1,3);
error_gauss = abs(area_exacta - area_gauss)/area_exacta;

fprintf('Gauss (n=3):              %.6f (Error Rel: %.2e)\n', area_gauss, error_gauss);

% ---------------------------------------------------------
% 3. SIMPSON SIMPLE (1 intervalo / bloque completo)
% ---------------------------------------------------------
% Usamos 3 puntos: a, punto medio, b
x_simp_simple = [a, (a+b)/2, b];
y_simp_simple = g(x_simp_simple);

% Llamamos a tu función simpsoncomp (que maneja vectores)
area_simp_simple = simpsoncomp(x_simp_simple, y_simp_simple);
error_simp_simple = abs(area_exacta - area_simp_simple)/area_exacta;

fprintf('Simpson Simple (h=1):     %.6f (Error Rel: %.2e)\n', area_simp_simple, error_simp_simple);

% ---------------------------------------------------------
% 4. REGLAS COMPUESTAS (L = 5 subintervalos)
% ---------------------------------------------------------
L = 5;
x_comp = linspace(a, b, L+1); % Genera 6 puntos: 0, 0.4, ..., 2.0
y_comp = g(x_comp);

% -- TRAPECIO --
area_trap = trapcomp(x_comp, y_comp);
error_trap = abs(area_exacta - area_trap)/area_exacta;

fprintf('Trapecio Compuesto (L=5): %.6f (Error Rel: %.2e)\n', area_trap, error_trap);

% -- SIMPSON COMPUESTO --
% NOTA: Simpson requiere número IMPAR de puntos (L par).
% Con L=5 tenemos 6 puntos. Tu función simpsoncomp dará error o calculará mal.
% Para cumplir con la consigna, mostramos qué pasa y sugerimos usar L=4 o L=6.

try
    area_simp_L5 = simpsoncomp(x_comp, y_comp);
    fprintf('Simpson (L=5):            %.6f\n', area_simp_L5);
catch
    fprintf('Simpson (L=5):            FALLÓ (Correcto, L debe ser par para Simpson 1/3)\n');
end

% Calculamos con L=4 para comparar con una regla válida cercana
L_valid = 4;
x_simp_valid = linspace(a, b, L_valid+1);
area_simp_valid = simpsoncomp(x_simp_valid, g(x_simp_valid));
error_simp_valid = abs(area_exacta - area_simp_valid)/area_exacta;

fprintf('Simpson (L=4) [Alternativa]: %.6f (Error Rel: %.2e)\n', area_simp_valid, error_simp_valid);