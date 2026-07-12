#EJERCICIO 1 FINAL 12/02/26 - Pfeiffer, Valentín Pedro
l0=10;
l1=1;
w=1;
fi=0.02;
g=9.81;
l=@(t) l0+l1.*cos(w.*t+fi);
dl=@(t) -w.*l1.*sin(w.*t+fi);
%o=theta. armo el vector de funciones coeficiente para el pvc
coefs=@(t) [ -2.*(dl(t)./l(t)) , -g./l(t) , zeros(size(t)) ];
%condiciones del problema:
%esta en un angulo inicial oa → oa=0.5
%al momento de soltarlo → ta=0.
%a los 5s → tb=5;
%pasa por la pos. eq → ob=0-
%da valores en la frontera de la funcion o(t), es un PVC con cond. dirichlet (conds de contorno en
%derechas en la funcion, mas no en la derivada)
o0=0.5;
o5=0;
ta=0;
tb=5;
robin=[0 1 0]; %vector de coefs para robin, 0(0)=0;

h=0.001;
N=(tb-ta)/h
[t,o]=dif_fin_rob(coefs,[ta,tb],o0,robin,N);
%plot(t,o);
%inciso a)
%obtengo la derivada en 0(0) usando la formula progresiva de diferencias finitas en 3pts
do01=(-3*o(1)+4*o(2)-o(3))/(2*h)
h=h/2;
N=(tb-ta)/h
[t,o]=dif_fin_rob(coefs,[ta,tb],o0,robin,N);
do02=(-3*o(1)+4*o(2)-o(3))/(2*h) %repito para verificar precision

%inciso b
plot(t(1:N/2+1),o(1:N/2+1)); %grafico hasta el punto medio, 2.5s
%como empieza a la derecha de la pos eq (ahi se considera positivo),
%y pasa tan solo una vez por o=0, se tiene entonces que está a la izquierda
disp(t(N/2+1));
disp(o(N/2+1)) %da un resultado negativo pero la amplitud es el valor absoluto del mismo

%inciso c
d_o(1)=(-3*o(1)+4*o(2)-o(3))/(2*h);
d_o(N+1)=(-3*o(N+1)+4*o(N)-o(N-1))/(2*h);
for i=2:N
  d_o(i) = (o(i+1)-o(i-1))/(2*h);
endfor
plot(t,o); hold on;
plot(t,d_o); %ploteo la derivada para verificar que se condice con los desplazamientos
S=trapcomp(t,abs(d_o))
