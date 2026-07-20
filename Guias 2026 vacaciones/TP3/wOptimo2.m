% Busca el w optimo para SOR por fuerza bruta.
% Igual que wOptimo pero permite elegir la cantidad de decimales de w.
%
% Entradas:
%   A        : matriz de coeficientes
%   b        : vector de terminos independientes
%   x0       : estimacion inicial
%   tol      : tolerancia para el criterio de parada de SOR
%   maxit    : numero maximo de iteraciones para cada prueba
%   decimales: cantidad de decimales correctos deseados para w (ej: 3)
% Salidas:
%   w_opt : valor de w que minimizo las iteraciones
function [w_opt] = wOptimo2(A, b, x0, tol, maxit, decimales)

  % Calculamos el paso a partir de los decimales (ej: 3 -> 0.001)
  paso = 10^(-decimales);

  % Rango de w a probar (SOR requiere 0 < w < 2)
  w_vec = 0.01 : paso : 1.99;

  % Guardamos la cantidad de iteraciones para cada w
  its = zeros(size(w_vec));

  for k = 1:length(w_vec)
    [~, it_k, ~] = SOR(A, b, x0, maxit, tol, w_vec(k));
    its(k) = it_k;
  endfor

  % El w optimo es el que necesito menos iteraciones
  [~, idx] = min(its);
  w_opt = w_vec(idx);

endfunction
