function [t,y] = back_euler(f, dfdy, a, b, y0, N)
tol = 1e-9;
kmax=100;
h = (b-a)/N;
t = linspace(a,b,N+1)';
y=0*t;  %genera un vector de ceros de tamanio N+1
y(1) = y0;
	for n=1:N
		yi=y(n);
		k=1;
		fn = f(t(n),y(n));
		while(k<kmax)
			g = yi - y(n) - h*fn;
			dg = 1-h*dfdy(t(n+1),yi);
			y(n+1) = yi - g/dg;
			if(abs(y(n+1)-yi)<tol)
				break;
			endif
			k+=1;
			yi=y(n+1);
		endwhile
	endfor
endfunction
