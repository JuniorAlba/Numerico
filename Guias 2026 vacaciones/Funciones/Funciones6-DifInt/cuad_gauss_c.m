function Q=cuad_gauss_c(f,a,b,L,n)
    % Integra una función usando Cuadratura de Gauss-Legendre compuesta.
    % Esta versión divide [a,b] en L subintervalos y aplica una
    % cuadratura de Gauss de n puntos en cada uno.
    %
    % Entradas:
    %   f: Handle de la función f(x).
    %   a: Extremo inferior de integración.
    %   b: Extremo superior de integración.
    %   L: Cantidad de subintervalos.
    %   n: Cantidad de puntos de Gauss por subintervalo.
    %
    % Salidas:
    %   Q: Aproximación de la integral definida.
    %
    % --- Configuración Interna "Todo Terreno" ---
    medir_tiempo = false;     % true: mide tiempo de ejecución
    opcion_verbose = 0;       % 0: Silencioso, 1: Resumen final
    opcion_warnings = false;  % true: muestra advertencias

    % Opciones de gráficos
    graficar_nodos = false;   % true: muestra nodos de integración
    opcion_grafico_pausa = false;

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    [xg,w]=gauss_xw(n);
    x=linspace(a,b,L+1);
    h=(b-a)/L;
    Q=0;

    for i=1:L
        t=h/2*(xg+1)+x(i);
        Q+=h/2*(w'*f(t));
    endfor

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen Cuadratura de Gauss ---\n");
        printf("Integral aproximada: %.15f\n", Q);
        printf("Subintervalos (L): %d\n", L);
        printf("Puntos de Gauss (n): %d\n", n);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("----------------------------------\n");
    endif

    % --- Gráficos ---
    if (graficar_nodos)
        figure;
        plot(xg, zeros(size(xg)), 'ob');
        grid on;
        title(sprintf('Nodos de Gauss (%d puntos)', n));
        xlabel('Nodo');
        ylabel('');
        if (opcion_grafico_pausa)
            disp("Presione Enter para continuar...");
            pause;
        endif
    endif

endfunction

% --- Observaciones ---
%
% - Implementa Cuadratura de Gauss-Legendre compuesta.
% - Utiliza gauss_xw(n) para obtener nodos y pesos.
% - Requiere conocer la función f(x).
% - No puede utilizarse directamente con tablas de datos.
% - Generalmente alcanza mayor precisión que Newton-Cotes para la misma
%   cantidad de puntos de integración.
% - A mayor L, generalmente aumenta la precisión.
%
% Relación con otros métodos:
%
% - Gauss n=2 <-> Trapecio (2 puntos)
% - Gauss n=3 <-> Simpson 1/3 (3 puntos)
%
% Comparaciones típicas de parcial:
%
%   Igauss2 = cuad_gauss_c(f,a,b,L,2);
%   INC2    = intNCcompuesta(f,a,b,L,2);
%
%   Igauss3 = cuad_gauss_c(f,a,b,L,3);
%   INC3    = intNCcompuesta(f,a,b,L,3);
%
% Normalmente se compara el error obtenido por ambos métodos.
%
% Grado de precisión (Gauss-Legendre):
%
%   n = 1 -> grado 1
%   n = 2 -> grado 3
%   n = 3 -> grado 5
%   n = 4 -> grado 7
%
% En general:
%
%   grado = 2*n - 1
%
% --- Cómo puede aparecer en un ejercicio ---
%
% "Aproxime la integral usando Cuadratura de Gauss."
%
% "Utilice una regla de Gauss-Legendre de n puntos."
%
% "Compare con una regla de Newton-Cotes que utiliza igual cantidad
% de puntos de integración."
%
% "Calcule la integral usando una cuadratura gaussiana."
%
% "Obtenga una aproximación mediante Gauss de 2 puntos."
%
% "Obtenga una aproximación mediante Gauss de 3 puntos."
%
% "Compare el error de Gauss y Newton-Cotes."
%
% --- Traducción de consignas ---
%
% "Cuadratura de Gauss"
%     -> cuad_gauss_c(...)
%
% "Gauss-Legendre"
%     -> cuad_gauss_c(...)
%
% "Regla gaussiana"
%     -> cuad_gauss_c(...)
%
% "Gauss de n puntos"
%     -> usar cuad_gauss_c(...,n)
%
% "Misma cantidad de puntos de integración"
%     -> comparar:
%        n=2 con Trapecio
%        n=3 con Simpson 1/3
