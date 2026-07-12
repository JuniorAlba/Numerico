%DF_COMP_1
L=2; %cm
A=0.01; %cm^2
c=0.217; %cal/(g*°C)
rho=2.7; %g/cm^3
K0=0.57; %cal/(s*cm*°C)
T0=6; %°C
H=10; %cal/(s*cm^2*°C)
uE=4; %°C
fuente=@(x) 12.*cos(2.*x); %cal/(s*cm^3)
creact=@(x) 5.*(x-2);

%Ecuacion de forma -K0u'' + cRu = f → u'' = cRu/K0 -f/K0
%Condicion de borde derecho de forma -K0u' = H(u-uE) → -K0u' -Hu = -HuE → A=-K0, B=-H, C=-HuE
coefs=@(x) [zeros(length(x),1), creact(x)./K0, -fuente(x)./K0 ];
robin=[-K0, -H, -H*uE];
h=0.001;
N=(L-0)/h
[x,T]=dif_fin_rob(coefs,[0,L],T0,robin,N);
disp(T(end)); %resultado a) 0.1413
%inciso b) estimo la derivada con una formula en dif finitas hacia atrás
flujo=-K0*(T(end)-T(end-1))/h
[x,T]=dif_fin_rob(coefs,[0,L],T0,robin,N*2);
%alternativamente, despejo el flujo en L de la condición de borde
flujo=H*T(end)-H*uE

%inciso c
integrando=T*rho*c;
E=A.*trapcomp(x,integrando)

%inciso d, ahora se vuelve un pvi
fizq=-48; %el flujo a la izquierda no es la derivada, es -K0*derivada
dT0=-fizq/K0; %despejo la derivada para usarla de CI del PVI
sist=@(x,y) [y(2);fuente(x)/(-K0)+creact(x)/K0*y(1)];
[x,y]=rk4(sist,[0,2],[T0,dT0],N);
disp(y(end,1))

