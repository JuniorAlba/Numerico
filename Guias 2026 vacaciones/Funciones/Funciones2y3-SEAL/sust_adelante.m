function x=sust_adelante(A,b)
  n=length(b);
  x=zeros(n,1);
  x(1)=b(1)/A(1,1);
  for i=2:n
    s=b(i);
    s=s-A(i,1:i-1)*x(1:i-1);
    x(i)=s/A(i,i);
  endfor

