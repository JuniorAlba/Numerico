% Ej4TP06
clear all; clc;clf
addpath('..');
format long
% Funciones
fa = @(x) sin(pi*x);
fb = @(x) 1./(1+x.^2);
% Soluciones analíticas
Ia=2/pi;
Ib=atan(5)-atan(-5);
% Ponemos el vector error en cero
err=[];
% Generamos untos para la graficación
xa=linspace(0,5,201);
xb=linspace(-5,5,201);
% Calculamos por integracion numérica compuesta, pero con L=1
% es decir un solo intervalo, con diferentes cuadraturas.
for n=2:13
  Q1 = intNCcompuesta(fa,0,5,1,n);
  Q2 = intNCcompuesta(fb,-5,5,1,n);
  err=[err; abs(Ia-Q1) abs(Ib-Q2)];

  %========================================================================================
  subplot(2,1,1)
  xia = linspace(0,5,n);
  % Graficamos la funcion y el polinomio que la aproxima y calcula
  % por integración numérica.
  plot(xa,fa(xa),xa,polyval(polyfit(xia,fa(xia),n-1),xa))
  grid on, grid minor
  title('Integracion funcion sin(pi*x), Analitica-Numericas,L=1');
  legend('Funcion analitica', 'Polinomio Interpolante gr <= n','location', 'north')
  txt = text(1, 0.5, ''); % crea el objeto de texto en (1, 0.5)
  set(txt, 'String', sprintf('n = % 3i', n)); % actualiza el n utilizado
  xlabel('ptos x')
  ylabel('f(x) Pn(x)')
 %========================================================================================
  subplot(2,1,2)
  xib = linspace(-5,5,n);
  plot(xb,fb(xb),xb,polyval(polyfit(xib,fb(xib),n-1),xb))
  title('Integracion funcion: 1/(1+x^2), Analitica-Numericas,L=1');
  grid on, grid minor
  %legend('Funcion analitica', 'Polinomio Interpolante gr <= n')
  txt = text(1, 0.5, ''); % crea el objeto de texto en (1, 0.5)
  set(txt, 'String', sprintf('n = % 3i', n)); % actualiza el n utilizado
  xlabel('ptos x')
  ylabel('f(x) Pn(x)')
  pause(1)
endfor
% Imprimimos las tablas de forma limpia
fprintf('\n======================================================\n');
fprintf('  TABLA 1: f(x) = sin(pi*x) en [0, 5]\n');
fprintf('------------------------------------------------------\n');
fprintf('  n  |  | Integral Exacta - Q_n |\n');
fprintf('------------------------------------------------------\n');
for i = 1:length(err(:,1))
    fprintf(' %2d  |        %.6e\n', i+1, err(i,1));
end
fprintf('======================================================\n\n');

fprintf('======================================================\n');
fprintf('  TABLA 2: f(x) = 1/(1+x^2) en [-5, 5]\n');
fprintf('------------------------------------------------------\n');
fprintf('  n  |  | Integral Exacta - Q_n |\n');
fprintf('------------------------------------------------------\n');
for i = 1:length(err(:,2))
    fprintf(' %2d  |        %.6e\n', i+1, err(i,2));
end
fprintf('======================================================\n\n');

E1=err(:,1);
E2=err(:,2);
nn=linspace(2,13,12)';
figure(2)
% Graficamos el error para la función: sin(pi*x)
plot(E1,'-b')
grid on; grid minor;
title('Variacion del Error funcion sin(pi*x)')
figure(3)
% Graficamos el error para la función: sin(pi*x)
plot(E2,'-k')
grid on; grid minor;
title('Variacion del Error funcion 1/(1+x^2)')
% --- Conclusion Item (c) ---
% No es cierto que el limite de Qn(f,a,b) sea igual a la integral exacta para toda funcion f.
%
% Justificacion basada en los resultados:
% 1. Si bien aumentar 'n' incrementa el grado del polinomio interpolador (haciendo
%    que la formula sea exacta para polinomios de mayor grado), esto no garantiza
%    que el polinomio se acerque a la funcion original f(x).
%
% 2. Como observamos en el item (b) con la funcion f2(x) = 1/(1+x^2), al usar
%    puntos equiespaciados con un 'n' grande, el polinomio interpolador empieza
%    a oscilar fuertemente en los extremos del intervalo.
%
% 3. Estas oscilaciones hacen que el calculo del area (la integral del polinomio)
%    se aleje del valor real de la integral de f(x), provocando que el error
%    aumente en lugar de disminuir a medida que crece n.

% 4. EXPLICACIÓN TEÓRICA (Derivadas y Acotación):
%    El error de Newton-Cotes está acotado por un término que incluye a la 
%    n-ésima derivada de la función f(x) multiplicada por h^n.
%    - En f1(x) = sin(pi*x), la n-ésima derivada crece como pi^n, un crecimiento 
%      moderado que es dominado por el decrecimiento de h^n y n!. Por eso el error baja.
%    - En f2(x) = 1/(1+x^2) (Función de Runge), las derivadas n-ésimas crecen
%      a un ritmo factorial (n!). Este crecimiento desproporcionado supera 
%      rápidamente al término que lo acota (h^n), haciendo que el error diverja.