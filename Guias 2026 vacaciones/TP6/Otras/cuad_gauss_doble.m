function J = cuad_gauss_doble(f,a,b,c,d,m,n)
% function J = cuad_gauss_doble(f,a,b,c,d,m,n)
%
% Aproxima la integral doble de la función f sobre el rectángulo [a,b] x [c,d]
% utilizando Cuadratura de Gauss iterada.
%
% ENTRADAS:
%   f: Función anónima de dos variables f(x,y).
%   a, b: Límites de integración en el eje x.
%   c, d: Límites de integración en el eje y (pueden ser funciones de x o constantes).
%   m: Número de puntos de Gauss para el eje x.
%   n: Número de puntos de Gauss para el eje y.
%
% SALIDAS:
%   J: Aproximación del valor de la integral doble.
%
% OBJETIVO:
%   Aplicar cuadratura de Gauss en 2D mapeando nodos de [-1,1] a los intervalos reales.

% segun el Burden (pag.243 version 9)
% Paso1
h1=(b-a)/2;
h2=(b+a)/2;
J=0;
% calculamos raices y coeficientes de la cuadratura de gauss
[xgm,wm]=gauss_xw(m);
A=[xgm,wm]; % matriz coeficientes "m"
[xgn,wn]=gauss_xw(n);
B=[xgn,wn]; % matriz coeficientes "n"

% Paso2
for i=1:m
  % Paso3 
  JX=0;
  x = h1*A(i,1)+h2;
  %d1=d(x);
  d1=d;
  %c1=c(x);
  c1=c;
  k1=(d1-c1)/2;
  k2=(d1+c1)/2;
  % Paso4
  for j=1:n
    y=k1*B(j,1)+k2;
    Q=f(x,y);
    JX=JX + B(j,2)*Q;
  endfor
  % Paso5
  J=J+A(i,2)*k1*JX;
endfor

% Paso6 (Salida del programa)

J=h1*J;

endfunction


  



