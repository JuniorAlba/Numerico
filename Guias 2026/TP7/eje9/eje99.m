clear all; clc;
clear all; clc;
f = @(t,x) [x(2) ; x(3) ; -4*sin(t)-2*cos(t)-4*x(3) -5*x(2)-2*x(1)];
x0 = [1 0 -1]';
inter = [0 2.5];
L=10;
itmax=100;
sol_exacta = cos(2.5);
err = [1 ];
i=1;
while(i<itmax && err(i)>=1*10^(-6))
    L = 10*i;
    [t1,x1] = rk4(f,inter,x0,L);
    err = [err ; abs(sol_exacta - x1(end,1))/abs(sol_exacta)];
    i++;
endwhile