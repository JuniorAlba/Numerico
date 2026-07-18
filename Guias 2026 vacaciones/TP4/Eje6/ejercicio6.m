clear all; clc;
addpath('..');
a=0.401;
b=42.7e-6;
N = 1000;
T = 300;
p = 3.5e7;
k = 1.3806503e-23;
tol = 1e-12;
f = @(v) (p+a*(N./v).^2).*(v-N*b)-k*N*T;
df = @(v) (-2*a*(N^2)./(v.^3)).*(v-N*b) +(p+a*(N./v).^2);
v = linspace(0,1,100);
figure(1);
hold on;
plot(v,f(v),'r-');
hold off;
figure(2)
plot(v,df(v),'b-');
[v,h,it] = newton(f,df,0.04,500,tol);
v
it
