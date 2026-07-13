function plotFunction(f, a, b)
% PLOTFUNCTION  Grafica f(x) en [a, b] con detección opcional de raíces.
%   Pensada como primer vistazo rápido antes de un análisis más fino.
%   Las raíces se detectan por cambios de signo y se refinan con fzero.
%
%   --- ADVERTENCIA ---
%   Tener cuidado con las Y que a veces se disparan a números enormes.
%
% Entradas:
%   f - Handle de la función f(x). Debe ser vectorizable (usar operadores .*, ./).
%   a - Extremo izquierdo del intervalo.
%   b - Extremo derecho del intervalo.
%
% Salidas:
%   (ninguna — solo produce una figura)
%
% Ejemplo de uso: ver al final del archivo

  % --- Configuración interna ---
  n           = 500;    % puntos del linspace para graficar y escanear raíces
  figNumber   = 1;      % número de figura (figure(figNumber))
  marcarRaices = true;  % true: detecta y marca raíces con un círculo rojo
  TOL_RAIZ    = 1e-7;   % tolerancia para fzero en el refinamiento de cada raíz
  TOL_MERGE   = (b-a) * 1e-4;  % dos raíces más cerca que esto se fusionan en una

  % --- Evaluar ---
  xx = linspace(a, b, n);
  yy = zeros(1, n);
  for k = 1:n
    try
      yy(k) = f(xx(k));
    catch
      yy(k) = NaN;  % si f explota en un punto, no rompe todo
    end
  endfor

  % --- Graficar ---
  figure(figNumber);
  clf;
  plot(xx, yy, 'b-', 'LineWidth', 1.5);
  hold on;
  plot([a, b], [0, 0], 'k-', 'LineWidth', 0.8);  % eje x
  grid on;
  xlabel('x');
  ylabel('f(x)');
  title(sprintf('f(x) en [%.4g, %.4g]', a, b));

  % --- Detección y marcado de raíces ---
  if marcarRaices

    raices = [];

    % escaneo de cambios de signo entre pares de puntos consecutivos
    for k = 1:n-1
      yi = yy(k);
      yj = yy(k+1);

      % si alguno es NaN o cero exacto, saltar (fzero lo maneja mal)
      if isnan(yi) || isnan(yj)
        continue;
      endif

      if yi == 0
        raices(end+1) = xx(k);
        continue;
      endif

      if sign(yi) ~= sign(yj)
        % hay un cruce de signo → refinar con fzero en ese subintervalo
        try
          r = fzero(f, [xx(k), xx(k+1)], optimset('TolX', TOL_RAIZ, 'Display', 'off'));
          raices(end+1) = r;
        catch
          % fzero puede fallar si f tiene una discontinuidad (ej: tan(x))
          % en ese caso ignoramos ese cruce
        end
      endif
    endfor

    % fusionar raíces que quedaron muy juntas (cruces dobles o artefactos)
    if ~isempty(raices)
      raices = sort(raices);
      raices_limpias = raices(1);
      for k = 2:length(raices)
        if abs(raices(k) - raices_limpias(end)) > TOL_MERGE
          raices_limpias(end+1) = raices(k);
        endif
      endfor

      % marcar con círculo rojo en y=0
      plot(raices_limpias, zeros(size(raices_limpias)), ...
           'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

      printf('Raíces encontradas (%d):\n', length(raices_limpias));
      for k = 1:length(raices_limpias)
        printf('  x = %.10f  |  f(x) = %.2e\n', raices_limpias(k), f(raices_limpias(k)));
      endfor
    else
      printf('No se detectaron raíces en [%.4g, %.4g].\n', a, b);
    endif

  endif

  hold off;

endfunction

%{
% =========================================================
% EJEMPLO DE USO — seleccionar bloque y presionar F9
% =========================================================

% --- Caso 1: f(x) = ln(x²+1) - e^(x/2)*cos(πx) - 1.106 ---
% Tiene múltiples raíces en [-6, 6] (7 raíces)
f1 = @(x) log(x.^2 + 1) - exp(x/2) .* cos(pi*x) - 1.106;
plotFunction(f1, -6, 6);

% --- Caso 2: z(t) = 0.04*sqrt(a+t)*(1-t) - t*sqrt(3a), a = 19.072954 ---
% Tiene una raíz cerca de t = 0.022585
a = 19.072954;
z = @(t) 0.04*sqrt(a + t).*(1 - t) - t.*sqrt(3*a);
plotFunction(z, -0.5, 1);

% Resultado esperado:
%   f1 → 7 raíces en [-6, 6], la más cercana a x=-1 es ≈ -0.8378265
%   z  → 1 raíz visible cerca de t ≈ 0.022585
% =========================================================
%}


%cifras exactas-> siempre de la mano de la tolerancia, si la tolerancia es de
%1e-7 entonces hay que poner 7 cifras exactas, los ceros antes de la coma no
%cuentan asi que si tenes que poner en total 8 numeros, el 0.(7 decimales) si
%tenes cualquier numero delante por ejm 1.454651 ahi tiene 7 cifras 1.(6decimales)
