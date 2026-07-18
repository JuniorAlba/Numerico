addpath("..");
f  = @(x) x.^4+2*x.^2-x-3 ;
x=linspace(1, 3/2 ,100);
x0=1;
tol=10^-7;
kmax=50;

figure(1)
plot(x,f(x),'k-')
grid on; grid minor
z =@(x) x==0;
hold on
plot(x,z(x),'r-')
title('Cero de la funcion')
hold off

g1 = @(x) (3+x-2*x.^2).^(0.25);
g2 = @(x) ((x+3-x.^4)/2).^(0.5);
g3 = @(x) ((x+3)./(x.^2+2)).^(0.5);
g4 = @(x) ((3*x.^4+2*x.^2+3)./(4*x.^3+4*x-1));

display("Iteraciones utilizando g1")
[x1, rh1, it1] = puntofijo(g1, x0, kmax, tol);
it1
display("Iteraciones utilizando g2")
[x2, rh2, it2] = puntofijo(g2, x0, kmax, tol);
it2
display("Iteraciones utilizando g3")
[x3, rh3, it3] = puntofijo(g3, x0, kmax, tol);
it3
display("Iteraciones utilizando g4")
[x4, rh4, it4] = puntofijo(g4, x0, kmax, tol);
it4

figure(2)
hold on
semilogy(rh4,'b-')
semilogy(rh3,'r-')
semilogy(rh2,'g-')
semilogy(rh1,'y-')
grid on, grid minor

title('Convergencia')

hold off
%se puede ver que la que converge mas rapido es g4, luego g3 y luego g1. g2 no converge

% --- Cálculo de derivadas de forma analítica (sin pkg load symbolic) ---
x_vals = x;

% Derivadas calculadas manualmente:
% dg1(x) = d/dx [ (3+x-2x^2)^(1/4) ]
dg1 = @(x) 0.25 .* (3 + x - 2.*x.^2).^(-0.75) .* (1 - 4.*x);

% dg2(x) = d/dx [ ((x+3-x^4)/2)^(1/2) ]
dg2 = @(x) 0.5 .* ((x + 3 - x.^4)./2).^(-0.5) .* ((1 - 4.*x.^3)./2);

% dg3(x) = d/dx [ ((x+3)/(x^2+2))^(1/2) ]
dg3 = @(x) 0.5 .* ((x + 3)./(x.^2 + 2)).^(-0.5) .* ( (1.*(x.^2 + 2) - (x + 3).*(2.*x)) ./ (x.^2 + 2).^2 );

% dg4(x) = d/dx [ (3x^4+2x^2+3)/(4x^3+4x-1) ]
% u = 3x^4+2x^2+3, u' = 12x^3+4x
% v = 4x^3+4x-1, v' = 12x^2+4
dg4 = @(x) ((12.*x.^3 + 4.*x).*(4.*x.^3 + 4.*x - 1) - (3.*x.^4 + 2.*x.^2 + 3).*(12.*x.^2 + 4)) ./ (4.*x.^3 + 4.*x - 1).^2;

figure(3)
hold on

dg1_vals = dg1(x_vals);
dg2_vals = dg2(x_vals);
dg3_vals = dg3(x_vals);
dg4_vals = dg4(x_vals);

plot(x_vals,dg4_vals,'b-')
plot(x_vals,dg3_vals,'r-')
plot(x_vals,dg2_vals,'g-')
plot(x_vals,dg1_vals,'y-')



