addpath("..");
f = @(x) x.^3 + x - 4;
tol = 1e-3;
a =1;
b=4;
[p, rh, it] = biseccion(f,a,b,40,tol)

f(p)
