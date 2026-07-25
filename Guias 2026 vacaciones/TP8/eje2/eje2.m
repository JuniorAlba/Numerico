p = @(x) -2./x;
q = @(x) 2./(x.^2);
r = @(x) sin(log(x))./(x.^2);
f = @(x) [p(x) q(x) r(x)];
yc = [1 2];
inter = [1 2];

% --- Definición de constantes ---
% Nota: en Octave/Matlab, log() es el logaritmo natural (ln)
c2 = (1/70) * (8 - 12*sin(log(2)) - 4*cos(log(2)));
c1 = (11/10) - c2;

% --- Declaración de la función exacta ---
% Esta función recibe 'x' y devuelve el valor exacto de 'y'
y_exacta = @(x) c1.*x + c2./(x.^2) - (3/10).*sin(log(x)) - (1/10).*cos(log(x));

% --- Ejemplo de uso ---
% Si tu vector de pasos es x_vec:
% y_real = y_exacta(x_vec);

h = 0.1;
L = (inter(2) -inter(1))/(h);
[x,y] = disparo_lineal(f,inter,yc,L);
error1 = max(abs(y_exacta(x)-y));
%se usa error absoluto y no relativo pq si la solucion pasa por y=0 entonces nuestro metodo falla
h = 0.01;
L = (inter(2) -inter(1))/(h);
[x,y] = disparo_lineal(f,inter,yc,L);
error2 = max(abs(y_exacta(x)-y));

error1/error2

%redujimos el paso 10 veces, sin embargo, el error disminuye alrededor de 10000 veces con respecto al error anterior
%empiricamente Disparo_lineal aprox O(h^4)