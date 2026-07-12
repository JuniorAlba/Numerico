N=100;
columnas = [-1*ones(N,1) 2*ones(N,1) -1*ones(N,1)];
A = spdiags(columnas, [-1 0 1], N,N);
A(1,1) = 1;
A(N,N)= 1;
A(1,2)=0;
A(N,N-1)=0;
full(A);
b = [];
for i=1:1:10
    b = [b 1/(N^i).*ones(N,1)];
    b(1,i)=0;
    b(N,i)=0;
endfor
xmax = [];
[L,U]=doolitle_nop(A);
for i=1:1:10
    [y]=sust_adelante_vec(L,b(:,i));
    [x]=sust_atras_vec(U,y);
    xmax=[xmax; max(x)];
    max(x)
endfor
semilogy((1:1:10),xmax)


cond(A,1)
%Conclusión:1.  Linealidad: Se verifica empíricamente lo establecido en la teoría (Diapositiva 81, Métodos Directos ):
%la solución varía siguiendo la misma relación funcional que los datos.
%Al escalar el vector $b$ por $1/N^k$, la solución máxima escala proporcionalmente,
%generando una recta perfecta en el gráfico semilogarítmico.

%2.  Condicionamiento: Aunque el número de condición ($\kappa \approx 4000$) indica una amplificación teórica del error
%(perdiendo ~3 a 4 dígitos de precisión), la matriz se comporta como bien condicionada para la precisión de la máquina utilizada
%(Diapositiva 82 ). Esto se evidencia en que la proporcionalidad se mantiene intacta incluso para valores muy pequeños de la solución
%($10^{-16}$), demostrando que las perturbaciones numéricas (ruido) no llegaron a dominar sobre la solución real.