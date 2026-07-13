function [x] = gauss(A,b)
n=length(b);
A=[A b];
% Eliminacion
for k=1:n-1
  m = A(k+1:n,k)/A(k,k);
  A(k+1:n,k)=0;
  A(k+1:n,k+1:n+1) = A(k+1:n,k+1:n+1)-m*A(k,k+1:n+1);
endfor
if (A(n,n)==0)
  disp('no hay sol. unica')
endif
x=sust_atras(A(:,1:n),A(:,n+1)); %retrosustitucion
