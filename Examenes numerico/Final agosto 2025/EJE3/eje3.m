k0 =0.57;
H = 10;
ue = 4;
Long=2;

rob = [k0 H H*ue];
y0 = 6;

Cr = @(x) 5.*(x-2);
fuente = @(x) 12*cos(2*x);
p = @(x) 0*x;
q = @(x) Cr(x)./k0;
r = @(x) -(1./k0).*fuente(x);
f = @(x) [p(x) q(x) r(x)];

L=200;
[x,y] = dif_fin_rob(f,[0 Long], y0,rob,L);
y(end)

%item b 
%condicion de robin k0*u'(L) +H*u(L)=H*ue   y   -k0*u'(L)=flujo
% -k0*u'(L) = H*u(L) - H*ue

flujo = H*y(end) - H*ue

%item c
A = 0.01;
valores = 0.217*2.7*y;
A*trapcomp(x,valores)

%inciso d

%NO RIGE LA LEY DEL ENFRIAMIENTO, POR LO TANTO ESTA AISLADA
%u'(L)=0
%pero u'(0) = -48

f = @(t,x) [x(2) ;Cr(t)/k0*x(1)-fuente(t)/k0];
[t,x] = rk4(f,[0 2], [6 -48],200);
x(end,1)