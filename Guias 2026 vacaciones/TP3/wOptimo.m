% Busca el w optimo para SOR por fuerza bruta.
% Prueba valores de w entre 0.01 y 1.99,
% y devuelve el que minimiza la cantidad de iteraciones.
%
% Entradas:
%   A     : matriz de coeficientes
%   b     : vector de terminos independientes
%   x0    : estimacion inicial
%   tol   : tolerancia para el criterio de parada de SOR
%   maxit : numero maximo de iteraciones para cada prueba
% Salidas:
%   w_opt : valor de w que minimizo las iteraciones
function [w_opt] = wOptimo(A, b, x0, tol, maxit)

  % Paso para barrer w (modificar segun precision deseada)
  paso = 0.05;

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
