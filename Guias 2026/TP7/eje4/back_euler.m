function [t,y] = back_euler(f, dfdy, a, b, y0, N)
    tol = 1e-9;
    kmax=100;
    h = (b-a)/N;
    t = linspace(a,b,N+1)';
    y = 0*t;
    y(1) = y0;

    for n=1:N
        yi = y(n); % Valor inicial para Newton (semilla)
        k = 1;

        % ELIMINAMOS: fn = f(t(n),y(n)); porque eso es Forward Euler

        while(k < kmax)
            % CORRECCIÓN: Evaluamos f en el tiempo futuro (n+1) y en la estimación actual (yi)
            fi = f(t(n+1), yi);

            % La función raíz g(yi) = yi - y_anterior - h * f(t_futuro, yi)
            g = yi - y(n) - h * fi;

            % La derivada sigue igual (ya la tenías bien con t(n+1))
            dg = 1 - h * dfdy(t(n+1), yi);

            y_next = yi - g/dg; % Paso de Newton

            if(abs(y_next - yi) < tol)
                yi = y_next; % Actualizamos antes de salir
                break;
            endif

            k += 1;
            yi = y_next;
        endwhile
        y(n+1) = yi; % Guardamos el resultado convergido
    endfor
endfunction