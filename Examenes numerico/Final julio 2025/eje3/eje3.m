format long;
p = @(x) 2.*x./(1-x.^2);
q = @(x) -42./(1-x.^2);
r = @(x) 0*x;
f = @(x) [p(x) q(x) r(x)];
y0 = [1 1]; 
inter = [-1 1];

%L1 = 4000;
%[x,y_ant] = dif_fin_dir(f,inter,y0,L1);
L2 = 8000;
[x,y] = dif_fin_dir(f,inter,y0,L2);
y(4001)
%abs(y(L2/2+1)-y_ant(L1/2+1))< 0.5e-6

[pol] = polyfit(x,y,6);
fprintf("%.3f %.3f %.3f %.3f %.3f %.3f %.3f \n",pol(7),pol(6),pol(5),pol(4),pol(3),pol(2),pol(1));


%plot(x,y)
[p1,h,it]  = Biseccion(@(x) polyval(pol,x),0,0.5,1000,0.5e-8);
[p2,h,it]  = Biseccion(@(x) polyval(pol,x),0.5,0.75,1000,0.5e-8);
[p3,h,it]  = Biseccion(@(x) polyval(pol,x),0.75,1,1000,0.5e-8);

fprintf("%0.8f %0.8f %0.8f \n",p1,p2,p3)

