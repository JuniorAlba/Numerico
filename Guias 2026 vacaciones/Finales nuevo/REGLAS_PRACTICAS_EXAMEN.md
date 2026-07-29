# Reglas Practicas para Finales de Analisis Numerico
> Resumen de patrones recurrentes y trampas comunes detectadas al revisar los finales 2025-2026.

---

## 1. Elegir el paso `h` (o cantidad de pasos `L`)

### Para evaluar la solucion en un punto FIJO (ej: T(2), C(t=30), I(3))
RK4 tiene error O(h^4) — con L moderado (100-1000) ya tenes alta precision.
Usa el doble paso como verificacion:

```matlab
[x, y] = rk4(f, inter, y0, L);
val_ant = y(end);
[x, y] = rk4(f, inter, y0, L*2);
val = y(end);
error = abs(val - val_ant) / abs(val) < 5e-N   % debe dar 1 (true)
```

### Para encontrar el EXTREMO de una funcion (max o min)
- Error en la POSICION del extremo con max(): es ~ h (lineal en h)
- Error en el VALOR del extremo: es ~ h^2 (mucho menor, nunca es el cuello de botella)

**REGLAS para h segun la POSICION del extremo:**

    N cifras decimales exactas  ->  h < 0.5e-N   (error absoluto < 0.5 * 10^{-N})
    N cifras exactas            ->  h < 5e-N     (error relativo < 5 * 10^{-N}, valido si x_max >= 1)

IMPORTANTE: "x_max" es el VALOR de la coordenada donde ocurre el extremo,
NO el tamaño del intervalo. Ejemplo: intervalo [1.5, 3], maximo en x=1.5329
→ x_max = 1.5329 (no 1.5 que es la longitud).

La condicion "x_max >= 1" se cumple siempre que la variable independiente sea
tiempo en segundos o posicion en metros de orden 1 o mayor (tipico en los finales).
Si x_max fuera muy pequenio (ej: 0.002), la regla 5e-N seria insuficiente y
habria que usar h < 5e-N * x_max.

La condicion de decimales es 10 veces mas estricta que la de cifras exactas.
Si x_max >= 1, cumplir decimales automaticamente cumple cifras exactas tambien.

Tabla de referencia:

| Precision pedida        | h requerido          | L para intervalo de 1.5 m |
| -------------------------| ----------------------| ---------------------------|
| 2 decimales exactos     | h < 0.5e-2 = 0.005   | L > 300                   |
| 2 cifras exactas (x>=1) | h < 5e-2 = 0.05      | L > 30                    |
| 4 decimales exactos     | h < 0.5e-4 = 0.00005 | L > 30000                 |
| 4 cifras exactas (x>=1) | h < 5e-4 = 0.0005    | L > 3000                  |
| 5 decimales exactos     | h < 0.5e-5           | L > 300000                |
| 5 cifras exactas (x>=1) | h < 5e-5             | L > 30000                 |

**En la practica L = 10000 cubre con comodidad 4 cifras exactas o 3 decimales
en la posicion del extremo para la mayoria de los finales.**

---

## 2. La trampa del doble paso para extremos (IMPORTANTE)

El doble paso puede dar FALSO POSITIVO al buscar extremos con max()/min().

**Por que ocurre:** si las dos grillas coinciden en el mismo nodo como maximo,
el error entre ellas es casi cero aunque el resultado real sea incorrecto.

Ejemplo:
- L=100 en [1.5, 3] → h=0.015 → nodo mas cercano al pico: x=1.5300
- L=200 en [1.5, 3] → h=0.0075 → nodo mas cercano: x=1.5300 (mismo!)
- El doble paso dice "convergio" pero el pico real esta en x=1.5329

**Solucion:** arrancar con L grande desde el principio:

```matlab
L = 10000;   % h ~ 10^{-4}, suficiente para 4 decimales
[x, y] = rk4(f, inter, y0, L);
[val_ant, idx] = max(y(:, 1));
pos_ant = x(idx);

[x, y] = rk4(f, inter, y0, L*2);
[val, idx] = max(y(:, 1));
pos = x(idx);

error = norm([val pos] - [val_ant pos_ant], inf) < 5e-4
```

**Si usas while:** arrancar con L >= 1000, no con L = 100:

```matlab
L = 1000;   % NO arrancar con L=100 para extremos
error = inf;
while error >= 5e-4
    % ...
endwhile
```

---

## 3. Decimales exactos vs Cifras exactas

| Concepto | Definicion | Ejemplo con 5.5580 |
|----------|------------|-------------------|
| N decimales exactos | N digitos correctos DESPUES de la coma | 4 decimales: 5.5580 |
| N cifras exactas | N digitos significativos desde el primer no nulo | 5 cifras: 5.5580 |

En codigo:
- N cifras exactas   <->  error relativo < 5e-N
- N decimales exactos  <->  error absoluto < 5e-(N+1)

**Conclusion practica: para x_max >= 1, la misma regla h = 10^{-N} cubre AMBOS casos.**

Si x_max >= 1:
- N cifras exactas requiere error relativo < 5e-N → h/x_max < 5e-N → h < 5e-N * x_max >= 5e-N
- N decimales exactos requiere error absoluto < 5e-(N+1) → h < 5e-(N+1) < 5e-N

Como 5e-(N+1) < 5e-N, la condicion de decimales es mas estricta, y al cumplirla
automaticamente cumlis la de cifras exactas cuando x_max >= 1.

---

## 6. Condicion inicial en RK4 — siempre vector COLUMNA

```matlab
% CORRECTO:
y0 = [5.4; 10.3];     % vector columna (separar con ;)

% ERROR frecuente:
y0 = [5.4  10.3];     % vector fila -> error de dimensiones
% "error: nonconformant arguments (op1 is 2x1, op2 is 2x2)"
```

---

## 7. Cuadrados minimos con modelo no lineal — linearizar algebraicamente

Para un modelo del tipo:
    C(t) = (a*t + b*t^2) * exp(-k*t) / (1 + c*t)

Pasar (1+c*t) multiplicando y agrupar por incognitas:
    C*exp(k*t) = a*(t*exp(-k*t)) + b*(t^2*exp(-k*t)) - c*(t*C)

Las columnas de la matriz de diseno:

```matlab
f1 = t .* exp(-k*t);
f2 = t.^2 .* exp(-k*t);
f3 = -t .* C;          % SIGNO MENOS para que c sea positivo
M = [f1  f2  f3];
coeficientes = M \ C;  % [a; b; c]
```

Errores frecuentes:
- Poner f3 = t*C (sin el signo negativo) → c sale con signo incorrecto
- Usar * en lugar de .* cuando t y C son vectores

---

## 8. Evaluacion de la derivada/aceleracion en un nodo de RK4

Si ya tenes la solucion RK4 y necesitas y'(t) en un punto que coincide con un nodo:

```matlab
[t, y] = rk4(f, inter, y0, L);

% La aceleracion en t=30 (si 30 es nodo de la grilla):
idx_30 = find(abs(t - 30) < 1e-9);
derivada_30 = f(30, y(idx_30, :));
aceleracion = derivada_30(2);   % componente 2 para sistema de 2 ecuaciones
```

Esto es mas directo y preciso que aproximar con diferencias finitas sobre y.

---

## 9. Cuadro resumen: doble paso vs while

| Situacion | Recomendacion |
|-----------|---------------|
| Solucion en punto fijo (T(2), C(30)) | Doble paso, L pequeno OK |
| Extremo de una funcion (posicion+valor) | Doble paso con L grande (L >= 10000 para 4 cifras) |
| Extremo con while | Arrancar desde L >= 1000, no L=100 |
| Integracion numerica (trapcomp, simpsoncomp) | Doble paso simple |
| Metodo iterativo (Newton, Gauss-Seidel) | while siempre |

---

*Ultima actualizacion: Julio 2026 - basado en revision de finales 2025-2026*
