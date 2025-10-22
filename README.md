# 🎓 Concentrador de Notas - IE de Occidente

## ✨ Descripción General

Este proyecto es una aplicación frontend moderna y robusta, desarrollada con **Svelte 5**, **TypeScript** y **Vite**, diseñada para la gestión y visualización integral de datos académicos. Interactúa con un backend PHP para ofrecer una experiencia completa en la administración de asignaciones, un concentrador de notas detallado y un historial académico exhaustivo para la institución "IE de Occidente".

## 🚀 Características Principales

*   **Gestión de Asignaciones:** Acceso y visualización de información relevante sobre asignaciones académicas.
*   **Concentrador de Notas:** Agregación y presentación clara de las calificaciones estudiantiles.
*   **Notas Detalladas:** Exploración a fondo de calificaciones individuales, incluyendo aspectos evaluados, fechas y ponderaciones porcentuales.
*   **Historial de Notas:** Consulta completa del rendimiento académico de los estudiantes a lo largo del tiempo.
*   **Interfaz de Usuario Intuitiva:** Desarrollada con Tailwind CSS para una experiencia de usuario fluida y adaptable.

## 🛠️ Tecnologías Utilizadas

### Frontend
*   **Framework:** [Svelte 5](https://svelte.dev/)
*   **Lenguaje:** [TypeScript](https://www.typescriptlang.org/)
*   **Empaquetador/Servidor de Desarrollo:** [Vite](https://vitejs.dev/)
*   **Estilos:** [Tailwind CSS](https://tailwindcss.com/)

### Backend
*   **Lenguaje:** [PHP](https://www.php.net/) (para la exposición de las APIs)

## 📂 Estructura del Proyecto

```
.
├── public/
│   └── vite.svg
├── src/
│   ├── app.css
│   ├── App.svelte
│   ├── main.ts
│   ├── assets/
│   │   ├── db.sql
│   │   ├── getConcentrador.php
│   │   ├── getNotasDetallado.php
│   │   ├── getNotasHistory.php
│   │   ├── getValoraciones.php
│   │   ├── inasistenciasDetallado.php
│   │   ├── svelte.svg
│   │   └── test_getNotasDetallado.php
│   └── lib/
│       ├── api.ts
│       ├── InasistenciasDetallado.svelte
│       ├── InfoCantDialog.svelte
│       ├── NotasDetalleDialog.svelte
│       ├── NotasHistoryDialog.svelte
│       ├── PayloadForm.svelte
│       ├── Skeleton.svelte
│       ├── storeConcentrador.ts
│       ├── themeStore.ts
│       ├── Tooltip.svelte
│       ├── types.ts
│       └── VirtualRows.svelte
├── concentrador/ (Sub-proyecto o módulo Svelte/Vite)
│   └── ...
├── constants.ts
├── excons.json
├── index.html
├── package.json
├── svelte.config.js
├── tailwind.config.js
├── tsconfig.json
├── vite.config.ts
└── README.md
```

## 🌐 API Endpoints

La aplicación se comunica con el backend PHP a través de los siguientes endpoints, definidos en `constants.ts`:

*   **Base URL:** `https://app.iedeoccidente.com/consex`
*   `GET_CONCENTRADOR_ENDPOINT`: `${API_BASE_URL}/getConcentrador2.php`
*   `GET_ASIGNACIONES_ENDPOINT`: `${API_BASE_URL}/getasignacion.php`
*   `GET_NOTAS_DETALLADO_ENDPOINT`: `${API_BASE_URL}/getNotasDetallado.php`
*   `GET_NOTAS_HISTORY_ENDPOINT`: `${API_BASE_URL}/getNotasHistory.php`

## 📊 Modelos de Datos Clave

Los principales modelos de datos, definidos en `src/lib/types.ts`, estructuran la información académica:

*   `Sede`: Información de sedes o campus.
*   `ConcentradorPayload`: Parámetros para solicitar datos del concentrador.
*   `ConcentradorParsed`: Estructura de respuesta para los datos agregados del concentrador.
*   `EstudianteRow`: Detalles de un estudiante.
*   `AsignaturaNota`: Notas de una asignatura por periodos.
*   `NotasDetalladoPayload`: Parámetros para solicitar notas detalladas.
*   `NotaDetalle`: Detalles de una nota específica.
*   `NotaHistory`: Estructura para el historial de notas.

## 🚀 Primeros Pasos

Para configurar y ejecutar el proyecto localmente, sigue estos pasos:

1.  **Clonar el Repositorio:**
    ```bash
    git clone <URL_DEL_REPOSITORIO>
    cd prbg
    ```

2.  **Instalar Dependencias:**
    ```bash
    npm install
    ```

3.  **Ejecutar en Modo Desarrollo:**
    ```bash
    npm run dev
    ```
    Esto iniciará el servidor de desarrollo de Vite. La aplicación estará disponible en la URL proporcionada en la consola (usualmente `http://localhost:5173`).

4.  **Construir para Producción:**
    ```bash
    npm run build
    ```
    Genera los archivos optimizados para producción en el directorio `dist/`.

5.  **Previsualizar la Construcción:**
    ```bash
    npm run preview
    ```
    Permite previsualizar la versión de producción de la aplicación localmente.

6.  **Verificación de Tipos y Svelte:**
    ```bash
    npm run check
    ```
    Ejecuta las comprobaciones de tipos de TypeScript y Svelte para asegurar la calidad del código.

## 💻 Configuración de IDE Recomendada

*   [**VS Code**](https://code.visualstudio.com/)
*   Extensión de Svelte para VS Code: [**Svelte for VS Code**](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode)

---
_Desarrollado con ❤️ para la IE de Occidente._
