## Copyright (C) 2025 User
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} jacobbi (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: User <User@COMPUTADORA>
## Created: 2025-04-14


%jacobbi sin pivoteo parcial
function [x,it,r_h] = jacobbi(A,b,x0,maxit,tol)
  n = length(b);
  x = x0;
  it = 0;
  while (it<maxit)
    for i=1:1:n
      x(i) = (b(i)-A(i,1:i-1)*x0(1:i-1) - A(i,i+1:n)*x0(i+1:n))/A(i,i);
      %hay que verificar que la matriz A no tenga ceros en la diagonal
      %eso se hace antes de iterar, en caso de que si, aplicar piv parcial

  endfor
    %   norm(x-x0)/norm(x); -> error relativo(es una aproximacion al error, debido a que el error se calcula con la solucion exacta)
    %   norm(A*x-b) -> se le denomina residuo de la ecuacion;
    %   Una condicion para detener el algoritmo puede ser  norm(A*x-b,inf)<= norm(b,inf)*tol
    %   Una condicion para detener el algoritmo puede ser norm(x-x0,inf)/norm(x,inf) <=tol
    r_h(it+1)=norm(x-x0,inf)/norm(x,inf); %calculo el residuo
    if r_h(it+1)<tol
      r_h = r_h(1:it+1);
      it=it+1;
      break;
    endif
    it = it + 1; %actualizo la cantidad de iteraciones
    x0 = x;
  endwhile
endfunction














