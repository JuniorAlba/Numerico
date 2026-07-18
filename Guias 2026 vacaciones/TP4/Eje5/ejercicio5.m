clear all; clc;
addpath('..');
g=@(x) sqrt(x.^4 + x.^2-2*x+1);
f = @(x) 4*x.^3 + 2*x-2;
df = @(x) 12*x.^2 + 2;
nul = @(x) 0*x;
x = linspace(-10,10,100);
figure(1);
hold on;
plot(x,f(x),'r-');
plot(x,nul(x),'b-');
hold off;
figure(2)
plot(x,g(x),'g-');
[x,h,it] = newton(f,df,0,500,1e-4);
x
it

