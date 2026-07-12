A = [80 -50 -30 0;
    ; -50 100 -10 -25
    ; -30 -10 65 -20
    ; 0 -25 -20 100];
b = [-120 ; 0; 0; 0 ];
Aor = A;
bor=b;

printf("gauss");
for k=1:1:(length(b)-1)
    for i =k:1:length(b)-1
        s=A(k,:).*(A(i+1,k)/A(k,k));
        b(i+1) = b(i+1) - b(k).*(A(i+1,k)/A(k,k));
        A(i+1,:)=A(i+1,:)-s;
    endfor
endfor
A
b

x = sust_atras_vec(A,b);
Aor*x