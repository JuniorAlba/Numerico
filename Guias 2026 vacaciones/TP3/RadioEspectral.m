function [rhoA] = RadioEspectral(A, metodo, w)
    % Calcula el radio espectral de la matriz de iteración (T)
    % para los métodos Jacobi (ja), Gauss-Seidel (gs) o SOR (sor).
    %
    % Entradas:
    %   A: Matriz cuadrada del sistema.
    %   metodo: String 'ja', 'gs' o 'sor'.
    %   w: Parámetro de relajación (solo necesario para 'sor').
    %
    % Salidas:
    %   rhoA: Radio espectral (max(abs(eig(T)))).
    %
    % Dependencias:
    %   Requiere 'DescomponerMatriz.m' en el path.

    % --- Configuración Interna ---
    medir_tiempo = false;   % true: mide el tiempo de ejecución, false: no mide
    opcion_verbose = 0;    % 0: Silencioso, 1: Muestra resultado y tiempo

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    % 1. Descomponer la matriz A
    % (Se asume que DescomponerMatriz.m existe y es la del Lote 1)
    try
        [L, D, U] = DescomponerMatriz(A);
    catch err
        error("Error llamando a DescomponerMatriz(A). Asegúrate que esté en el path. \nError original: %s", err.message);
    end % <-- ¡CORREGIDO! (Antes decía 'endif')

    % 2. Seleccionar el método y calcular T
    if strcmp(metodo, "ja")
        % T_j = -inv(D) * (L + U)
        T = -inv(D) * (L + U);
        metodo_str = "Jacobi (ja)";

    elseif strcmp(metodo, "gs")
        % T_gs = -inv(D + L) * U
        T = -inv(D + L) * U;
        metodo_str = "Gauss-Seidel (gs)";

    elseif strcmp(metodo, "sor")
        if (nargin < 3 || isempty(w))
             error("Para el método 'sor', se debe proveer un valor de 'w'.");
        endif
        % T_sor = -inv(D+w*L)*((w-1)*D+w*U)
        T = -inv(D + w * L) * ((w - 1) * D + w * U);
        metodo_str = sprintf("SOR (w=%f)", w);

    else
        error("Método no reconocido. Usa 'ja', 'gs' o 'sor'.");
    endif

    % 3. Calcular el radio espectral (autovalor de mayor magnitud)
    rhoA = max(abs(eig(T)));

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_verbose >= 1)
        printf("Radio Espectral (%s): %f.", metodo_str, rhoA);
        if (rhoA < 1)
            printf(" (Converge)\n");
        else
            printf(" (DIVERGE)\n");
        endif
        if (medir_tiempo)
            printf("  Tiempo de cálculo: %f s\n", tiempo_ejecucion);
        endif
    endif

endfunction

% --- Ejemplo 1: Matriz de Evaluación Continua 1 (2025) (Seleccionar y presionar F9) ---
% % NOTA: Requiere 'DescomponerMatriz.m' en el path.
%
% n = 40;
% A_examen = diag(2*ones(n,1), 0) + diag(-1*ones(n-1,1), 1) + diag(-1*ones(n-1,1), -1);
% w_examen = 1.85;
%
% disp("--- Calculando radios (matriz 40x40) ---")
% rho_j = RadioEspectral(A_examen, "ja", [])
% rho_gs = RadioEspectral(A_examen, "gs", [])
% rho_sor = RadioEspectral(A_examen, "sor", w_examen)

% --- Resultado Esperado (Ejemplo 1) ---
% --- Calculando radios (matriz 40x40) ---
% (Salida de DescomponerMatriz)
% Radio Espectral (Jacobi (ja)): 0.997091. (Converge)
%   Tiempo de cálculo: ... s
% rho_j = 0.99709
% (Salida de DescomponerMatriz)
% Radio Espectral (Gauss-Seidel (gs)): 0.994191. (Converge)
%   Tiempo de cálculo: ... s
% rho_gs = 0.99419
% (Salida de DescomponerMatriz)
% Radio Espectral (SOR (w=1.850000)): 0.896821. (Converge)
%   Tiempo de cálculo: ... s
% rho_sor = 0.89682
