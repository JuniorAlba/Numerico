function [a,b,c,d] = c_spline_natural(x,y)
  %HECHO POR MI, x e y deben ser vectores fila
  hf = @(xi2,xi1) xi2-xi1;
  n = length(x);
  A = zeros(n,n);
  % a va a ser un vector columna debido a que y es un vector columna
  %esto mismo es aplicable a los demas vectores b,c,d
  a = y(1:n)'; %Sabemos que los polinomios deben tomar el valor de la funcion en el punto inicial
  %por lo tanto el coeficientes valen lo mismo que la funcion en el punto
  h = [hf(x(2:n),x(1:n-1))]';

  diag_inf = h(1:n-2);
  %esta linea esta solamente para que cuando sume las matrices diagonales tengan
  %la misma dimension y no me de error, el cero que le agrego al final no afecta
  %al resultado
  diag_inf(n-1) = 0;


  diag_sup(2:n-1) = h(2:n-1);
  %esta linea esta solamente para que cuando sume las matrices diagonales tengan
  %la misma dimension y no me de error, el cero que le agrego al final no afecta
  %al resultado

  diag_sup(1) = 0;
  diag_ = ones(n,1);
  diag_(2:n-1) = 2*(h(1:n-2)+h(2:n-1));
  A = A + diag(diag_inf,-1) + diag(diag_sup,1) + diag(diag_,0);
  %estas operaciones las hago sin trasponer a o h debido a que ambos son columnas
  %a diferencia del profe que los tiene que trasponer pq si no no da el resultado
  b_matriz(2:n-1) = 3*[((a(3:n)-a(2:n-1))./(h(2:n-1)) - (a(2:n-1) - a(1:n-2))./(h(1:n-2)))];
  b_matriz(1)=0;
  b_matriz(n)=0;
  b_matriz = b_matriz';
  c = A\b_matriz;
  d = [c(2:n)-c(1:n-1)]./(3*h(1:n-1));
  %El b lo calculo de forma diferente a lo que hacen en la teoria ya que
  %parece que despejaron mal
  b = [a(2:n)-a(1:n-1)]./h(1:n-1) - [2*c(1:n-1) + c(2:n)].*(h(1:n-1)/3);
  a = a(1:n-1);
  c = c(1:n-1);







