x = [0 2 6 3 0];
t = [0 1 2 3 4];
y = [0 4 6 2 0];

[x1,dx1,ddx1]=funcion_spline(t,x,0,0);
[y1,dy1,ddy1]=funcion_spline(t,y,0,0);

t1 =linspace(0,4,100);
figure(1);
plot(t1,x1(t1));
figure(2);
plot(t1,y1(t1));
figure(3);
plot(x1(t1),y1(t1));