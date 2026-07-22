addpath('..');
t1 = linspace(0,5,26)';
v1 = [0.61255
    1.40101
    2.69013
    3.40985
    3.95361
    3.59041
    3.09119
    2.71147
    2.01397
    1.35229
    1.09930
    1.30715
    1.99290
    3.46081
    5.34487
    7.50176
    9.35324
   11.22945
   12.76212
   13.99448
   14.41532
   14.47064
   13.91045
   13.01681
   12.18537
   11.26826];

   %Mt*M*a = Mt*y
   f1 = @(t) sin(2*t);
   f2 = @(t) t.^2;
   f3 = @(t) 2.^t;
   f4 = @(t) 1*t.^0;
   M = [f1(t1) f2(t1) f3(t1) f4(t1)];
   A = M'*M;
   b = M'*v1;
   c = A\b;
   vt = @(t) c(1)*f1(t) + c(2)*f2(t) + c(3)*f3(t) + c(4)*f4(t);
   vt(6)

   p=polyfit(t1,v1,6);
   polyval(p,6);
   E_POL = error_cuadratico(p,t1,v1)
   E_FUN = sum((v1-vt(t1)).^2)


   int_f1 = @(t) -1*cos(2*t)/2;
   int_f2 = @(t) t.^3/3;
   int_f3 = @(t) 2.^t/log(2);
   int_f4 = @(t) 1*t;
   int_vt = @(t) c(1)*int_f1(t) + c(2)*int_f2(t) + c(3)*int_f3(t) + c(4)*int_f4(t);
   int_vt(6) - int_vt(0)

   % === COMENTARIOS TEÓRICOS (Para copiar) ===
%{
  RESPUESTA INCISO C: ¿Qué ajuste es más apropiado?
  -------------------------------------------------
  Es probable que el polinomio de grado 6 (p6) tenga un error cuadrático
  menor DENTRO del intervalo [0,5] porque tiene más grados de libertad y
  puede "zigzaguear" para tocar los puntos.
  
  SIN EMBARGO, el Modelo A (Custom) es más apropiado.
  ¿Por qué?
  1. Extrapolación: Fíjate en la gráfica a t=6. Los polinomios de alto grado
     tienden a dispararse hacia +/- infinito fuera del rango de datos
     (Fenómeno de Runge/Sobreajuste). El Modelo A tiene componentes físicas
     (seno, exponencial) que suelen ser más estables para predecir.
  2. Simplicidad: El modelo A usa funciones específicas que probablemente
     vengan de la teoría física del movimiento del objeto, mientras que el
     polinomio es solo una "caja negra" matemática.
%}