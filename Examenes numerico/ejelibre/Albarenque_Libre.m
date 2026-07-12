format long;
xx = linspace(0,30,100);
c1 = 1100;
c2 = 900;
d1 = @(x) sqrt(x.^2 + 5^2);
d2 = @(x) sqrt((30-x).^2 + 5^2);
I = @(x) c1./((d1(x)).^2) + c2./((d2(x)).^2) - 10;
plot(xx,I(xx));
[p,h,it] = Biseccion(I,0,15,5000,0.5e-6);
p

[p,h,it] = Biseccion(I,15,30,5000,0.5e-6);
p