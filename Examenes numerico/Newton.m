function [p,h,it] = Newton(f,df,x0,kmax,tol)
  #HECHO POR MI
  p = x0;
  for it=1:kmax
    p = x0 - f(x0)/df(x0);
    h(it)= abs(p-x0)/abs(p);
    #h(it) = abs(p-x0);
    #h(it) = f(p);
    if h(it)<tol
      break;
    endif
    x0=p;
  endfor
endfunction
