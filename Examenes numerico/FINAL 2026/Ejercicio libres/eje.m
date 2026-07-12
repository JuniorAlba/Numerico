w = [0.2 ; 0.5 ; 0.8 ; 1.1; 1.4 ; 1.7 ; 2.0];
A = [2.33 ; 2.06  ; 1.78; 1.53; 1.31; 1.13; 0.98];

# A*(1+y*w+w^2) = (a+b*w)
# A + y*w*A + A*w^2 = a+b*w
# A = a + b*w -y*A*w - A*w^2
f1 = @(w) 1+w.*0;
f2 = @(w) 1*w;
f3 = @(w) -1*A.*w;
M = [f1(w) f2(w) f3(w)];
b = M' * (A+A.*w.^2);
Matriz = M'*M;
c = Matriz\b;
y = c(3);
b = c(2);
a = c(1);

f = @(w) (a + b.*w)./(1+y.*w+w.^2);
figure(1)
hold on;
xx = linspace(0,10,100);
plot(w,A,'-r');
plot(xx,f(xx),'-g');


#solo nos interesa el numerador de la deriva de f para encontrar el maximo

numerador_df = @(w) b.*(1+y.*w+w.^2) - (a+b.*w).*(y+2.*w);
plot(xx,numerador_df(xx),'-b')
[x,r_h,it] = Biseccion(numerador_df,0,2,1000,0.5e-8);
x
f(x)