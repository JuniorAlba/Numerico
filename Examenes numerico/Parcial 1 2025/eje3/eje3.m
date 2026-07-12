f1 = 440;
f2 = 660;
f3 = 1100;
f4 = 5;
f5 = 8;
g1 = @(t,f) sin(2*pi*f*t);
g2 = @(t,f) cos(2*pi*f*t);

t = [0 ; 0.0025 ; 0.005 ; 0.0075; 0.01];
s = [2.1004; 4.3702; 5.1745; -0.7222; 0.9249];

M = [g1(t,f1) g1(t,f2) g1(t,f3) g2(t,f4) g1(t,f5)]

%L*U=P*M
%problema inicial M*x=s
%L*U*x= P*s
% L*y=P*s   luego   U*x=y
[L,U,A,r,P]=doolitle_p(M);
[y]=sust_adelante_vec(L,P*s);
[x]=sust_atras_vec(U,y);
M*x

%item  b
Ap = P*M;
%w = wOptimoTeorico(Ap)
w=0.6636;
[x,it,r_h]=SOR(Ap,P*s,zeros(5,1),10000,1e-4,w);

Ap*x
P*s
it
