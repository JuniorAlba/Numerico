clear all; clc;
addpath('..');
format long;
f = @(x) x.*(log(x+3)-17)-1;
k=1;
while true
  if sign(f(0))*sign(f(k))<0
    break;
  endif
  k = 2*k;
endwhile
tol = 1e2;
[x,h,it] = biseccion(f,0,k,500,tol);
x0=x
it

tol = 1e-12;
df = @(x) (log(x+3)-17)+x.*(1./(x+3));
[x2,h,it] = newton(f,df,x0,500,tol);
double(x2)
it

