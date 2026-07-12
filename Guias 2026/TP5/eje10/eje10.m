t = [4 8 12 16 20 24];
c = [1590 1320 1000 900 650 560];
ln_c = log(c);
p = polyfit(t,ln_c,1);
b = exp(p(2));
k = -1*p(1);
t_graph = linspace(0,48,100);
c_funcion = @(t) b*exp(-1*k*(t));
hold on
plot(t,c,'ko','MarkerFaceColor','k','MarkerSize',8,'DisplayName','Puntos reales');

plot(t_graph,c_funcion(t_graph),'r-','linewidth',4,'DisplayName','Aproximacion');

legend('Location','northwest');

c_funcion(0)

c_funcion_consignac = @(t) c_funcion(t)-200;
[p,h,it]=Biseccion(c_funcion_consignac,24,48,500,1e-7);
p




