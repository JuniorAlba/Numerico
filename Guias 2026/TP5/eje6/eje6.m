y = [0 4 22/3];
x = [1 2 3];
[f1,df1,ddf1] = funcion_spline(x,y,3,3);

x1 = linspace(1,3,100);
plot(x1,f1(x1),'r-');