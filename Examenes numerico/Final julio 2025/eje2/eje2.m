format long;
P = [0.985  1.108   1.363   1.631];
V = [25000  22200   18000   15000];
R = 82.05;
T=303;

%inciso a

datos = P.*V.^3./(R*T) - V.^2;
[pol] = polyfit(V,datos,1);
A1 = pol(1)
A2 = pol(2)

%inciso b

%   f(V)=0=P.*V.^3./(R*T) -V.^2 - polyval(pol,V);
f = @(p,v)    p.*v.^3./(R*T)- v.^2 - polyval(pol,v);

%para ver entre que valores anda el cero
%xx = linspace(10000,30000,20000)
%plot(xx,f(2,xx));
%xx = linspace(25000,50000,20000)
%plot(xx,f(0.5,xx));


[p,h,it] =  Biseccion(@(v) f(2,v) , 11000,15000,10000,0.5e-5);
p
[p,h,it] =  Biseccion(@(v) f(0.5,v) ,48500,50000,10000,0.5e-5);
p


%item c
f = @(v) (polyval(pol,v)+v.^2).*(R*T)./(v.^3);
%W1 = intNCcompuesta(f,10000,30000,2000,3);
W2 = intNCcompuesta(f,10000,30000,4000,3);
%abs(W2-W1)/abs(W1)
W2