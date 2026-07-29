# Resumen de Métodos Iterativos (Trabajo Práctico 3)

Este documento contiene un resumen de las funciones optimizadas para la resolución de sistemas de ecuaciones lineales $Ax = b$ mediante los métodos iterativos clásicos: Jacobi, Gauss-Seidel y SOR.

## Mejoras Implementadas
1. **Vectorización Completa:** Se eliminaron los bucles `for` anidados que calculaban componente a componente. Ahora el cálculo en cada iteración se realiza mediante operaciones vectoriales/matriciales nativas, usando divisiones elemento a elemento (`./`) o el operador `\` para sustituciones hacia adelante muy eficientes.
2. **Corrección de Firmas:** Las firmas de las funciones se adaptaron estrictamente a lo solicitado por la cátedra: devolviendo siempre la tupla de salidas `[x, it, r_h]`.
3. **Cálculo del Residuo Relativo (Criterio de Parada):** Se estandarizó el cálculo del error por iteración usando la norma infinito del incremento relativo (tal como indica el ejercicio 3a): $\frac{||x^{(k)} - x^{(k-1)}||_\infty}{||x^{(k)}||_\infty}$.
4. **Documentación:** Se agregaron docstrings (cabeceras de ayuda) estandarizados a cada función para explicar sus argumentos y retornos.

---

## 1. Método de Jacobi (`jacobi.m`)
**Firma:** `function [x, it, r_h] = jacobi(A, b, x0, maxit, tol)`

### Implementación Vectorizada
Descomponiendo $A = D + R$ (donde $D$ es la diagonal y $R$ es el resto, $R = L + U$), la iteración se escribe vectorialmente como:
$$ x^{(k+1)} = D^{-1} (b - R x^{(k)}) $$

En Octave, como $D$ es diagonal, se divide directamente cada componente por el valor de la diagonal, logrando que no existan ciclos explícitos:
```octave
d = diag(A);
R = A - diag(d);
% Dentro del bucle while/for
x = (b - R * x0) ./ d;
```

---

## 2. Método de Gauss-Seidel (`gauss_seidel.m`)
**Firma:** `function [x, it, r_h] = gauss_seidel(A, b, x0, maxit, tol)`

### Implementación Vectorizada
Descomponiendo $A = (D + L) + U$, donde $D+L$ es la matriz triangular inferior de $A$, la iteración se escribe como:
$$ (D + L) x^{(k+1)} = b - U x^{(k)} $$

Esto es un sistema triangular que en Octave se resuelve de forma ultra eficiente (Sustitución hacia adelante) mediante el operador `\`:
```octave
DL = tril(A);
U = triu(A, 1);
% Dentro del bucle while/for
x = DL \ (b - U * x0);
```

---

## 3. Método SOR (`sor.m`)
**Firma:** `function [x, it, r_h] = sor(A, b, x0, maxit, tol, w)`

### Implementación Vectorizada
El método de Relajación Sucesiva (SOR) se plantea a partir de la ponderación con $\omega$.
Matricialmente, la iteración es:
$$ (D + \omega L) x^{(k+1)} = \omega b - (\omega U + (\omega - 1) D) x^{(k)} $$

Se arman las matrices `M` (triangular inferior) y `N`, y se resuelve vectorialmente:
```octave
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);
M = D + w * L;
N = w * U + (w - 1) * D;
% Dentro del bucle while/for
x = M \ (w * b - N * x0);
```

---

## Modificación de Scripts de Prueba
Se actualizaron los scripts `eje4.m`, `eje6.m`, `eje7.m` y `eje8.m` para:
- Importar las funciones del directorio raíz usando `addpath('..')`, asegurando una única fuente de verdad (DRY).
- Ajustar los nombres de invocación a los nuevos y correctos: `jacobi` y `sor` (reemplazando `jacobbi` y `SOR` respectivamente).
