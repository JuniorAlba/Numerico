function Q = intNCcompuesta2(f,a,b,c,d,L1,L2,n)
% function Q = intNCcompuesta2(f,a,b,c,d,L1,L2,n)
%
% Aproxima la integral doble de la función f sobre el rectángulo [a,b] x [c,d]
% utilizando la fórmula de Newton-Cotes compuesta de n puntos.
%
% ENTRADAS:
%   f: Función anónima de dos variables f(x,y)
%   a, b: Límites de integración en el eje x
%   c, d: Límites de integración en el eje y
%   L1: Cantidad de subintervalos en el eje x
%   L2: Cantidad de subintervalos en el eje y
%   n: Número de puntos de la regla de Newton-Cotes
%
% SALIDA:
%   Q: Aproximación del valor de la integral doble

sub1 = linspace(a,b,L1+1);
sub2 = linspace(c,d,L2+1);

h = (b-a)/L1;
k = (d-c)/L2;
% calculamos los pesos una sola vez
w = pesosNC(n);
Q = 0;

for j=1:L2
y = linspace(sub2(j),sub2(j+1),n);
  for i=1:L1
    x = linspace(sub1(i),sub1(i+1),n);
    fxy = f(x, y');
    Q = Q +(w'*(fxy*w));
  endfor
endfor
Q *= k*h;

endfunction
