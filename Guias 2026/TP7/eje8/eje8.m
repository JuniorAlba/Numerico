f = @(t,x) [x(1)*(3 - 0.002*x(2)) ; -x(2)*(0.5-0.0006*x(1))];
%x1 es la presa y x2 es depredador
x0 = [1600; 800];
inter = [0 12];
L = 400;
[t,x] = rk4(f,inter,x0,L);

figure(1)
plot(t,x(:,1))

figure(2)
plot(t,x(:,2))
figure(3)
plot(x(:,1),x(:,2))