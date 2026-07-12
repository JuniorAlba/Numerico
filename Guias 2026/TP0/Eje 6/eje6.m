printf("\n(a) A = [1 2 3; 4 5 6; 7 8 9] \n")
A = [1 2 3; 4 5 6; 7 8 9]

printf("\n(b) B= A' \n")
B= A'

printf("\n(c) C = [-3.2,5,7.4,6;4,17,-1.3,2.1;5.9,-6,0,4.5]\n")
C = [-3.2,5,7.4,6;4,17,-1.3,2.1;5.9,-6,0,4.5]

printf("\n(d) mat = C' \n")
mat = C'

printf("\n(e) C(1:2,2:4) \n")
C(1:2,2:4)

printf("\n(f) C(:,3) \n")
C(:,3)

printf("\n(g) C(2,:) \n")
C(2,:)

printf("\n(h) zeros(5,2) \n")
zeros(5,2)

printf("\n(i) ones(2,3) \n")
ones(2,3)

printf("\n(j) v = diag(A) \n")
v = diag(A)

printf("\n(k) D = diag(v,1) \n")
D = diag(v,1)

printf("\n(l) E = diag(v,-1) \n")
E = diag(v,-1)

printf("\n(m) diag(5*ones(3,1),0)+diag(ones(2,1),-1)+diag(-3*ones(2,1),1) \n")
diag(5*ones(3,1),0)+diag(ones(2,1),-1)+diag(-3*ones(2,1),1)