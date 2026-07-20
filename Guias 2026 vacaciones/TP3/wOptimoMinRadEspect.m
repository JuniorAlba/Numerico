% Busca el w optimo para SOR minimizando el radio espectral
% de la matriz de iteracion de SOR.
%
% La matriz de iteracion de SOR es:
%   T_SOR = (D + w*L)^(-1) * ((1-w)*D - w*U)
% donde D = diag(A), L = tril(A,-1), U = triu(A,1)
%
% Entradas:
%   A        : matriz de coeficientes
%   decimales: cantidad de decimales correctos deseados para w (ej: 3)
% Salidas:
%   w_opt    : valor de w que minimiza el radio espectral
function [w_opt] = wOptimoMinRadEspect(A, decimales)

  % Calculamos el paso a partir de los decimales (ej: 3 -> 0.001)
  paso = 10^(-decimales);

  % Rango de w a probar (SOR requiere 0 < w < 2)
  w_vec = 0.01 : paso : 1.99;

  % Descomponemos A = D + L + U
  D = diag(diag(A));
  L = tril(A, -1);
  U = triu(A, 1);

  % Guardamos el radio espectral para cada w
  radios = zeros(size(w_vec));

  for k = 1:length(w_vec)
    w = w_vec(k);
    % Matriz de iteracion de SOR
    T_sor = inv(D + w*L) * ((1-w)*D - w*U);
    % Radio espectral = mayor autovalor en modulo
    radios(k) = max(abs(eig(T_sor)));
  endfor

  % El w optimo es el que tiene menor radio espectral
  [~, idx] = min(radios);
  w_opt = w_vec(idx);

endfunction
