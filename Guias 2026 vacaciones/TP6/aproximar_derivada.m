function dy = aproximar_derivada(x,y)
    L = length(x);
    h = (x(end)-x(1))/(L-1);
    dy = zeros(L,1);
    dy(1) = (-3*y(1)+4*y(2)-y(3))/(2*h);
    dy(2:end-1) = (y(3:end)-y(1:end-2))/(2*h);
    dy(end) = (3*y(end)-4*y(end-1)+y(end-2))/(2*h);
endfunction