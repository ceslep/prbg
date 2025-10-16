# Concentrador de Notas - IE de Occidente

## Descripción del Proyecto

Este proyecto es una aplicación frontend desarrollada con Svelte, TypeScript y Vite, diseñada para interactuar con un backend PHP. Su propósito principal es la gestión y visualización de datos académicos, incluyendo asignaciones, un concentrador de notas (agregación de calificaciones estudiantiles) e historial de notas detallado para la institución "IE de Occidente".

## Características Principales

*   **Gestión de Asignaciones:** Permite la obtención de información sobre asignaciones académicas.
*   **Concentrador de Notas:** Agrega y muestra datos de calificaciones de estudiantes.
*   **Notas Detalladas:** Visualización de calificaciones individuales con aspectos, fechas y porcentajes.
*   **Historial de Notas:** Acceso al historial completo de calificaciones de los estudiantes.

## Tecnologías Utilizadas

### Frontend
*   **Framework:** Svelte (v5.x)
*   **Lenguaje:** TypeScript
*   **Empaquetador/Servidor de Desarrollo:** Vite
*   **Estilos:** Tailwind CSS

### Backend
*   **Lenguaje:** PHP (para la exposición de las APIs)

## Estructura del Proyecto

*   `public/`: Contiene activos estáticos como `vite.svg`.
*   `src/`: Código fuente principal de la aplicación.
    *   `src/assets/`: Contiene scripts PHP que actúan como endpoints del backend (e.g., `getConcentrador.php`, `getNotasDetallado.php`).
    *   `src/lib/`: Módulos y componentes reutilizables.
        *   `api.ts`: Definiciones de funciones para interactuar con el backend.
        *   `types.ts`: Definiciones de interfaces y tipos de datos para la aplicación.
        *   `storeConcentrador.ts`, `themeStore.ts`: Posibles tiendas de estado para la aplicación.
        *   Componentes Svelte como `NotasDetalleDialog.svelte`, `NotasHistoryDialog.svelte`, `PayloadForm.svelte`, `Skeleton.svelte`, `VirtualRows.svelte`.
    *   `App.svelte`: Componente raíz de la aplicación.
    *   `main.ts`: Punto de entrada de la aplicación.
*   `concentrador/`: Un sub-directorio que también parece ser un proyecto Svelte/Vite. Su relación exacta con el proyecto principal podría ser la de un módulo, una aplicación independiente o un componente legado.
*   `constants.ts`: Define las URLs de los endpoints de la API.

## API Endpoints

La aplicación se comunica con un backend PHP a través de los siguientes endpoints, definidos en `constants.ts`:

*   **Base URL:** `https://app.iedeoccidente.com/consex`
*   `GET_CONCENTRADOR_ENDPOINT`: `${API_BASE_URL}/getConcentrador2.php`
*   `GET_ASIGNACIONES_ENDPOINT`: `${API_BASE_URL}/getasignacion.php`
*   `GET_NOTAS_DETALLADO_ENDPOINT`: `${API_BASE_URL}/getNotasDetallado.php`
*   `GET_NOTAS_HISTORY_ENDPOINT`: `${API_BASE_URL}/getNotasHistory.php`

## Modelos de Datos Clave

Los principales modelos de datos utilizados en la aplicación, definidos en `src/lib/types.ts`, incluyen:

*   `Sede`: Información de sedes o campus.
*   `ConcentradorPayload`: Parámetros para solicitar datos del concentrador.
*   `ConcentradorParsed`: Estructura de respuesta para los datos agregados del concentrador.
*   `EstudianteRow`: Detalles de un estudiante.
*   `AsignaturaNota`: Notas de una asignatura por periodos.
*   `NotasDetalladoPayload`: Parámetros para solicitar notas detalladas.
*   `NotaDetalle`: Detalles de una nota específica.
*   `NotaHistory`: Estructura para el historial de notas.

## Primeros Pasos

Para configurar y ejecutar el proyecto localmente:

1.  **Instalación de Dependencias:**
    ```bash
    npm install
    ```

2.  **Ejecutar en Modo Desarrollo:**
    ```bash
    npm run dev
    ```
    Esto iniciará el servidor de desarrollo de Vite, y la aplicación estará disponible en la URL proporcionada en la consola (usualmente `http://localhost:5173`).

3.  **Construir para Producción:**
    ```bash
    npm run build
    ```
    Esto generará los archivos optimizados para producción en el directorio `dist/`.

4.  **Previsualizar la Construcción:**
    ```bash
    npm run preview
    ```
    Permite previsualizar la versión de producción de la aplicación localmente.

5.  **Verificación de Tipos y Svelte:**
    ```bash
    npm run check
    ```
    Ejecuta las comprobaciones de tipos de TypeScript y Svelte.

## Configuración de IDE Recomendada

*   [VS Code](https://code.visualstudio.com/)
*   Extensión de Svelte para VS Code: [Svelte for VS Code](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode)