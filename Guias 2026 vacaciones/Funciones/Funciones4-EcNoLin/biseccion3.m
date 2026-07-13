function [p, rh, it, E_rel, tiempo] = biseccion3(f, a, b, maxit, tol)
    % Resuelve f(x)=0 usando Bisección (Versión Cátedra).
    % Esta versión calcula el error relativo (E_rel) y el
    % error 'rh' (max(abs([fp, p-a]))) en cada paso.
    % La firma de la función NO se modifica.
    %
    % Entradas:
    %   (Ver biseccion.m)
    %
    % Salidas:
    %   p: Aproximación de la raíz.
    %   rh: Historial de error (tipo max(abs([fp, p-a])))
    %   it: Número de iteraciones.
    %   E_rel: Historial de error relativo.
    %   tiempo: Tiempo de ejecución.

    % --- Configuración Interna ---
    opcion_verbose = 1;      % 0: Silencioso, 1: Resumen final
    opcion_warnings = true;  % true: Muestra advertencia si no cumple TVM

    % --- Inicio del Método ---
    tic_handle = tic;

    fa = f(a);
    fb = f(b);
    if sign(fa) * sign(fb) > 0
        if (opcion_warnings)
            printf("ADVERTENCIA (Bisección 3): No se cumple la regla de los signos (TVM).\n");
        endif
        p = NaN; rh = [NaN]; it = 0; E_rel = [NaN]; tiempo = toc(tic_handle);
        return;
    endif

    it = 0;
    rh = [];
    E_rel = [];
    p = a; % Definimos un primer valor de p

    while (it < maxit)
        it = it + 1;
        pold = p;
        p = a + (b - a) / 2; % calculamos p_i
        fp = f(p);

        % Calculamos error relativo
        E_rel(it) = abs((p - pold)) / (abs(p) + eps);

        if (sign(fp) * sign(fb) < 0)
            rh(it) = max(abs([fp, b - p]));
            fa = fp;
            a = p;
        else
            rh(it) = max(abs([fp, p - a]));
            fb = fp;
            b = p;
        endif

        % Criterio de parada (basado en Error Relativo, como el original)
        if (E_rel(it) < tol && it > 1)
            break;
        endif
    endwhile

    tiempo = toc(tic_handle);

    % --- Reporte Final ---
    if (opcion_warnings && it == maxit && E_rel(it) >= tol)
        printf("ADVERTENCIA (Bisección 3): El método no convergió en %d iteraciones.\n", maxit);
        printf("  Error relativo final: %e (Tolerancia: %e)\n", E_rel(it), tol);
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen Bisección 3 (Cátedra) ---\n");
        printf("Raíz encontrada: %-15.10f\n", p);
        printf("Iteraciones: %d / %d\n", it, maxit);
        printf("Error Relativo: %e\n", E_rel(it));
        printf("Tiempo: %f s\n", tiempo);
        printf("-------------------------------------\n");
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
% % (Usamos el mismo caso del Parcial 1)
% f1 = @(x) log(x.^2 + 1) - exp(x/2) .* cos(pi*x) - 1.106;
% a1 = -1;
% b1 = 0;
% tol1 = 1e-7; % Tolerancia para el error relativo
% maxit1 = 100;
%
% [p1, rh1, it1, Erel1, t1] = biseccion3(f1, a1, b1, maxit1, tol1);

% --- Resultado Esperado (Ejemplo 1) ---
% --- Resumen Bisección 3 (Cátedra) ---
% Raíz encontrada: -0.8378265500
% Iteraciones: 24 / 100
% Error Relativo: 7.114199e-08
% Tiempo: ... s
% -------------------------------------
