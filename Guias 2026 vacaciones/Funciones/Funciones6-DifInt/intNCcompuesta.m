function Q = intNCcompuesta(f,a,b,L,n)
    % Aproxima una integral definida utilizando la fórmula de
    % Newton-Cotes compuesta.
    %
    % Divide [a,b] en L subintervalos y aplica una regla
    % de Newton-Cotes cerrada de n puntos en cada uno.
    %
    % Entradas:
    %   f: Handle de la función f(x).
    %   a: Extremo inferior de integración.
    %   b: Extremo superior de integración.
    %   L: Cantidad de subintervalos.
    %   n: Cantidad de puntos de la regla Newton-Cotes.
    %
    % Salidas:
    %   Q: Aproximación de la integral definida.
    %
    % --- Configuración Interna "Todo Terreno" ---
    medir_tiempo = false;     % true: mide tiempo de ejecución
    opcion_verbose = 0;       % 0: Silencioso, 1: Resumen final
    opcion_warnings = false;  % true: muestra advertencias

    % Opciones de gráficos
    graficar_subintervalos = false;
    opcion_grafico_pausa = false;

    % --- Inicio del Método ---
    if (medir_tiempo)
        tic_handle = tic;
    endif

    y = linspace(a,b,L+1);
    h = (b-a)/L;

    % calculamos los pesos una sola vez
    w = pesosNC(n);

    Q = 0;
    for i=1:L
        x = linspace(y(i),y(i+1),n);
        fx = f(x);
        Q = Q + h*(fx*w);
    end

    % --- Reporte Final ---
    if (medir_tiempo)
        tiempo_ejecucion = toc(tic_handle);
    endif

    if (opcion_verbose >= 1)
        printf("--- Resumen Newton-Cotes Compuesta ---\n");
        printf("Integral aproximada: %.15f\n", Q);
        printf("Subintervalos (L): %d\n", L);
        printf("Puntos (n): %d\n", n);
        if (medir_tiempo)
            printf("Tiempo: %f s\n", tiempo_ejecucion);
        endif
        printf("--------------------------------------\n");
    endif

    % --- Gráficos ---
    if (graficar_subintervalos)
        figure;
        xx = linspace(a,b,1000);
        plot(xx,f(xx));
        grid on;
        hold on;

        for k=1:length(y)
            xline(y(k),'--r');
        endfor

        title('Subintervalos de Newton-Cotes Compuesta');
        xlabel('x');
        ylabel('f(x)');

        if (opcion_grafico_pausa)
            disp("Presione Enter para continuar...");
            pause;
        endif
    endif

endfunction

%{
 --- Observaciones ---

 - Es una implementación GENERAL de Newton-Cotes compuesta.
 - Utiliza pesosNC(n) para calcular los pesos automáticamente.
 - Requiere conocer la función f(x).
 - No sirve cuando solamente se dispone de datos tabulados.
 - Divide [a,b] en L subintervalos.
 - En cada subintervalo aplica una regla de Newton-Cotes de n puntos.
 - A mayor L, generalmente aumenta la precisión.

 Relación con otros métodos:

   n = 2 -> Trapecio compuesta

   n = 3 -> Simpson 1/3 compuesta

   n = 4 -> Simpson 3/8 compuesta


 La mayoría de las reglas vistas en clase terminan implementándose
 mediante esta función cambiando únicamente el valor de n.

 Comparaciones típicas de parcial:

   intNCcompuesta(f,a,b,L,2)
       -> Trapecio compuesta

   intNCcompuesta(f,a,b,L,3)
       -> Simpson 1/3 compuesta

   cuad_gauss_c(f,a,b,L,2)
       -> Gauss de 2 puntos

   cuad_gauss_c(f,a,b,L,3)
       -> Gauss de 3 puntos

 Normalmente se compara el error entre ambos métodos.

 Dependencias:

   pesosNC(n)

 Esta función NO calcula los pesos.
 Los obtiene mediante pesosNC.

 --- Cómo puede aparecer en un ejercicio ---

 "Aproxime la integral mediante Newton-Cotes."

 "Utilice una fórmula de Newton-Cotes compuesta."

 "Aplique una regla cerrada de Newton-Cotes."

 "Utilice una regla de integración de n puntos."

 "Aproxime la integral utilizando Trapecio compuesta."

 "Aproxime la integral utilizando Simpson compuesta."

 "Compare Newton-Cotes y Gauss."

 "Compare el error utilizando igual cantidad de puntos."

 "Obtenga una aproximación mediante una regla cerrada."

 --- Traducción de consignas ---

 "Trapecio compuesta"
     -> intNCcompuesta(...,2)

 "Trapecio compuesto"
     -> intNCcompuesta(...,2)

 "Regla de 2 puntos"
     -> normalmente n=2

 "Simpson compuesta"
     -> intNCcompuesta(...,3)

 "Simpson 1/3 compuesta"
     -> intNCcompuesta(...,3)

 "Regla de 3 puntos"
     -> normalmente n=3

 "Simpson 3/8"
     -> intNCcompuesta(...,4)

 "Newton-Cotes"
     -> intNCcompuesta(...)

 "Regla cerrada de Newton-Cotes"
     -> intNCcompuesta(...)

 "Misma cantidad de puntos de integración"
     -> comparar:

        n=2 <-> Gauss de 2 puntos

        n=3 <-> Gauss de 3 puntos

 --- Ejemplo 1: Trapecio compuesta ---

 f = @(x) exp(-x.^2);
 Q = intNCcompuesta(f,0,1,10,2);

 --- Ejemplo 2: Simpson compuesta ---

 f = @(x) exp(-x.^2);
 Q = intNCcompuesta(f,0,1,10,3);

 --- Ejemplo 3: Comparación clásica de parcial ---

 f = @(x) x.^2 .* exp(-x);

 INC2 = intNCcompuesta(f,0,1,1,2);
 IGA2 = cuad_gauss_c(f,0,1,1,2);

 INC3 = intNCcompuesta(f,0,1,1,3);
 IGA3 = cuad_gauss_c(f,0,1,1,3);

 Comparar:

 abs(Iexacta - INC2)
 abs(Iexacta - IGA2)

 abs(Iexacta - INC3)
 abs(Iexacta - IGA3)
%}
