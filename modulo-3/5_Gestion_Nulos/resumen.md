## Tipos de nulos

- **NaN (Not a Number):** Puede aparecer en columnas numéricas y en algunas columnas de tipo objeto. Pandas utiliza la constante np.nan (importando numpy como np) para representar estos valores.

- **None:** A diferencia de NaN, None es una constante de Python y no una representación numérica, por lo que lo podremos encontrar en columnas de tipo objeto.

- **Valores especiales de datos:** En algunos conjuntos de datos, los valores nulos pueden tener representaciones específicas. Por ejemplo, en un conjunto de datos de encuestas, el valor "NA" o "N/A" podría utilizarse para denotar valores faltantes.

- **Valores vacíos o en blanco:** En columnas de texto, es posible que los valores nulos simplemente sean cadenas vacías o espacios en blanco.

- **Valores especiales:** En algunos casos, se pueden usar valores especiales que actúan como "marcadores" de nulos. Por ejemplo, usar un valor como -1 o 999 para indicar un valor faltante.

- **NaT (Not a Timestamp):** Se utilizan para denotar fechas y horas faltantes o desconocidas.

## Causas por las que existen nulos

- Errores en la recopilación de datos
- Falta de respuesta
- Datos incompletos.
- Fallos en la transmisión de datos.


## Hoja de Ruta para tratar nulos

1. Identificamos variables del df con nulos.
    ```python
    nulos = df.isnull().sum()
    ```
2. Diferenciación entre variables categóricas y numéricas.
3. Aplicación de estrategias dependiendo de distintos factores:
   - Importancia de las variables dentro del análisis:
     - SI importante: se queda
     - NO importante: se elimina 
   - Tipo de variables:
     - Categóricas:
       - % ALTO nulos:
         - se imputan con la moda
         - se imputan con técnicas más avanzadas
       - % BAJO nulos:
         - distribución de categoría dominante -> imputación con la moda
         - distribución no dominante -> nueva categoría
     - Numéricas:
       - % ALTO nulos:
         - se imputan con técnicas más avanzadas
       - % BAJO nulos:
         - distribución simétrica: imputación con la media
         - distribución asimétrica: imputación con la mediana


En resumen, tenemos en cuenta: relevancia de la variable, tipo de variable, % nulos.

## 🤖 Técnicas Avanzadas de Imputación

Usamos técnicas avanzadas de imputación por varias razones importantes:

1. Preservar las relaciones entre variables
   - Los métodos simples (media, mediana, moda) ignoran la relación con otras variables. 
   - Las técnicas avanzadas consideran:
     - Correlaciones entre columnas
     - Patrones ocultos en los datos
     - Ejemplo: Si falta el salario de alguien, técnicas como KNN pueden estimarlo basándose en edad, educación, experiencia, etc.
2. Cuando hay MUCHOS nulos (% ALTO)
   - Imputar todo con media/mediana distorsiona la distribución original
   - Reduce artificialmente la varianza
   - Crea un "pico" irreal en ese valor
   - Las técnicas avanzadas mantienen mejor la distribución natural
3. Mejorar la calidad predictiva
   - Si vas a hacer un modelo de ML(Machine Learning) después:
     - Imputaciones simples pueden introducir sesgo
     - Técnicas avanzadas generan valores más realistas
     - Mejoran el rendimiento del modelo final




### 1️⃣ **KNN Imputer** (K-Nearest Neighbors)

#### ¿Qué es?
Imputa valores faltantes usando los **K vecinos más similares** (filas parecidas).

#### ¿Cómo funciona?

Ejemplo visual: Queremos imputar la edad de Juan (fila con ?)

   Nombre  Edad  Salario  Experiencia
0  Ana     25    30000    2
1  Luis    30    45000    5
2  Juan    ?     32000    3  ← Fila con nulo
3  María   28    35000    4
4  Pedro   45    80000    20

KNN busca las K=2 filas más similares a Juan (comparando Salario y Experiencia)
- Vecinos más cercanos: Ana (25) y María (28)
- Edad imputada = promedio = (25 + 28) / 2 = 26.5

#### Código:
```python

from sklearn.impute import KNNImputer

# n_neighbors = número de vecinos a considerar
imputer = KNNImputer(n_neighbors=5)
df[['edad', 'salario']] = imputer.fit_transform(df[['edad', 'salario']])
```


### 2️⃣ **Iterative Imputer** 

Usa **modelos de regresión** para predecir valores faltantes de forma iterativa.

>La regresión es un tipo de modelo ML que predice un valor numérico basándose en la relación entre variables. 

#### ¿Cómo funciona?
```python
# Proceso iterativo:

# Iteración 1:
# - Imputa 'edad' usando regresión con otras variables
# - Imputa 'salario' usando regresión con otras variables (incluyendo edad imputada)

# Iteración 2:
# - Re-imputa 'edad' con los nuevos valores de 'salario'
# - Re-imputa 'salario' con los nuevos valores de 'edad'

# ... repite hasta convergencia (max_iter)
```

#### Código:

```python
from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import IterativeImputer

# max_iter = número máximo de iteraciones
# random_state = semilla para reproducibilidad
imputer = IterativeImputer(max_iter=10, random_state=42)
df[['edad', 'salario', 'experiencia']] = imputer.fit_transform(
    df[['edad', 'salario', 'experiencia']]
)
```
## 📊 Comparación Visual

| Característica | KNN Imputer | Iterative Imputer |
|----------------|-------------|-------------------|
| **Método** | Vecinos similares | Regresión iterativa |
| **Velocidad** | Rápido (datasets pequeños) | Más lento |
| **Dataset ideal** | Pequeño/Mediano | Grande/Multivariable |
| **Precisión** | Buena | Muy buena |
| **Complejidad** | Simple | Compleja |

---

## 🎯 ¿Cuándo usar cada uno?

### Usa **KNN Imputer** cuando:
- Dataset pequeño/mediano (<10,000 filas)
- Variables tienen **correlaciones lineales** claras
- Necesitas algo rápido y simple
- No sabes cómo se relacionan las variables

### Usa **Iterative Imputer** cuando:
- Dataset grande o con **muchas variables**
- Relaciones **complejas/no lineales** entre variables
- Buscas **máxima precisión**
- Tienes tiempo de procesamiento

### Si tienes dudas:
1. **Dataset pequeño/mediano** → Empieza con **KNN Imputer**
2. **Dataset grande o necesitas precisión** → Usa **Iterative Imputer**

---

## 🔧 Resumen de todas las técnicas

```python
# 1. ELIMINACIÓN
df.drop('columna', axis=1)  # Eliminar columna
df.dropna()  # Eliminar filas con nulos

# 2. IMPUTACIÓN SIMPLE
df['col'].fillna(valor)  # Manual y rápido

# 3. SIMPLE IMPUTER (media, mediana, moda)
from sklearn.impute import SimpleImputer
imputer = SimpleImputer(strategy='mean')  # 'median', 'most_frequent'
df[['col']] = imputer.fit_transform(df[['col']])

# 4. KNN IMPUTER (vecinos similares)
from sklearn.impute import KNNImputer
imputer = KNNImputer(n_neighbors=5)
df[['col1', 'col2']] = imputer.fit_transform(df[['col1', 'col2']])

# 5. ITERATIVE IMPUTER (regresión iterativa)
from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import IterativeImputer
imputer = IterativeImputer(max_iter=10, random_state=42)
df[['col1', 'col2']] = imputer.fit_transform(df[['col1', 'col2']])
```

---

## 💡 Diferencias clave: fillna() vs SimpleImputer

**fillna():**
- Rápido y directo
- Para manipulación manual
- No guarda el "imputer" para reutilizar

**SimpleImputer:**
- Para pipelines de ML
- **Reproducible** (puedes aplicar la misma estrategia a datos nuevos)
- Más profesional en producción

```python
# fillna: uso único
df['edad'].fillna(df['edad'].mean())

# SimpleImputer: reutilizable
imputer = SimpleImputer(strategy='mean')
imputer.fit(df_train[['edad']])
df_train[['edad']] = imputer.transform(df_train[['edad']])
df_test[['edad']] = imputer.transform(df_test[['edad']])  # Misma media
```