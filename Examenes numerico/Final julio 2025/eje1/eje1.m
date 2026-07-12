u = 0.3;
m=1;
g = 9.8;
k = 50;
tita = pi/6;
Fr = @(x)   (x>0)*-1*(u*m*g*cos(tita)) + (x<0)*(u*m*g*cos(tita)) + (x==0)*0;
f = @(t,x)  [x(2) ; -k/m*x(1) + 1/m*Fr(x(2)) - g*sin(tita) ];
x0 = [0.5 0];
[t,x] = rk4(f,[0 1],x0 , 200 );
x(end,1)
x(end,2)

%x = 0.1947 y x'<0 entonces baja
[t,x] = rk4(f,[0 5],x0 , 1000);

plot(t,x(:,2))
i=2;
while(x(i,2)*x(i+1,2)>0)
    i++;
endwhile
i
x(i,1)
t(i)


plot(t,x(:,2))

i=530;
while(x(i,2)*x(i+1,2)>0)
    i++;
endwhile
i
x(i,1)
t(i)
