# 📋 PROYECTO: Sistema de Pronósticos de Fútbol
### Documentación completa — v2.0 (SPA funcional)

---

## 📌 Tabla de contenidos

1. [¿Qué es este proyecto?](#1-qué-es-este-proyecto)
2. [Estado actual de la aplicación](#2-estado-actual-de-la-aplicación)
3. [¿Cómo funciona el archivo index.html?](#3-cómo-funciona-el-archivo-indexhtml)
4. [Estructura detallada de la interfaz](#4-estructura-detallada-de-la-interfaz)
5. [Las columnas de la tabla y qué significan](#5-las-columnas-de-la-tabla-y-qué-significan)
6. [Sistema de quinielas de cobertura automática](#6-sistema-de-quinielas-de-cobertura-automática)
7. [Sistema de usuarios y login](#7-sistema-de-usuarios-y-login)
8. [Sistema de porcentajes de venta y semáforo de riesgo](#8-sistema-de-porcentajes-de-venta-y-semáforo-de-riesgo)
9. [Pestaña de Inteligencia Artificial](#9-pestaña-de-inteligencia-artificial)
10. [Pestaña de Propuestas](#10-pestaña-de-propuestas)
11. [Todo el código explicado función por función](#11-todo-el-código-explicado-función-por-función)
12. [Dónde se guardan los datos hoy](#12-dónde-se-guardan-los-datos-hoy)
13. [Migración a API REST — El nuevo proyecto](#13-migración-a-api-rest--el-nuevo-proyecto)
14. [Arquitectura del backend (servidor)](#14-arquitectura-del-backend-servidor)
15. [Base de datos — Tablas y relaciones](#15-base-de-datos--tablas-y-relaciones)
16. [API REST — Todos los endpoints](#16-api-rest--todos-los-endpoints)
17. [Seguridad — Autenticación con JWT](#17-seguridad--autenticación-con-jwt)
18. [Proxy seguro para IA](#18-proxy-seguro-para-ia)
19. [Cambios en el frontend](#19-cambios-en-el-frontend)
20. [Pasos de implementación (plan de trabajo)](#20-pasos-de-implementación-plan-de-trabajo)
21. [Cómo levantar el proyecto en tu computadora](#21-cómo-levantar-el-proyecto-en-tu-computadora)
22. [Glosario de términos técnicos](#22-glosario-de-términos-técnicos)

---

## 1. ¿Qué es este proyecto?

Este es un **sistema de pronósticos de fútbol** (quiniela) construido como una aplicación web SPA (Single Page Application). Permite que un grupo de personas registren sus predicciones para partidos de fútbol, compare resultados en tiempo real y obtenga análisis de inteligencia artificial sobre cada partido.

### ¿Qué puede hacer?

- 📂 **Cargar una quiniela desde Excel** (.xlsx, .xls, .ods, .csv) — con selector de hoja si el archivo tiene varias
- ⚽ **Ver y editar resultados en vivo** — al terminar cada partido
- 👥 **Añadir o eliminar jugadores** sin recargar el archivo
- 📊 **Ver el marcador** de aciertos por jugador con medallas y rachas
- 🔍 **Comparar dos jugadores** entre sí (panel 1v1)
- 🏷 **Ingresar el resultado esperado** por partido (L/E/V o dobles LE/LV/EV/T) y calcular análisis automático
- 🚦 **Ver un semáforo de riesgo** que indica qué partidos son más peligrosos
- ⚠️ **Filtrar divergencias** — partidos donde el grupo apuesta diferente a lo esperado
- ⊞ **Ocultar columnas de jugadores** para ver solo las columnas de análisis
- 🤖 **Consultar a ChatGPT o Gemini** para obtener predicciones con justificación
- 🏆 **Guardar el historial** de concursos ganados
- 🎟 **Generar propuestas de boletos** optimizadas para maximizar cobertura
- 🌙 **Modo oscuro / claro**
- 📱 **Funciona en celular** (diseño responsivo, min-height 44px en elementos táctiles)

---

## 2. Estado actual de la aplicación

### Versión actual: SPA funcional (todo en index.html)

La app vive **enteramente en un archivo HTML** llamado `index.html`. Contiene el diseño visual (HTML + CSS), toda la lógica de negocio (JavaScript), el sistema de usuarios y los datos de la quiniela (guardados en localStorage del navegador).

### Funcionalidades implementadas ✅

| Funcionalidad | Descripción |
|---|---|
| **Carga de Excel** | Soporta .xlsx, .xls, .ods, .csv. Detecta automáticamente la columna "Porcentajes" y la carga como datos de resultado esperado. Si el archivo tiene múltiples hojas, muestra un modal de selección. |
| **Columna Esperado** | Reemplazó la columna `% Venta` con un picker de un solo valor ganador (L/E/V/LE/LV/EV/T). Se puede ingresar manualmente o se auto-detecta del Excel. |
| **Picker de resultado esperado** | Picker flotante con 2 filas: simples (L/E/V) y dobles/triple (LE/LV/EV/T/✕). Soporta apuestas de cobertura de múltiples resultados. |
| **Quinielas de cobertura automática** | 5 boletos ("Cobertura 1–5") generados automáticamente para cubrir todas las combinaciones posibles. Se excluyen de los cálculos de Consenso, Nadie espera y Menos apostado. |
| **Orden de columnas especiales** | El orden es siempre: `Riesgo | Consenso | Nadie espera | Menos apostado | Esperado | CvsE` (consistente en thead, tbody y tfoot). |
| **Cards de métricas especiales** | En el marcador de aciertos aparecen cards especiales para `🗳️ Consenso` y `🏷 Esperado` cuando superan el umbral mínimo (>7 aciertos en principal, >5 en revancha). Con estilo dashed diferenciado. |
| **Toggle de columnas clave** | Botón `⊞ Cols. clave` que oculta todas las columnas de jugadores para ver solo las columnas de análisis. |
| **Onboarding / estado vacío** | Si no hay datos, se muestra un panel de bienvenida con 3 pasos visuales. |
| **Hint de tap en encabezados** | En dispositivos táctiles, aparece un hint en el primer uso indicando que se puede tocar el encabezado para comparar. Se guarda en localStorage para no repetirlo. |
| **Cards colapsadas en marcador** | Solo se muestran los 3 primeros jugadores; un botón "Ver todos (N)" expande el resto. |
| **Badges en pestañas** | Badge naranja en `🎟 Propuestas` y `🏆 Ranking` cuando tienen contenido. |
| **Ícono de edición en táctil** | El ícono `✎` aparece permanentemente en celdas editables en dispositivos touch (`@media (hover: none)`). |
| **Modal de confirmación al limpiar** | Antes de limpiar los datos, se pide confirmación con un modal. |
| **Migración automática de formato** | El formato antiguo de `_ventaPcts` (`{L, E, V}` numérico) se migra automáticamente al nuevo formato (`{ganador: 'L'|'E'|...}`) al cargar desde localStorage. |
| **Selector de hoja de Excel** | Si el archivo .xlsx tiene múltiples hojas, se muestra un modal para elegir cuál usar. |
| **Exportar a Excel** | Exporta la tabla actual a .xlsx con los datos de pronósticos y resultados. |
| **Exportar propuestas** | Exporta los boletos de propuestas generados a .xlsx. |
| **Historial de archivos recientes** | Muestra los últimos 5 archivos cargados con botón para recargarlos. |
| **Pestaña de Propuestas** | Genera boletos optimizados con configuración de presupuesto, estrategia, número de dobles y selección de jugadores. |
| **Panel 1v1** | Compara pronósticos de dos jugadores partido a partido con estadísticas de coincidencia. |
| **Ranking histórico** | Guarda concursos pasados con clasificación; filtra por quiniela o revancha. |
| **Revancha** | Detecta automáticamente una sección REVANCHA en el Excel y la renderiza como tabla separada. |

---

## 3. ¿Cómo funciona el archivo index.html?

Imagina el archivo como tres capas apiladas:

```
┌──────────────────────────────────────────┐
│  CAPA 1: HTML                            │
│  Define la estructura: tablas, botones,  │
│  modales, pestañas, formularios          │
├──────────────────────────────────────────┤
│  CAPA 2: CSS                             │
│  Define cómo se ve: colores, tamaños,    │
│  el tema oscuro, animaciones, responsivo │
├──────────────────────────────────────────┤
│  CAPA 3: JavaScript                      │
│  Define qué hace: leer Excel, calcular   │
│  aciertos, llamar a la IA, guardar datos │
└──────────────────────────────────────────┘
```

### Librerías externas que usa

| Librería | Para qué sirve |
|---|---|
| **SheetJS (xlsx)** | Leer y escribir archivos Excel |
| **Inter (Google Fonts)** | La tipografía de la interfaz |

---

## 4. Estructura detallada de la interfaz

### Las 4 pestañas

```
[ ⚽ Quiniela ] [ 🏆 Ranking Histórico ] [ 🤖 IA Pronósticos ] [ 🎟 Propuestas ]
```

#### Pestaña ⚽ Quiniela

Esta es la pestaña principal. Tiene estos bloques de arriba a abajo:

```
┌─────────────────────────────────────────────┐
│ Encabezado: título, badge "LIVE · QUINIELAS" │
├─────────────────────────────────────────────┤
│ Barra de usuario: sesión, tema, salir        │
├─────────────────────────────────────────────┤
│ Barra de herramientas:                       │
│  [📂 Cargar archivo] [↓ Exportar] [⚔ 1v1]   │
│  [+ Jugador] [− Jugador] [⚠️ Divergencias]  │
│  [⊞ Cols. clave] [✕ Limpiar] [🔍 Buscar]   │
│  [Filtro aciertos]                           │
├─────────────────────────────────────────────┤
│ Historial de archivos recientes              │
├─────────────────────────────────────────────┤
│ Onboarding (si no hay datos cargados)        │
├─────────────────────────────────────────────┤
│ Banner de info: nombre archivo, jugadores,   │
│  partidos jugados, pendientes, revancha      │
├─────────────────────────────────────────────┤
│ TABLA PRINCIPAL (scroll horizontal)          │
├─────────────────────────────────────────────┤
│ Cards de aciertos (marcador):                │
│  - Top 3 visible siempre                     │
│  - "Ver todos (N)" para expandir             │
│  - Cards especiales: 🗳️ Consenso, 🏷 Esp.  │
├─────────────────────────────────────────────┤
│ Panel comparación 1v1 (opcional)             │
├─────────────────────────────────────────────┤
│ Sección REVANCHA (si el Excel la tiene)      │
└─────────────────────────────────────────────┘
```

#### Pestaña 🏆 Ranking Histórico

Guarda los resultados de concursos pasados. Solo muestra jugadores que hayan tenido **más de 9 aciertos**. Se navega a esta pestaña automáticamente al guardar un concurso. Permite filtrar por quiniela normal vs revancha y eliminar concursos.

#### Pestaña 🤖 IA Pronósticos

Se divide en dos sub-secciones:
- **Quiniela principal** — análisis IA de los partidos normales
- **Revancha** — análisis IA de los partidos de revancha (aparece solo si hay revancha)

Soporta ChatGPT (gpt-4o-mini) y Google Gemini (gemini-1.5-flash). Incluye modo demo sin API key.

#### Pestaña 🎟 Propuestas

Genera hasta 10 boletos de quiniela optimizados. Permite configurar:
- **Modo**: automático (todos los jugadores) o manual (selección de jugadores)
- **Presupuesto**: en pesos mexicanos
- **Estrategia**: balanceada, agresiva o defensiva
- **Número de dobles**: 0–4
- **Sección**: quiniela principal o revancha

Muestra una vista previa de los boletos, las opciones no cubiertas y permite exportar a Excel.

### Los modales (ventanas emergentes)

| Modal | Para qué |
|---|---|
| Añadir jugador | Alta de nuevo participante con sus pronósticos iniciales |
| Eliminar jugador | Baja con selección visual del jugador |
| Guardar concurso | Guarda en el ranking con número de concurso |
| Gestión de usuarios | Ver, agregar y borrar usuarios (solo admin) |
| Cambiar contraseña | Cualquier usuario puede cambiar la suya |
| Selector de hoja | Elige qué hoja usar si el Excel tiene varias |
| Confirmación limpiar | Confirma antes de borrar todos los datos |
| Confirmar eliminar concurso | Confirma antes de borrar un concurso del ranking |

---

## 5. Las columnas de la tabla y qué significan

La tabla se genera dinámicamente según cuántos jugadores haya. El orden de columnas es siempre:

| Posición | Columna | Qué muestra | Cómo interactuar |
|---|---|---|---|
| 1 | **#** | Número del partido | Solo lectura |
| 2 | **Partido** | Nombre del encuentro (ej. "Cruz Azul vs América") | Solo lectura |
| 3 | **Resultado** | El resultado real del partido (L/E/V) | **Clic → picker de resultado** |
| 4…N | **[Jugadores]** | El pronóstico de cada jugador; borde verde si acertó | Solo lectura |
| N+1 | **🚦 Riesgo** | Semáforo 🔴🟡🟢⚪ según señales de peligro | Solo lectura, hover/tap para detalle |
| N+2 | **🗳️ Consenso** | El resultado que eligió la mayoría del grupo, con su % de acuerdo | Solo lectura |
| N+3 | **🚫 Nadie espera** | Resultados que ningún jugador apostó | Solo lectura |
| N+4 | **📉 Menos apostado** | El resultado con menos votos del grupo | Solo lectura |
| N+5 | **🏷 Esperado** | El resultado con mayor % de venta (L/E/V/LE/LV/EV/T) | **Clic → picker de resultado esperado** |
| N+6 | **⚖️ CvsE** | Compara qué dijo el consenso del grupo vs el resultado esperado | Solo lectura |

> **Nota importante:** Las quinielas de cobertura automática ("Cobertura 1–5") aparecen en columnas de jugadores pero **no participan** en los cálculos de Consenso, Nadie espera ni Menos apostado. Solo los jugadores reales contribuyen a esos análisis.

### ¿Qué significa cada badge?

- `L` = Local gana (azul)
- `E` = Empate (amarillo)
- `V` = Visitante gana (verde)
- `LE`, `LV`, `EV` = Doble (apuesta por dos resultados posibles; morado claro)
- `T` = Triple (apuesta por cualquier resultado; morado)
- `?` = Sin pronóstico (gris)

---

## 6. Sistema de quinielas de cobertura automática

### ¿Qué son?

Son 5 boletos generados automáticamente con el prefijo **"Cobertura N"** (ej. "Cobertura 1", "Cobertura 2"…). Se añaden al final de la lista de participantes y son visibles como columnas en la tabla.

### ¿Para qué sirven?

Cubren de forma sistemática las combinaciones más importantes de pronósticos. Se usan como referencia visual para ver cómo se distribuiría la cobertura de resultados, pero **no distorsionan el análisis de los jugadores reales**.

### Exclusión de cálculos de análisis

Los boletos de cobertura se filtran automáticamente antes de calcular:
- **Consenso**: se usa `pronosticosReales` (sin cobertura)
- **Nadie espera**: se usa `pronosticosReales`
- **Menos apostado**: se usa `pronosticosReales`

### Constantes relacionadas

```javascript
const AUTO_PRONOSTICO_PREFIX = 'Cobertura ';  // prefijo para identificarlos
const AUTO_PRONOSTICO_COUNT  = 5;             // cuántos boletos se generan
const MAX_DOBLES_COBERTURA   = 4;             // máximo de dobles por boleto
const MAIN_TICKET_COST       = 15;            // costo unitario quiniela principal
const REV_TICKET_COST        = 5;             // costo unitario revancha
```

---

## 7. Sistema de usuarios y login

### ¿Cómo funciona hoy?

El sistema de login es completamente **local al navegador**. Los usuarios y contraseñas se guardan en `localStorage` del navegador, en texto sin cifrar.

**Usuario por defecto al instalar:**
- Usuario: `admin`
- Contraseña: `admin`

### Roles

| Rol | Puede hacer |
|---|---|
| `admin` | Todo + gestionar otros usuarios |
| `user` | Todo excepto gestionar usuarios |

### ⚠️ Limitación importante

Las contraseñas se guardan **sin cifrar** en el navegador. En la migración a API REST, esto se reemplaza por autenticación con **tokens JWT** y contraseñas cifradas con bcrypt.

---

## 8. Sistema de porcentajes de venta y semáforo de riesgo

### ¿Qué es el resultado esperado?

Es el resultado que "espera el mercado" según los datos del concurso oficial. Puede ser un resultado simple (L, E, V) o uno compuesto (LE, LV, EV, T) si el mercado está muy dividido.

### ¿Cómo se ingresa?

Al hacer clic en cualquier celda de la columna **🏷 Esperado**, aparece un picker flotante con:
- **Fila 1** (simples): L / E / V
- **Fila 2** (dobles/triple): LE / LV / EV / T / ✕ (borrar)

El resultado esperado también se **detecta automáticamente** del Excel si existe una columna llamada "Porcentajes" en el encabezado.

### Formato de almacenamiento

```javascript
_ventaPcts[tableKey][rowIdx] = { ganador: 'L' }   // simple
_ventaPcts[tableKey][rowIdx] = { ganador: 'LE' }  // doble
_ventaPcts[tableKey][rowIdx] = { ganador: 'T' }   // triple
```

> **Migración automática:** el formato anterior `{ L: 45, E: 20, V: 35 }` se convierte automáticamente al nuevo formato `{ ganador: 'X' }` al cargar desde localStorage.

### ¿Cómo funciona el semáforo?

El semáforo evalúa **3 señales de peligro** por partido:

```
Señal 1: ¿El consenso del grupo apunta diferente al resultado esperado?
          Ej: el grupo dice "L" pero el esperado es "V" → ⚠️

Señal 2: ¿El consenso del grupo es débil? (menos del 60% coincide)
          Ej: L=40%, E=35%, V=25% → el grupo está muy dividido → ⚠️

Señal 3: ¿Hay algún resultado que ningún jugador apostó?
          Ej: nadie apostó "V" → si gana el visitante, nadie gana → ⚠️
```

| Señales de peligro | Semáforo | Significado |
|---|---|---|
| 0 | 🟢 | Partido seguro |
| 1 | 🟡 | Partido con precaución |
| 2 o más | 🔴 | Partido de alto riesgo |
| Sin datos | ⚪ | No se puede evaluar |

### La columna CvsE (Consenso vs Esperado)

Compara qué dijo el consenso del grupo vs el resultado esperado. Usa `pronosticoContiene()` para comparar, por lo que si el esperado es "LE" y el consenso es "L", se considera que **sí coincide**.

### El botón de divergencias

Cuando el consenso del grupo apunta diferente al resultado esperado, aparece el botón `⚠️ Divergencias [N]`. Al hacer clic, la tabla filtra y muestra **solo esos partidos problemáticos**, resaltados en amarillo.

---

## 9. Pestaña de Inteligencia Artificial

### ¿Qué hace?

Envía la lista de partidos a ChatGPT o a Google Gemini y recibe de vuelta:
- Una predicción por partido (L, E o V)
- Un nivel de confianza (del 50% al 95%)
- Una justificación en texto

### Modelos soportados

| Modelo | Versión | Costo |
|---|---|---|
| OpenAI ChatGPT | `gpt-4o-mini` | Bajo (de pago) |
| Google Gemini | `gemini-1.5-flash` | Gratuito con límites |

### El modo demo

Si no tienes API key, el botón **★ Demo** genera resultados simulados con predicciones y justificaciones aleatorias. Sirve para ver cómo lucirá la interfaz.

### ⚠️ Seguridad actual

La API key se guarda en `localStorage` del navegador y se envía directamente al proveedor de IA. En la migración a API REST, la key vivirá en el **servidor** y el navegador nunca la verá.

---

## 10. Pestaña de Propuestas

### ¿Qué hace?

Genera combinaciones y boletos de quiniela matemáticamente optimizados para maximizar la probabilidad y certeza de premio, respetando un presupuesto dado mediante Ensamble Bayesiano, Entropía de Shannon y Matrices de Sistemas Reducidos.

### 💡 Asistente Inteligente de Sugerencias de Dobles y Triples

La aplicación analiza automáticamente la incertidumbre estadística y entropía $H(X)$ de cada partido:
- **Triples Sugeridos (`T`)**: Detecta partidos de incertidumbre extrema (paridad de 3 signos o partidos trampa) que justifican cubrir con Triple.
- **Dobles Sugeridos (`LE`, `LV`, `EV`)**: Identifica partidos parejos entre dos signos dominantes o con valor esperado positivo ($EV+$), recomendando la combinación exacta de dos resultados.
- **Fijos Recomendados (`L`, `E`, `V`)**: Identifica favoritos sólidos para no malgastar presupuesto en coberturas innecesarias.
- **Acciones Rápidas**:
  - `🔒 Aplicar a Candados`: Carga los dobles y triples sugeridos en los candados interactivos con un solo clic.
  - `⚡ Auto-Configurar Plan`: Ajusta el modo de reducción y presupuesto ideal para cubrir las sugerencias detectadas.

### 🛡️ Auditoría, Dashboard Ejecutivo y Validación de Calidad

- **Dashboard Ejecutivo Unificado (`.prop-dashboard-banner`)**: Integra en una sola tarjeta de control las métricas de inversión (Boletos, Fijos/Dobles/Triples, Costo, Restante, Ahorro/Probabilidad) junto con el **Sello de Calidad Matemática** y aciertos esperados ($E[\text{Hits}]$), eliminando componentes dispersos.
- **Cabecera de Tabla Compacta (`.prop-th-card`)**: Agrupa título de propuesta, perfil de juego, score de validación y micro-radar de balance `%L/%E/%V` en una tarjeta de cabecera compacta de ~55px de alto con tooltip enriquecido, evitando la sobrecarga visual de la tabla.
- **Score de Calidad Matemática (0-100 pts)**:
  - **Esperanza de Aciertos ($E[\text{Hits}]$)**: Mide cuántos partidos se espera acertar por boleto según la probabilidad compuesta.
  - **Badges de Validación**: `⭐ Óptima (Validada)`, `✨ Alto Valor`, `⚖️ Equilibrada`, `⚠️ Revisar Cobertura`.
  - **Radar de Balance & Detector de Anomalías**: Monitorea el equilibrio `%L | %E | %V` y previene combinaciones estadísticamente inverosímiles (ej. 12 empates o rachas imposibles).

### 🎯 Guía de Selección y Perfiles de Propuestas ("¿Cuál boleto jugar?")

La aplicación clasifica y etiqueta cada propuesta para orientar tu decisión de juego:
- **🏆 La Mejor Opción Global (`MEJOR OPCIÓN`)**: Boleto con el balance óptimo entre alta probabilidad de premio, valor esperado ($EV+$) y costo. Recomendado como boleto titular.
- **🎯 La Más Confiable / Segura (`MÁS CONFIABLE`)**: Boleto con menor varianza y mayor cobertura de favoritos sólidos. Ideal para asegurar cobro en premios de consolación (10 a 12 aciertos).
- **🔥 La Más Arriesgada / Cazadora de Bolsa (`MÁS ARRIESGADA`)**: Boleto diseñado para buscar la bolsa millonaria en solitario mediante sorpresas calculadas en partidos de alta divergencia.
- **⚖️ Opción Equilibrada (`EQUILIBRADA`)**: Boletos complementarios con diversificación armónica para apuestas en grupo o matrices reducidas.
- **Botón `📋 Copiar este Boleto`**: Copia instantánea de los pronósticos de la opción elegida al portapapeles.

### Modos de Distribución de Coberturas

| Modo | Descripción |
|---|---|
| **🎯 Sistema Reducido al 13** | Matrices oficiales Progol con garantía matemática del 100% de $\ge 13$ aciertos a una fracción del costo directo múltiple (ahorro del 80%+). |
| **🧠 Auto Inteligente** | Distribuye dobles y triples directos en boletos múltiples optimizados por programación dinámica. |
| **⚙️ Manual (Solo Dobles)** | Control manual sobre el número de dobles fijos por boleto. |

### Estrategias Matemáticas

| Estrategia | Descripción |
|---|---|
| **Multiestrategia Híbrida** | Portafolio diversificado que combina enfoques Bayesiano, Shannon y balanceado. |
| **Entropía de Shannon** | Prioriza dobles/triples en partidos de máxima incertidumbre $H(X)$ y fija favoritos claros. |
| **Ensamble Bayesiano EV+** | Maximiza la ganancia marginal de probabilidad y valor estadístico frente al mercado. |
| **Equilibrada** | Distribución de cobertura y varianza estándar. |
| **Mayor Cobertura** | Maximiza la distancia de Hamming para abarcar el mayor espectro de combinaciones. |
| **Conservadora** | Prioriza la máxima probabilidad acumulada en los favoritos. |

### Exportación y Portapapeles

- Botón `📋 Copiar` individual por propuesta para compartir al instante en WhatsApp / Telegram.
- Exportación completa a Excel (.xlsx) con resumen de costos y pronósticos.

---

## 11. Todo el código explicado función por función

### 11.1 Variables globales (el "estado" de la aplicación)

```javascript
let _mainRows = []
// Array de arrays. Cada fila representa un partido.
// _mainRows[0] = ["Cruz Azul vs América", "L", "L", "E", "V"]
//  posición 0 = nombre del partido
//  posición 1 = resultado real
//  posición 2+ = pronósticos de cada jugador

let _revanchaRows = []
// Igual que _mainRows pero para la sección de Revancha.

let _participants = []
// Lista de nombres de los jugadores en orden.
// Incluye los boletos de cobertura automática al final.
// Ejemplo: ["Carlos", "María", "Cobertura 1", "Cobertura 2"...]

let _fileName = ''
// Nombre del último archivo Excel cargado.

let _lastSortedParticipants = []
let _lastSortedHits = []
let _lastTotalWithResult = 0
// Guardan el ranking del último render para "Guardar concurso".

let _ventaPcts = { main: {}, rev: {} }
// Porcentajes de venta / resultado esperado por partido.
// _ventaPcts.main[0] = { ganador: 'L' }

let _activePicker = null
// Referencia al picker de resultado abierto (para cerrarlo al hacer clic fuera).

let _activeVentaPicker = null
// Referencia al picker de resultado esperado abierto.

let _divFilterActive = false
// true = el filtro de divergencias está activado.

let _colsToggle = false
// true = las columnas de jugadores están ocultas (modo "Cols. clave").

let _selectedPlayerToDelete = -1
// Índice del jugador seleccionado para eliminar. -1 = ninguno.

let _sessionUser = null
// Nombre del usuario con sesión activa.

let _toastTimer = null
// Temporizador para ocultar el mensaje toast.

let _iaResults = null
let _iaResultsRev = null
// Último resultado de consulta IA para quiniela principal y revancha.

let _lastPropuestasExport = []
// Último conjunto de propuestas generadas (para exportar).

let _pendingWorkbook = null
let _pendingFileName = ''
let _selectedSheetName = ''
// Estado del selector de hoja de Excel.
```

### 11.2 Constantes de localStorage / sessionStorage

```javascript
const LS_DATA    = 'pronosticos_data_v2'
// Guarda todo el estado de la quiniela: partidos, pronósticos,
// participantes, porcentajes de venta y nombre de archivo.

const LS_HISTORY = 'pronosticos_history_v1'
// Historial de los últimos 5 archivos cargados.

const LS_RANKING = 'pronosticos_ranking_v1'
// Historial de concursos guardados con sus ganadores.

const LS_USERS   = 'pronosticos_users_v1'
// Lista de usuarios con sus contraseñas y roles.

const LS_SESSION = 'pronosticos_session_v1'
// Sesión activa (usuario y rol).

const LS_IA_KEY      = 'pronosticos_ia_key_v1'
// API key de OpenAI o Gemini.

const LS_IA_MODEL    = 'pronosticos_ia_model_v1'
// Modelo seleccionado: 'gpt' o 'gemini'.

const LS_IA_RESULT   = 'pronosticos_ia_result_v1'
// Último resultado IA de la quiniela principal.

const LS_IA_RESULT_R = 'pronosticos_ia_result_rev_v1'
// Último resultado IA de la revancha.

const LS_PROPUESTAS_CONFIG = 'pronosticos_propuestas_config_v1'
// Configuración guardada de la pestaña de propuestas.
```

### 11.3 Funciones de carga y renderizado

```javascript
function processFile(file)
// Recibe el archivo Excel. Valida extensión, lee como binario con FileReader,
// convierte con SheetJS. Si tiene múltiples hojas, llama a abrirModalSheet().

function abrirModalSheet(sheetNames)
// Muestra el modal de selección de hoja con los nombres disponibles.

function confirmarSheet()
// Confirma la hoja seleccionada y llama a loadSheetFromWorkbook().

function loadSheetFromWorkbook(workbook, sheetName, fileName)
// Extrae los datos de la hoja seleccionada y llama a renderTable().

function renderTable(rows, fileName, fromStorage)
// Punto de entrada principal. Detecta la fila REVANCHA, extrae participantes,
// detecta columna "Porcentajes" del Excel, llama a renderQuiniela() para
// principal y revancha, actualiza el banner de info e historial.

function renderQuiniela(dataRows, participants, ids, tableKey)
// Construye completamente una tabla HTML de quiniela.
// Retorna: { sortedParticipants, sortedHits, totalWithResult, streaks,
//            consensusHits, esperadoHits }
// Para las columnas especiales, filtra _participants por pronosticosReales
// (excluye "Cobertura N").

function updateResultRow(tableKey, rowIdx, value, rows)
// Actualiza solo la fila afectada al cambiar un resultado, sin reconstruir
// la tabla completa. Usa hCells.length - 6 para contar columnas de jugadores
// (hay 6 columnas especiales al final: Riesgo, Consenso, Nadie espera,
//  Menos apostado, Esperado, CvsE).

function renderSummary(participants, hits, total, streaks, cardsId, summaryId, extras)
// Renderiza las tarjetas del marcador de aciertos.
// extras = { consensusHits, esperadoHits } para las cards especiales.
// Las cards especiales aparecen si superan umbral: >7 para principal, >5 para revancha.
// El parámetro extras es opcional.
```

### 11.4 Funciones de edición en vivo

```javascript
function onResultadoClick(e)
// Abre el picker de resultado (L/E/V/T/✕) para un partido.

function setResultado(tableKey, rowIdx, value)
// Guarda el resultado en el array y localStorage, llama a updateResultRow().

function onVentaClick(e)
// Abre el picker de resultado esperado con 2 filas:
//   Fila 1: L | E | V
//   Fila 2: LE | LV | EV | T | ✕
// Guarda en _ventaPcts como { ganador: 'X' }.
```

### 11.5 Funciones de análisis

```javascript
function getMostFrequent(arr)
// Calcula el consenso (resultado más votado). Solo recibe pronosticosReales.
// Si hay empate devuelve "L/E", "L/V", etc.

function getLeastFrequent(arr)
// Calcula el resultado menos apostado (similar a getMostFrequent pero inverso).

function getAcuerdoPct(pronosticos, consensus)
// Calcula qué % del grupo coincide con el consenso.

function getResultadoEsperado(pcts)
// Simplemente devuelve pcts.ganador (el valor ya viene simplificado).

function calcularRiesgo(pcts, consensus, nadieEspera, acuerdoPct)
// Evalúa las 3 señales de peligro. Usa pronosticoContiene() para comparar
// consensus con esperado (soporta dobles: ej. esperado=LE, consensus=L → OK).
// Devuelve: { emoji: "🔴"|"🟡"|"🟢"|"⚪", titulo: "..." }

function pronosticoContiene(pron, res)
// Verifica si un pronóstico cubre un resultado dado.
// pronosticoContiene("T", "V")  → true
// pronosticoContiene("LE", "E") → true
// pronosticoContiene("L", "E")  → false

function expandPronostico(code)
// Expande un código a sus letras individuales.
// expandPronostico("LE") → ["L", "E"]
// expandPronostico("T")  → ["L", "E", "V"]

function getCubiertos(arr)
// Dado un array de pronósticos, devuelve un Set con todos los resultados cubiertos.

function renderVentaCell(td, pcts)
// Renderiza el badge del resultado esperado en la celda de la columna Esperado.

function renderCvseCell(td, consensus, esperado)
// Renderiza la celda CvsE comparando consensus vs esperado con pronosticoContiene().

function getMostFrequent(arr) / getLeastFrequent(arr)
// Calculan consenso y menos apostado sobre pronosticosReales exclusivamente.
```

### 11.6 Funciones UX y utilidades

```javascript
function toggleColsKey()
// Alterna la visibilidad de todas las columnas de jugadores (modo "Cols. clave").
// Cambia _colsToggle y aplica clase 'hidden' a las columnas de jugadores
// en thead, tbody y tfoot.

function toggleDiverg()
// Activa/desactiva el filtro de divergencias. Oculta filas sin divergencia.

function dismissColHint()
// Cierra el hint de tap en encabezados y lo guarda en localStorage.

function updateTabBadges()
// Actualiza los badges en las pestañas Propuestas y Ranking:
// - Propuestas: badge si hay propuestas generadas (_lastPropuestasExport.length > 0)
// - Ranking: badge si hay concursos guardados en el ranking

function showToast(msg, type, duration)
// Muestra un mensaje flotante temporal (ok/error/info).

function abrirModalLimpiar() / cerrarModalLimpiar()
// Modal de confirmación antes de llamar a clearData().

function clearData()
// Limpia todo el estado de la app y restaura el onboarding.

function toggleFullscreen(wrapperId)
// Alterna pantalla completa de la tabla principal.
```

### 11.7 Funciones del sistema de propuestas

```javascript
function generarPropuestas()
// Orquesta la generación: lee configuración, llama a optimizarPropuestas()
// o generarPropuestasAmbas(), y llama a renderPropuestas().

function optimizarPropuestas(rows, playerIndexes, budget, maxTickets, strategy, tableKey)
// Algoritmo principal: calcula probabilidades, genera candidatos,
// selecciona los más diversos con distancia de Hamming.

function obtenerProbabilidadesPartidos(rows, playerIndexes)
// Calcula, por partido, las probabilidades L/E/V basadas en los pronósticos
// de los jugadores seleccionados.

function generarCandidatosPropuestas(probabilities, doubleCount, candidateCount)
// Genera N boletos candidatos distribuidos según las probabilidades calculadas.

function seleccionarPropuestasDiversas(candidates, count, strategy)
// Selecciona los boletos más diversos usando distancia de Hamming
// (maximiza la diferencia entre boletos seleccionados).

function renderPropuestas(rows, proposals, budget, tableKey, target, append)
// Renderiza los boletos generados como tabla visual con badge por partido.

function renderOpcionesNoCubiertas(rows, proposals, tableKey, content)
// Muestra qué resultados no están cubiertos en ninguno de los boletos generados.

function exportarPropuestas()
// Exporta los boletos de _lastPropuestasExport a .xlsx.
```

### 11.8 Funciones del sistema de IA

```javascript
function iaCallGPT(apiKey, partidos)
// Llama a OpenAI con gpt-4o-mini. Prompt en español pidiendo pred/conf/razon en JSON.

function iaCallGemini(apiKey, partidos)
// Llama a Google Gemini con gemini-1.5-flash. Mismo prompt.

function iaConsultar(sec)
// Orquesta la consulta: valida key y partidos, llama al proveedor elegido,
// enriquece los resultados con consenso real y esperado, guarda y renderiza.

function iaDemo(sec)
// Genera resultados simulados para demostración sin API key.

function iaRenderResults(data, sec)
// Renderiza la tabla de resultados IA con predicción, barra de confianza,
// razonamiento y comparativa vs consenso y vs esperado.
```

---

## 12. Dónde se guardan los datos hoy

Todo se guarda en `localStorage` del navegador.

```
localStorage del navegador
├── pronosticos_data_v2          ← La quiniela actual completa
├── pronosticos_history_v1       ← Los últimos 5 archivos usados
├── pronosticos_ranking_v1       ← El historial de concursos
├── pronosticos_users_v1         ← Usuarios y contraseñas
├── pronosticos_session_v1       ← La sesión activa
├── pronosticos_ia_key_v1        ← Tu API key de IA
├── pronosticos_ia_model_v1      ← El modelo elegido (gpt/gemini)
├── pronosticos_ia_result_v1     ← Último resultado IA principal
├── pronosticos_ia_result_rev_v1 ← Último resultado IA revancha
├── pronosticos_theme_v1         ← El tema (claro/oscuro)
├── pronosticos_propuestas_config_v1 ← Config de propuestas
└── pronosticos_col_hint_v1      ← Si ya se mostró el hint de tap

sessionStorage del navegador
├── pronosticos_ia_result_v1     ← Cache de resultado IA (se pierde al cerrar pestaña)
└── pronosticos_ia_result_rev_v1 ← Cache de resultado IA revancha
```

**⚠️ Limitación:** Si abres la app desde otro navegador, otro celular o limpias el caché, todos los datos desaparecen.

---

## 13. Migración a API REST — El nuevo proyecto

### ¿Qué es una API REST?

Una **API REST** es un servidor que escucha peticiones de la aplicación web y responde con datos.

### ¿Qué cambia con la migración?

**Antes:**
```
Navegador → localStorage (datos en tu PC)
```

**Después:**
```
Navegador → Servidor Node.js → Base de datos SQLite
                ↑
        (API key de IA segura aquí)
```

---

## 14. Arquitectura del backend (servidor)

### Estructura de archivos del nuevo proyecto

```
pronosticos/
│
├── index.html                 ← Tu frontend (mínimos cambios)
│
└── server/                    ← Nuevo: el servidor
    ├── package.json
    ├── .env                   ← Variables secretas (nunca subir al repo)
    ├── .env.example           ← Plantilla de variables
    ├── index.js               ← Punto de entrada del servidor
    ├── db.js                  ← Conexión y configuración de SQLite
    ├── auth.js                ← Middleware para verificar tokens JWT
    └── routes/
        ├── auth.js            ← Endpoints de login/logout
        ├── quinielas.js       ← Endpoints de partidos y pronósticos
        ├── ia.js              ← Proxy seguro para ChatGPT y Gemini
        └── ranking.js         ← Endpoints del historial de concursos
```

### Tecnologías del servidor

```json
{
  "dependencies": {
    "express":          "^4.18",
    "better-sqlite3":   "^9.0",
    "jsonwebtoken":     "^9.0",
    "bcryptjs":         "^2.4",
    "cors":             "^2.8",
    "dotenv":           "^16.0",
    "multer":           "^1.4",
    "xlsx":             "^0.18"
  }
}
```

---

## 15. Base de datos — Tablas y relaciones

```sql
CREATE TABLE usuarios (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nombre TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  rol TEXT NOT NULL DEFAULT 'user',
  creado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE concursos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nombre TEXT NOT NULL,
  creado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE partidos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  concurso_id INTEGER NOT NULL REFERENCES concursos(id),
  numero INTEGER NOT NULL,
  nombre TEXT NOT NULL,
  resultado TEXT,
  ganador_esperado TEXT,        -- 'L','E','V','LE','LV','EV','T' o NULL
  es_revancha INTEGER DEFAULT 0
);

CREATE TABLE jugadores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  concurso_id INTEGER NOT NULL REFERENCES concursos(id),
  nombre TEXT NOT NULL,
  es_cobertura INTEGER DEFAULT 0  -- 1 si es boleto de cobertura automática
);

CREATE TABLE pronosticos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  partido_id INTEGER NOT NULL REFERENCES partidos(id),
  jugador_id INTEGER NOT NULL REFERENCES jugadores(id),
  valor TEXT
);

CREATE TABLE ranking (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  numero TEXT NOT NULL,
  jugador_nombre TEXT NOT NULL,
  aciertos INTEGER NOT NULL,
  total INTEGER NOT NULL,
  fecha DATE NOT NULL,
  creado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

---

## 16. API REST — Todos los endpoints

### Autenticación

```
POST   /api/auth/login
POST   /api/auth/logout
GET    /api/auth/me
POST   /api/auth/cambiar-password
GET    /api/auth/usuarios          [solo admin]
POST   /api/auth/usuarios          [solo admin]
DELETE /api/auth/usuarios/:id      [solo admin]
```

### Quinielas

```
GET    /api/quinielas
POST   /api/quinielas/upload
PATCH  /api/quinielas/partidos/:id/resultado
PATCH  /api/quinielas/partidos/:id/esperado
POST   /api/quinielas/jugadores
DELETE /api/quinielas/jugadores/:id
GET    /api/quinielas/resumen
DELETE /api/quinielas/actual
```

### IA (proxy seguro)

```
POST   /api/ia/consultar
       Body: { "modelo": "gpt"|"gemini", "seccion": "main"|"rev" }
```

### Ranking histórico

```
GET    /api/ranking
POST   /api/ranking
DELETE /api/ranking/:id
```

---

## 17. Seguridad — Autenticación con JWT

### Flujo de autenticación

```
1. POST /api/auth/login → Servidor verifica bcrypt → devuelve token JWT
2. Navegador guarda el token
3. Cada petición incluye: Authorization: Bearer eyJ...
4. Middleware auth.js verifica el token en cada endpoint protegido
5. Token expira en 8 horas
```

### Contraseñas con bcrypt

```javascript
// Al crear usuario:
const hash = await bcrypt.hash('miContraseña123', 10)

// Al hacer login:
const esValida = await bcrypt.compare('miContraseña123', hashGuardado)
```

---

## 18. Proxy seguro para IA

```
Hoy:    Navegador → (key expuesta) → OpenAI/Gemini
Futuro: Navegador → /api/ia/consultar → Servidor (key en .env) → OpenAI/Gemini
```

### Archivo `.env`

```env
PORT=3001
JWT_SECRET=un_texto_muy_largo_y_aleatorio_aqui
OPENAI_API_KEY=sk-proj-...
GEMINI_API_KEY=AIza...
```

---

## 19. Cambios en el frontend

El `index.html` cambia relativamente poco:

1. **Login local → fetch a `/api/auth/login`** y guardar token JWT
2. **localStorage → llamadas fetch** para cada operación
3. **Llamadas IA directas → proxy `/api/ia/consultar`** (key segura en servidor)
4. **Resultado esperado → PATCH `/api/quinielas/partidos/:id/esperado`** (campo `ganador`)

---

## 20. Pasos de implementación (plan de trabajo)

### Fase 1 — Scaffold del servidor (Día 1)
- [ ] Crear carpeta `server/` con `package.json`
- [ ] Instalar dependencias
- [ ] Crear `index.js`, `db.js`, `auth.js`
- [ ] Endpoint `POST /api/auth/login` y `GET /api/auth/me`
- [ ] Probar login con Thunder Client

### Fase 2 — Endpoints de quiniela (Día 2)
- [ ] `POST /api/quinielas/upload` — parsear Excel (detectar col Porcentajes)
- [ ] `GET /api/quinielas` — devolver quiniela activa completa
- [ ] `PATCH` para resultado y esperado
- [ ] `POST/DELETE` para jugadores
- [ ] Endpoints de ranking

### Fase 3 — Proxy IA y adaptación frontend (Día 3)
- [ ] `POST /api/ia/consultar` — proxy seguro
- [ ] Reemplazar login local por fetch a API
- [ ] Reemplazar carga de Excel local por upload a API
- [ ] Reemplazar edición local por PATCH a API
- [ ] Probar desde celular en misma red WiFi
- [ ] Probar multiusuario simultáneo

---

## 21. Cómo levantar el proyecto en tu computadora

### Versión actual (solo index.html)

Basta con abrir `pronosticos/index.html` directamente en el navegador. No se necesita servidor, Node.js ni nada adicional. Doble clic en el archivo o usar `iniciar.bat`.

### Versión futura (con servidor)

```powershell
cd pronosticos/server
npm install
Copy-Item .env.example .env
notepad .env          # editar con tus claves reales
node index.js
# Abrir http://localhost:3001
```

### Acceso desde otros dispositivos (misma red WiFi)

```powershell
ipconfig  # Busca "Dirección IPv4", ej: 192.168.1.105
# Desde el celular: http://192.168.1.105:3001
```

---

## 22. Glosario de términos técnicos

| Término | Explicación sencilla |
|---|---|
| **API** | Un "contrato" entre tu app y un servidor: defines qué pides y qué recibes |
| **REST** | Un estilo de diseño de APIs que usa URLs y métodos HTTP (GET, POST, etc.) |
| **Endpoint** | Una URL específica del servidor que hace una sola cosa |
| **JSON** | Formato de texto para enviar datos: `{"nombre": "Carlos", "aciertos": 10}` |
| **Token JWT** | Una credencial digital firmada que prueba que estás autenticado |
| **bcrypt** | Algoritmo que convierte una contraseña en un hash irreversible |
| **localStorage** | Almacenamiento en el navegador (se pierde si limpias el caché) |
| **SPA** | Single Page Application — toda la app vive en un solo archivo HTML |
| **SheetJS** | Librería JavaScript para leer y escribir archivos Excel |
| **Distancia de Hamming** | Métrica que cuenta en cuántas posiciones dos boletos difieren (usada para diversificar propuestas) |
| **Pronosticos reales** | Los pronósticos de jugadores reales, excluyendo los boletos de cobertura automática |
| **Boleto de cobertura** | Boleto generado automáticamente (prefijo "Cobertura N") para maximizar cobertura de resultados |
| **Doble** | Pronóstico que cubre dos resultados posibles: LE, LV o EV |
| **Triple (T)** | Pronóstico que cubre los tres resultados posibles (L, E y V) |
| **CvsE** | Consenso vs Esperado — columna que compara qué dijo el grupo vs el mercado |
| **Divergencia** | Partido donde el consenso del grupo apunta diferente al resultado esperado |
