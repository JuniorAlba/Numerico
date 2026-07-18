addpath("..");
g1 = @(x) 0.5*(10-x.^3).^(0.5);
g2 = @(x) (10/(4+x))^(1/2);
p0=1.5;
tol=1e-3
a =1;
b =2;
[x, rh, it] = puntofijo(g1,p0,500,tol);
x
it
rh(it)
[x, rh, it] = puntofijo(g2,p0,500,tol);
x
it
rh(it)

display("------------")

% --- Cálculo de derivadas de forma analítica (sin pkg load symbolic) ---
% Definimos las derivadas analíticamente como funciones anónimas
% g1(x) = 0.5 * sqrt(10 - x^3) -> dg1(x) = 0.5 * (1/2) * (10 - x^3)^(-1/2) * (-3*x^2)
dg1 = @(x) -0.75 .* x.^2 ./ sqrt(10 - x.^3);

% g2(x) = sqrt(10 / (4 + x)) = sqrt(10) * (4 + x)^(-1/2) -> dg2(x) = -0.5 * sqrt(10) * (4 + x)^(-1.5)
dg2 = @(x) -0.5 .* sqrt(10) ./ ((4 + x).^1.5);

% Evaluar en puntos del intervalo [1,2]
x_val = linspace(1, 2, 5);
dg1_vals = dg1(x_val);
dg2_vals = dg2(x_val);

disp('Valores de g1''(x) en [1,2]:');
disp(dg1_vals)

disp('Valores de g2''(x) en [1,2]:');
disp(dg2_vals)

%se puede ver que ambas derivadas toman valores menores que 1 en cercanias de p
%c)
%las cotas dadas por el colorario 2.4 no son aplicables a g1 en el intervalo [1,2]
%pero si sin aplicables a g2 en el intervalo


%el error con respecto a la solucion exacta deberia ser menor o igual a:
%k es aproximadamente 0.2 debido a que el valor abs de la primera derivada de
%g2 en [1,2] es siempre menor a 0.2
k=0.2;
k^(it)*max(p0-a,b-p0)
