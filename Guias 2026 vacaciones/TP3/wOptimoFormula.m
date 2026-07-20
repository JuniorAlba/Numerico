% Calcula el w optimo para SOR usando la formula teorica.
% SOLO VALIDO si la matriz A es tridiagonal y definida positiva.
%
% Formula:  w_opt = 2 / (1 + sqrt(1 - rho_J^2))
%
% donde rho_J es el radio espectral de la matriz de iteracion de Jacobi:
%   T_J = -D^(-1) * (L + U)
%
% Entrada:
%   A : matriz de coeficientes (debe ser tridiagonal y def. positiva)
% Salida:
%   w_opt : valor optimo de w para SOR
function [w_opt] = wOptimoFormula(A)

  % --- Verificacion de hipotesis ---

  % 1. Verificar que sea tridiagonal:
  %    Fuera de las 3 diagonales (principal, superior e inferior) todo debe ser 0
  n = length(A);
  es_tridiagonal = true;
  for i = 1:n
    for j = 1:n
      if abs(i - j) > 1 && A(i,j) ~= 0
        es_tridiagonal = false;
        break;
      end
    end
    if ~es_tridiagonal, break; end
  end

  % 2. Verificar que sea simetrica: A == A'
  es_simetrica = norm(A - A', inf) < 1e-10;

  % 3. Verificar que sea definida positiva: todos los autovalores > 0
  autovalores = eig(A);
  es_def_positiva = all(autovalores > 0);

  % --- Reportar resultado de las verificaciones ---
  if ~es_tridiagonal
    disp('ADVERTENCIA: La matriz NO es tridiagonal.');
  end
  if ~es_simetrica
    disp('ADVERTENCIA: La matriz NO es simetrica.');
  end
  if ~es_def_positiva
    disp('ADVERTENCIA: La matriz NO es definida positiva.');
  end

  if ~es_tridiagonal || ~es_def_positiva
    error('No se cumplen las hipotesis. Usar wOptimoMinRadEspect(A, decimales) en su lugar.');
  end

  disp('Hipotesis verificadas: la matriz es tridiagonal, simetrica y definida positiva.');

  % --- Calculo del w optimo ---

  % Descomponemos A = D + L + U
  D = diag(diag(A));
  L = tril(A, -1);
  U = triu(A, 1);

  % Matriz de iteracion de Jacobi: T_J = -D^(-1) * (L + U)
  T_J = -inv(D) * (L + U);

  % Radio espectral de Jacobi = mayor autovalor en modulo
  rho_J = max(abs(eig(T_J)));

  % Formula del w optimo
  w_opt = 2 / (1 + sqrt(1 - rho_J^2));

endfunction
