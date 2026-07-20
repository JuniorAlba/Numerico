addpath('../../../TP4');
addpath('../../../TP3');
addpath('../../../TP2');
format long;


%ITEM A
% buscamos el valor de a tal que z(0.02)=0.02
% para usar el algoritmo de punto fijo podemos hacer esto
% g(a) = -1*z(0.02,a)+0.02+a
% NOTA: Usamos -1*z en lugar de +1*z para asegurar la convergencia.
% Para que el punto fijo converja, necesitamos que |g'(a)| < 1.
% Como dz/da = 0.00052:
% Si g(a) = +z(0.02,a) - 0.02 + a  => g'(a) = 1.00052 (> 1, diverge)
% Si g(a) = -z(0.02,a) + 0.02 + a  => g'(a) = 0.99948 (< 1, converge)
z = @(t,a) 0.04.*sqrt(a+t).*(1-t) - t.*sqrt(3*a);
g = @(a) -1*z(0.02,a)+0.02+a;
a0 = 19;
kmax = 1000;
tol = 1e-6;
[a,h,it]=puntofijo(g,a0,kmax,tol);
a
z(0.02,a)




%ITEM B
[p,h,it] = biseccion(@(t) z(t,a),0,1,1000,1e-6);
p
z(p,a)



%resultado

# a = 19.02958649371340
# p = 0.022585868835449