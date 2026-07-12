columnas = ones(40,1);
A = spdiags([-1*columnas 2*columnas -1*columnas], [-1 0 1], 40,40);
b = 1.5*(1:1:40)'-6;
[A_gauseada,x]=gauss1(A,b);
x(20)


w=1.85;
x0=zeros(40,1);
[x,it_jacob,h]=jacobbi(A,b,x0,10000,1e-5);
x(20)
it_jacob
[x,it_seidel,h]=gauss_seidel(A,b,x0,10000,1e-5);
x(20)
it_seidel
[x,it_sor,h]=SOR(A,b,x0,10000,1e-5,w);
x(20)
it_sor

%[w_exp] = wOptimoExperimental(A,b,x0,10000,1e-5);
%dropeo 1.86
%[w_min] = wOptimoTeorico(A)
%dropeo 1.86
%[w_min] = wOptimoFormula(A)
%w_min = 1.8578