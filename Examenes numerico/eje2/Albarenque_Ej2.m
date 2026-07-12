%tiempo [s] posicion [m] velocidad [m/s]
format long;

t = [0 3 5 8 12];
x = [0 80 140 220 350];
v = [22 26 28 24 32];

%inciso a
[x,dx,ddx]=funcion_spline(t,x,v(1),v(end));

t_segundo_int =linspace(3,5,4);
x_segundo_int = x(t_segundo_int);
[p]=polyfit(t_segundo_int,x_segundo_int,3);
p

t_tercer_int =linspace(5,8,4);
x_tercer_int = x(t_segundo_int);
[p]=polyfit(t_tercer_int,x_tercer_int,3);
p


%inciso b
xx = linspace(0,12,100);
plot(xx,ddx(xx))
%ceros en [0 4] [6 8] [8 12]
[p1,h,it]=Biseccion(ddx,0,4,1000,0.5e-6);
[p2,h,it]=Biseccion(ddx,6,8,1000,0.5e-6);
[p3,h,it]=Biseccion(ddx,8,12,1000,0.5e-6);
p1
p2
p3
dx(p1)
dx(p2)
dx(p3)

%inciso c
abs(v(end-1) - dx(8))/abs(v(end-1))

%inciso d
[n_x,n_dx,n_ddx]=funcion_spline(t(end-1:end),x(end-1,end),v(end-1),v(end));
abs(v(end-1) - n_dx(8))/abs(v(end-1))
