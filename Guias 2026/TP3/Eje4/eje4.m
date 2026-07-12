A = [10 5 0 0; 5 10 -4 0; 0 -4 8 -1; 0 0 -1 5];
b = [6 25 -11 11]';
L = tril(A,-1);
U = triu(A,1);
D = diag(diag(A));
%la diagonal principal principal no tiene ceros por lo tanto P(Tw)>=abs(w-1)
% es decir que si P(Tw)<1 (para que el metodo converja) entonces 0<w<2
printf('\n\nCalculando el wOptimo con el metodo teorico\n')
tic;
[w_min]= wOptimoTeorico(A);
toc_teorico = toc;
w_min
[x,it,r_h]= SOR(A,b,ones(size(A,1),1),100,1e-10,w_min);
it
r_h(end)

printf('\n\nCalculando el wOptimo con el metodo experimental\n')
tic;
[w_min] = wOptimoExperimental(A,b,ones(size(A,1),1),10000,1e-10)
toc_experimental = toc;
[x,it,r_h]= SOR(A,b,ones(size(A,1),1),10000,1e-10,w_min);
it
r_h(end)

printf('\n\nCalculando el wOptimo con formula\n')
tic;
[w_min] = wOptimoFormula(A)
toc_formula = toc;
[x,it,r_h]= SOR(A,b,ones(size(A,1),1),10000,1e-10,w_min);
it
r_h(end)



printf('\n\nUsando W=1\n')
[x,it,r_h]= SOR(A,b,ones(size(A,1),1),100,1e-10,1);
it
r_h(end)




toc_teorico
toc_experimental
toc_formula