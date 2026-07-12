A = [1 1+0.5e-15 3; 2 2 20; 3 6 4];
[L1,U1] = doolitle_nop(A);
[L2,U2,Ar,r,P] = doolitle_p(A);
disp("A-L1*U1");
disp(A-L1*U1);
printf("\n")
disp("P*A-L2*U");
printf("\n")
disp(P*A-L2*U2);

%Al termino P*A-LU y A-LU le voy a denominar error residual de la factorizacion doolitle

%La diferencia entre el residuo de 4 (sin pivoteo) y  8.8818e-16 (con pivoteo) confirma que
%la matriz original está mal condicionada para la eliminación simple debido a la aparición de
%un pivote cercano a cero. La implementación del pivoteo parcial es indispensable en este caso
%para evitar la propagación explosiva de errores de redondeo y obtener una factorización $LU$ válida ($PA = LU$).
