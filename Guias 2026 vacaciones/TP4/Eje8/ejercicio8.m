clear all; clc;
addpath('..');
format long;
f = @(t) ((t+1/3).^3+1/3).*exp(-t);
g = @(t) ((t+1/3).^3+1/3).*exp(-t)-3/2;
df = @(t) (3*(t+1/3).^2).*exp(-t) - ((t+1/3).^3+1/3).*exp(-t);
ddf = @(t) (6*(t+1/3).^1).*exp(-t) - (6*(t+1/3).^2).*exp(-t) + ((t+1/3).^3+1/3).*exp(-t);
dddf = @(t) (6 - 12*(t+1/3) + 3*(t+1/3).^2).*exp(-t) - ddf(t);
tol_final = 1e-5;
kmax = 500;

nul = @(t) t*0;
t = linspace(0,10,100);
figure(1)
hold on;
plot(t,f(t),'r-');
plot(t,nul(t),'b-');
plot(t,df(t),'g-');
plot(t,ddf(t),'y-');

display("--------Inciso a--------")
[t,h,it]= newton(g,df,1.75,kmax,tol_final);
t
it
[t,h,it]= newton(g,df,4.2,kmax,tol_final);
t
it

display("--------Inciso b--------")
[t,h,it]= newton(df,ddf,1.5,kmax,tol_final);
t
it



display("--------Inciso c--------")
[t,h,it]= newton(ddf,dddf,1,kmax,tol_final);
t
it














