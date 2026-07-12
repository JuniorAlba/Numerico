%Inciso A
%Realizar un ajsute por minimos cuadrados para obtener A1 y A2

x1 = [0.0819 0.2192 0.3582 0.3831 0.5256 0.8478 0.9872]';
ge = [20 48.6 70.3 72.3 84.1 53.5 5.7]';
x2 = 1 - x1;
R = 1.987;
T = 328;
y=R.*T.*x1.*x2./(ge);
[p]= polyfit(x1,y,1);
A1 = 1/p(2)
A2 = (p(1)+1/A1)^-1


%Inciso b
%Armamos la funcion para obtener el exceso de energia en termimos del benceno
ener = @(x1)  (A1*A2*R*T*x1.*(1-x1))./(A1*x1+A2*(1-x1));
ener(0.3)

%Inciso c
%Obtener el error relativo, tomando nuestro ajuste como el valor exacto
error_rel = abs(ener(0.5)-80)/abs(ener(0.5))

%Inciso d
%Obtener la raiz de la funcion energia-10  para x1>0.5, para ello ploteamos la funcion
%y vemos entre que valores pasa de positivo a negativo
ener_v2 = @(x1) ener(x1)-10;
xx1 = linspace(0.5,1,100);
plot(xx1,ener_v2(xx1));
%el intervalo para x1 es: [0.5 1]
[p,h,it] = Biseccion(ener_v2,0.5,1,1000,0.5e-5);
benceno=p
trimetrilpetano = 1-p
ener(p)