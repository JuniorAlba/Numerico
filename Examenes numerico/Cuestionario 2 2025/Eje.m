format long;
%buscamos el valor de a tal que z(0.02)=0.02
%para usar el algoritmo de punto fijo podemos hacer esto
%g(a) = z(0.02)-0.02+a
z = @(t,a) 0.04.*sqrt(a+t).*(1-t) - t.*sqrt(3*a);
g = @(a) -1.*z(0.02,a)+0.02+a;   %lo exprese de esta manera para que la derivada sea chica
a0 = 19;    %lo sacamos de la funcion w
[a,h,it]=Puntofijo(g,19, 10000,1e-6);
a
z(0.02,a)


%para usar punto fijo y no tener que usar otro algoritmo hago esto:
% si quiero z(t)=0 es lo mismo que encontrar el punto fijo de g(t) = t donde g(t)= z(t)+t

%z2 = @(t) -1*z(t,a)+t;
%[p,h,it]=Puntofijo(z2,0.02, 10000,1e-6);
%p
%z2(p)
%no converge :(
tt = linspace(0,2,100);
plot(tt,z(tt,a))
[p,h,it] = Biseccion(@(t) z(t,a),0,1,1000,1e-6);
p
z(p,a)