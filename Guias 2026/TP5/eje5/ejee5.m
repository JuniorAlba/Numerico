f = @(x) sin(2*pi.*x);
x1 = linspace(-1,1,21)';
y1 = f(x1);
[f1,df1,ddf1]=funcion_splinee(x1,y1);  %spline cubica
[p] = polyfit(x1,y1,20);                   %pol de lagrange
xx1 = linspace(-1, 1, 100)';
yy1 = f1(xx1);


figure(1);
hold on;
plot([-1, 1], [0,0],'m-');
grid on
grid minor
xlabel('Datos X')
ylabel('Funcion (f(x))')
title('Métodos de Interpolación')
plot(xx1,f1(xx1),'r-','linewidth',6);
plot(xx1,polyval(p,xx1),'b-','linewidth',5);
hold off;

f = @(x,i) sin(2*pi*x) + (-1).^(i+1)*10^(-4);
i = (0:1:20)';
y2 = f(x1,i);
[f2,df2,ddf2]=funcion_splinee(x1,y2);  %spline cubica
[p] = polyfit(x1,y2,20);                   %pol de lagrange


figure(2);
hold on;
plot([-1, 1], [0,0],'m-');
grid on
grid minor
xlabel('Datos X')
ylabel('Funcion (f(x))')
title('Métodos de Interpolación')
plot(xx1,f1(xx1),'r-','linewidth',6);
plot(xx1,polyval(p,xx1),'b-','linewidth',5);
%{
  =============================================================================
  CONCLUSIONES DEL EJERCICIO 5: ANÁLISIS DE RESULTADOS
  =============================================================================

  1. COMPARACIÓN VISUAL:
     - En la Figura 1 (Datos originales), ambos métodos parecen ajustar bien la
       función seno, aunque el Polinomio de Lagrange (grado 20) ya empieza a
       mostrar pequeñas oscilaciones en los extremos (Fenómeno de Runge).

     - En la Figura 2 (Datos perturbados), la diferencia es dramática. Se introdujo
       un ruido muy pequeño de orden 10^-4 (imperceptible a simple vista en los puntos),
       pero la respuesta de los métodos fue opuesta.

  2. SENSIBILIDAD DEL POLINOMIO DE LAGRANGE (Línea Azul/Polyfit):
     - Se observa una INESTABILIDAD EXTREMA en los bordes.
     - Causa: Los polinomios de alto grado (n=20) están "mal condicionados".
       Al intentar pasar exactamente por todos los puntos en un dominio global,
       una variación minúscula en los datos de entrada (la perturbación) genera
       oscilaciones gigantescas entre los puntos, especialmente en los extremos.
     - Esto confirma que Lagrange es altamente sensible al ruido.

  3. ROBUSTEZ DE LA SPLINE CÚBICA (Línea Roja):
     - La curva se mantiene suave y casi idéntica a la original.
     - Causa: La Spline trabaja "localmente" (por tramos cúbicos).
     - La perturbación en un punto solo afecta ligeramente a los tramos vecinos,
       pero el error no se propaga ni se amplifica a lo largo de todo el intervalo.
     - Esto demuestra que las Splines son mucho más estables y confiables para
       interpolación de muchos puntos o datos con incertidumbre.
  =============================================================================
%}