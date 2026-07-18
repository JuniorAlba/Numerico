function [L, D, U] = DescomponerMatriz(A)
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);
endfunction
