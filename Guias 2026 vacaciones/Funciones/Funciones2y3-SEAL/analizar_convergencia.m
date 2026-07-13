function analizar_convergencia(A, b, x0, tol, maxit)
    % Realiza un análisis de convergencia "Todo en Uno" para una matriz A.
    % Calcula radios espectrales (Jacobi, GS) y busca el w-óptimo para SOR.
    % Esta función es autocontenida: utiliza sub-funciones (funciones locales)
    % para no depender de la configuración (verbose/gráficos) de
    % las funciones principales del path.
    %
    % Entradas:
    %   A: Matriz cuadrada de coeficientes.
    %   b: Vector de términos independientes.
    %   x0: Vector de estimación inicial.
    %   tol: Tolerancia (para wOptimo).
    %   maxit: Máx. iteraciones (para wOptimo).
    %
    % Salidas:
    %   (Ninguna. Imprime un reporte en consola).

    % --- Configuración Interna ---
    medir_tiempo = false;   % true: mide el tiempo de ejecución, false: no mide

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    [n, m] = size(A);
    printf("--- Análisis de Convergencia (Matriz %dx%d) ---\n", n, m);
    printf(" (Tol: %e, MaxIt: %d)\n", tol, maxit);
    printf("--------------------------------------------------\n");

    try
        % 1. Jacobi
        rho_j = RadioEspectral_ac(A, 'ja', []);
        printf("1. Jacobi (ja):\n");
        printf("   Radio Espectral: %f %s\n", rho_j, ...
               ifelse(rho_j < 1, "(Converge)", "(DIVERGE)"));

        % 2. Gauss-Seidel
        rho_gs = RadioEspectral_ac(A, 'gs', []);
        printf("2. Gauss-Seidel (gs):\n");
        printf("   Radio Espectral: %f %s\n", rho_gs, ...
               ifelse(rho_gs < 1, "(Converge)", "(DIVERGE)"));

        % 3. SOR (con w óptimo)
        printf("3. SOR (Buscando w óptimo...)\n");
        w_opt = wOptimo_ac(A, b, x0, tol, maxit);

        rho_sor = RadioEspectral_ac(A, 'sor', w_opt);
        printf("   w Óptimo encontrado: %f\n", w_opt);
        printf("   Radio Espectral (w_opt): %f %s\n", rho_sor, ...
               ifelse(rho_sor < 1, "(Converge)", "(DIVERGE)"));

        % 4. Conclusión
        printf("--------------------------------------------------\n");
        printf("Conclusión del Análisis:\n");

        rhos = [rho_j, rho_gs, rho_sor];
        metodos = {"Jacobi", "Gauss-Seidel", "SOR (w_opt)"};

        [rho_min, idx_min] = min(rhos);

        if (rho_min >= 1)
            printf("   NINGÚN método converge (todos los rho >= 1).\n");
        else
            printf("   Método más rápido: %s (rho = %f)\n", ...
                   metodos{idx_min}, rho_min);
        endif

    catch err
        printf("\nERROR durante el análisis: %s\n", err.message);
        printf("Asegúrate que Octave soporta sub-funciones correctamente.\n");
    end

    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
        printf("--------------------------------------------------\n");
        printf("Tiempo total del análisis: %f s\n", tiempo_ejecucion);
    endif

endfunction

% --- Ejemplo de Ejecución (Seleccionar y presionar F9) ---
%
% % NOTA: Este script ya no requiere editar otros archivos.
% % Llama a sus propias versiones "silenciosas" de las funciones.
%
% % Caso 1: Matriz 40x40 (Ev. Continua 1 2025)
% n = 40;
% A1 = diag(2*ones(n,1), 0) + diag(-1*ones(n-1,1), 1) + diag(-1*ones(n-1,1), -1);
% b1 = zeros(n,1);
% x0_1 = zeros(n,1);
% tol1 = 1e-5;
% maxit1 = 100;
%
% analizar_convergencia(A1, b1, x0_1, tol1, maxit1);
%
% % Caso 2: Matriz 5x5 (Parcial 1 2025)
% A2 = [2 0 1 0 -2; 1 1 1 1 -1; -2 2 2 -2 1; -1 0 1 2 2; -1 2 2 -1 2];
% b2 = [4; 0; 1; 3; -1];
% x0_2 = [0; 0; 0; 0; 0];
% tol2 = 1e-4;
% maxit2 = 100;
%
% analizar_convergencia(A2, b2, x0_2, tol2, maxit2);

% --- Resultado Esperado (Ejemplo 1) ---
% --- Análisis de Convergencia (Matriz 40x40) ---
%  (Tol: 1.000000e-05, MaxIt: 100)
% --------------------------------------------------
% 1. Jacobi (ja):
%    Radio Espectral: 0.997066 (Converge)
% 2. Gauss-Seidel (gs):
%    Radio Espectral: 0.994140 (Converge)
% 3. SOR (Buscando w óptimo...)
%    w Óptimo encontrado: 1.857788
%    Radio Espectral (w_opt): 0.857788 (Converge)
% --------------------------------------------------
% Conclusión del Análisis:
%    Método más rápido: SOR (w_opt) (rho = 0.857788)
% --------------------------------------------------
% Tiempo total del análisis: ... s

% --- Resultado Esperado (Ejemplo 2) ---
% --- Análisis de Convergencia (Matriz 5x5) ---
%  (Tol: 1.000000e-04, MaxIt: 100)
% --------------------------------------------------
% 1. Jacobi (ja):
%    Radio Espectral: 0.828243 (Converge)
% 2. Gauss-Seidel (gs):
%    Radio Espectral: 1.616208 (DIVERGE)
% 3. SOR (Buscando w óptimo...)
%    w Óptimo encontrado: 0.810000
%    Radio Espectral (w_opt): 0.491267 (Converge)
% --------------------------------------------------
% Conclusión del Análisis:
%    Método más rápido: SOR (w_opt) (rho = 0.491267)
% --------------------------------------------------
% Tiempo total del análisis: ... s


% ##################################################################
% --- SUB-FUNCIONES (SILENCIOSAS) ---
% ##################################################################
% (Las sub-funciones no se modificaron, son las mismas de antes)
% ##################################################################

% --- Dependencia 1: DescomponerMatriz (Silenciosa) ---
function [L, D, U] = DescomponerMatriz_ac(A)
    L = tril(A, -1);
    U = triu(A, 1);
    D = diag(diag(A));
endfunction

% --- Dependencia 2: esDefinidaPositiva (Silenciosa) ---
function r = esDefinidaPositiva_ac(A)
    if ~isequal(A, A')
        r = false;
        return;
    endif

    try
      autovalores = eig(A);
    catch
      r = false; % Falla el cálculo de autovalores
      return;
    end

    if any(autovalores <= 0)
        r = false;
        return;
    endif
    r = true;
endfunction

% --- Dependencia 3: esTridiagonal (Silenciosa) ---
function r = esTridiagonal_ac(A)
    [n, m] = size(A);
    if n != m
        r = false;
        return;
    endif
    [fila, col] = find(A);
    r = all(abs(fila - col) <= 1);
endfunction

% --- Dependencia 4: RadioEspectral (Silenciosa) ---
function [rhoA] = RadioEspectral_ac(A, metodo, w)
    % Llama a la descomposición local
    [L, D, U] = DescomponerMatriz_ac(A);

    if strcmp(metodo, "ja")
        T = -inv(D) * (L + U);
    elseif strcmp(metodo, "gs")
        T = -inv(D + L) * U;
    elseif strcmp(metodo, "sor")
        T = -inv(D + w * L) * ((w - 1) * D + w * U);
    else
        error("Sub-función: Método no reconocido.");
    endif

    rhoA = max(abs(eig(T)));
endfunction

% --- Dependencia 5: SOR (Silenciosa, devuelve solo iteraciones) ---
function [it] = sor_ac(A, b, x0, maxit, tol, w)
    n = length(b);
    it = 0;
    x = x0;

    while (it < maxit)
        for i = 1:n
            x(i) = (1 - w) * x0(i) + w * (b(i) - A(i, 1:i-1) * x(1:i-1) - A(i, i+1:n) * x0(i+1:n)) / A(i, i);
        endfor

        % Usa error tipo 1 (Relativo Inf) hardcodeado
        err = norm(x - x0, 'inf') / (norm(x, 'inf') + eps);

        it = it + 1;

        if (err < tol)
            break;
        endif

        x0 = x;
    endwhile
    % Devuelve 'it' (si no convergió, 'it' será == maxit)
endfunction

% --- Dependencia 6: wOptimo (Silenciosa) ---
function [w] = wOptimo_ac(A, b, x0, tol, maxit)
    % Llama a las dependencias locales (_ac)
    try
        if (esDefinidaPositiva_ac(A) && esTridiagonal_ac(A))
            rho_j = RadioEspectral_ac(A, 'ja', []);
            w = 2 / (1 + sqrt(1 - (rho_j^2)));
            return;
        endif
    catch
        % (Falla el método teórico, pasa a fuerza bruta)
    end

    % Fuerza Bruta (100 pasos hardcodeados)
    w_range = linspace(0.01, 1.99, 100);
    it_hist = zeros(size(w_range));
    it_hist(:) = maxit + 1;

    for j = 1:length(w_range)
        % Llama a sor local
        it_hist(j) = sor_ac(A, b, x0, maxit, tol, w_range(j));
    endfor

    [it_min, p_min] = min(it_hist);
    w = w_range(p_min);
endfunction
