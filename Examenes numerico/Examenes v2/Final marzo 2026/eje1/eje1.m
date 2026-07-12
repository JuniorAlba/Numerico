format long;
L = 4;
lambda = 1.5;
ye = 1;
k = 1.2;
yr=0.9;
x_datos = [0 ; 1 ; 3 ; 4];
A_datos = [1.25 ; 1.4 ; 1.0 ; 1.11];
pol = polyfit(x_datos,A_datos,3);
A = @(x) polyval(pol,x);
pol_der =  polyder(pol);
A_prima = @(x) polyval(pol_der,x);
p =  @(x) A_prima(x)./A(x);
q = @(x) A(x)*lambda;
r = @(x) -1*A(x)*lambda*ye;
f = @(x) [p(x) q(x) r(x)];
alpha = 0.8;
rob = [1 k yr*k];

%INCISO A
%6 decimales exactos para el primer resultado y 4 decimales exactos para el segundo
subint = 100;
[x,y] = dif_fin_rob(f,[0 L], alpha,rob,subint);
while(true)
    subint = 2*subint;
    y_ant = y;
    x_ant = x;
    [x,y] = dif_fin_rob(f,[0 L], alpha,rob,subint);
    [valor_ant,indice_ant] = max(y_ant);
    [valor,indice] = max(y);
    cond1 = abs(valor - valor_ant) < 0.5e-6;
    cond2 = abs(x(indice) - x_ant(indice_ant)) < 0.5e-4;
    if(cond1 && cond2)
        break;
    endif
endwhile
[valor,indice] = max(y);
valor
%valor = 0.986771
%La respuesta correcta es: 0.986772
x(indice)
%x = 2.4125
%La respuesta correcta es: 2.411

%INCISO B
h = L/subint;
valores_x = [0:h:L]';
A_vector = A(valores_x);

%vamos a definir el vector derivada
y_prima = zeros(subint+1,1);

%utilizamos la formula de dif fin progresivas
y_prima(1) = (-3*y(1) +4*y(2) -y(3))/(2*h);

%utilizamos la formula de dif fin regresivas
y_prima(end) = (3*y(end) -4*y(end-1) +y(end-2))/(2*h);

%utilizamos la formula de dif fin centradas
y_prima(2:end-1) = (y(3:end) - y(1:end-2))/(2*h);

flujo_esp = -1*1./A_vector.*y_prima;
flujo_esp(end)
%flujo_esp(end) = 0.0558697
%La respuesta correcta es: 0.0558727


%INCISO C
%si queremos un h=0.1 entonces:
inter = [0 L];
h=0.1;
subint = L/h;
x=linspace(inter(1),inter(2),subint+1)';

#construccion de la matriz
col=[-1-h/2*p(x(3:end)) 2+h^2*q(x(2:end-1)) -1+h/2*p(x(1:end-2))];
col=[col;0 2+h^2*q(x(end)) -1+h/2*p(x(end-1))];
M = spdiags(col, [-1 0 1], subint+1, subint+1);
M(end-1,end)=-1+h/2*p(x(end));
M(end,end-2:end)=[-rob(1) 2*h*rob(2) rob(1)];
#construccion del vector de terminos idependientes
b = -h^2*r(x(2:end));
b(1)+=(1+h/2*p(x(2)))*alpha;
b(end+1)=2*h*rob(3);
#resolucion del sistema
[ys,it,r_h] = gauss_seidel(M,b,alpha*ones(subint+1,1),10000,1e-6);
#solucion con las condiciones de contorno
y=[alpha;ys(1:end-1)];
it
%407
%La respuesta correcta es: 407