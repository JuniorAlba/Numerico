function [x, w] = gauss_xw(n)
    % Genera los nodos (abscisas) y pesos de la Cuadratura
    % de Gauss-Legendre.
    % Esta es la función base utilizada por los métodos de
    % integración de Gauss.
    %
    % Entradas:
    %   n: Cantidad de puntos de integración.
    %
    % Salidas:
    %   x: Vector de nodos (abscisas).
    %   w: Vector de pesos.
    %
    % --- Configuración Interna "Todo Terreno" ---
    medir_tiempo = false;
    opcion_verbose = 0;       % 0: Silencioso, 1: Resumen final
    mostrar_tabla = false;    % true: imprime nodos y pesos

    % Opciones de gráficos
    graficar_nodos = false;
    opcion_grafico_pausa = false;

    % --- Observaciones ---
    %
    % - NO integra.
    % - NO aproxima una integral.
    % - Solamente genera nodos y pesos.
    % - Es utilizada internamente por cuad_gauss_c y
    %   cuad_gauss_doble.
    %
    % Grado de precisión:
    %
    %   n = 1 -> grado 1
    %   n = 2 -> grado 3
    %   n = 3 -> grado 5
    %   n = 4 -> grado 7
    %
    % Fórmula general:
    %
    %   grado = 2*n - 1
    %
    % --- Cómo puede aparecer en un ejercicio ---
    %
    % "Obtenga los nodos y pesos."
    %
    % "Determine las abscisas y pesos de Gauss."
    %
    % "Construya una cuadratura de Gauss de n puntos."
    %
    % "¿Cuáles son los nodos utilizados por Gauss?"
    %
    % "¿Cuáles son los pesos asociados?"
    %
    % --- Traducción de consignas ---
    %
    % "nodos"
    %     -> x
    %
    % "abscisas"
    %     -> x
    %
    % "pesos"
    %     -> w
    %
    % "Gauss-Legendre de n puntos"
    %     -> gauss_xw(n)
    %
    % Ejemplo:
    %
    %   [x,w] = gauss_xw(3)
    %
    % Devuelve:
    %
    %   x -> nodos
    %   w -> pesos

        % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    x = zeros(n,1);
    w = x;
    m = (n+1)/2;

    for ii=1:m
        z = cos(pi*(ii-.25)/(n+.5)); % estimado inicial
        z1 = z+1;

        while abs(z-z1)>eps
            p1 = 1;
            p2 = 0;

            for jj = 1:n
                p3 = p2;
                p2 = p1;
                p1 = ((2*jj-1)*z*p2-(jj-1)*p3)/jj;
            endfor

            pp = n*(z*p1-p2)/(z^2-1);

            z1 = z;
            z = z1-p1/pp;
        endwhile

        x(ii) = -z;
        x(n+1-ii) = z;

        w(ii) = 2/((1-z^2)*(pp^2));
        w(n+1-ii) = w(ii);
    endfor

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (mostrar_tabla)
        printf("\n");
        printf(" i        x(i)               w(i)\n");
        printf("---------------------------------------\n");
        for k = 1:n
            printf("%2d   % .12f   %.12f\n", k, x(k), w(k));
        endfor
        printf("---------------------------------------\n");
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen Gauss XW ---\n");
        printf("Cantidad de puntos: %d\n", n);
        printf("Grado de precisión: %d\n", 2*n-1);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("------------------------\n");
    endif

    % --- Gráficos ---
    if (graficar_nodos)
        figure;
        stem(x,w);
        grid on;
        title(sprintf('Nodos y Pesos de Gauss (%d puntos)',n));
        xlabel('Nodo');
        ylabel('Peso');

        if (opcion_grafico_pausa)
            disp("Presione Enter para continuar...");
            pause;
        endif
    endif

endfunction

% --- Ejemplo 1: Obtener nodos y pesos para Gauss de 2 puntos ---
%
% [x,w] = gauss_xw(2)
%
% Resultado esperado aproximado:
%
% x =
%   -0.5773502692
%    0.5773502692
%
% w =
%    1
%    1

% --- Ejemplo 2: Obtener nodos y pesos para Gauss de 3 puntos ---
%
% [x,w] = gauss_xw(3)
%
% Resultado esperado aproximado:
%
% x =
%   -0.7745966692
%    0.0000000000
%    0.7745966692
%
% w =
%    0.5555555556
%    0.8888888889
%    0.5555555556

% --- Resultado Esperado (Conceptual) ---
%
% Gauss de 2 puntos:
%   grado de precisión = 3
%
% Gauss de 3 puntos:
%   grado de precisión = 5
%
% Recordatorio:
%
%   gauss_xw NO integra.
%
%   gauss_xw -> genera nodos y pesos
%
%   cuad_gauss_c -> utiliza esos nodos y pesos para integrar
%
% Relación típica de examen:
%
%   [x,w] = gauss_xw(3);
%
%   % luego
%
%   I = cuad_gauss_c(f,a,b,L,3);
%
% Pregunta típica:
%
%   "Obtenga los nodos y pesos de Gauss."
%          ↓
%       gauss_xw
%
%   "Calcule la integral mediante Gauss."
%          ↓
%      cuad_gauss_c
