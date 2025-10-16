<script lang="ts">
    import type { NotaDetalle } from './types';
    import { theme } from './themeStore';
    import NotasHistoryDialog from './NotasHistoryDialog.svelte';

    export let showDialog: boolean;
    export let notasDetalle: NotaDetalle[] = [];
    export let loading: boolean = false;
    export let error: string | null = null;
    export let year: string; // Añadir la prop year
    export let periodo: string;
    export let estudianteId: string;

    export let asignatura: string;
    export let studentName: string;

    let showNotasHistoryDialog: boolean = false;

    let docenteName: string = '';

    $: if (notasDetalle.length > 0) {
        docenteName = notasDetalle[0].Docente;
    }

    function closeDialog() {
        showDialog = false;
        notasDetalle = [];
        error = null;
    }

    function openNotasHistoryDialog() {
        showNotasHistoryDialog = true;
    }

    function closeNotasHistoryDialog() {
        showNotasHistoryDialog = false;
    }

    // Función auxiliar para convertir "Mes Día" a un objeto Date
    function parseFecha(fechaStr: string, currentYear: string): Date {
        if (!fechaStr || fechaStr.trim() === '') {
            // Si la fecha es inválida, devolver una fecha muy antigua para que se ordene al final
            return new Date(0);
        }
        // Mapeo de nombres de meses en español a números de mes (0-11)
        const monthMap: { [key: string]: number } = {
            'Enero': 0, 'Febrero': 1, 'Marzo': 2, 'Abril': 3, 'Mayo': 4, 'Junio': 5,
            'Julio': 6, 'Agosto': 7, 'Septiembre': 8, 'Octubre': 9, 'Noviembre': 10, 'Diciembre': 11
        };

        const parts = fechaStr.split(' ');
        if (parts.length !== 2) {
            return new Date(0); // Formato inesperado
        }
        const monthName = parts[0];
        const day = parseInt(parts[1], 10);
        const month = monthMap[monthName];

        if (isNaN(day) || month === undefined) {
            return new Date(0); // Fallback para fechas no parseables
        }

        return new Date(parseInt(currentYear), month, day);
    }

    $: sortedNotasDetalle = [...notasDetalle].sort((a, b) => {
        const dateA = parseFecha(a.FechaNota, year);
        const dateB = parseFecha(b.FechaNota, year);
        return dateB.getTime() - dateA.getTime(); // Descendente
    });

    function colorNotaDetalle(nota: string | null): string {
        if (nota === null) return ''; // No aplicar color si es null

        const v = parseFloat(nota);
        if (isNaN(v)) return ''; // No aplicar color si no es un número

        if (v < 3) {
            return 'text-red-500 animate-blink'; // Clase para rojo y parpadeo
        }
        return ''; // Sin clase si es >= 3
    }

    $: {
        if (showDialog) {
            // console.log('NotasDetalleDialog: showDialog is true, attempting to render.'); // <-- Nuevo log
        }
    }
</script>

<style>
    @keyframes blink {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.3; }
    }
    .animate-blink {
        animation: blink 1.5s ease-in-out infinite;
    }
</style>

{#if showDialog}
    <div class="fixed inset-0 bg-black bg-opacity-80 flex items-center justify-center p-4 z-50 backdrop-blur-sm transition-opacity duration-300"
         class:opacity-100={showDialog}
         class:opacity-0={!showDialog}>
        <!-- Console log to confirm rendering -->
        <script>console.log('NotasDetalleDialog is rendering!');</script>
        <div class="rounded-2xl shadow-2xl max-w-3xl w-full max-h-[90vh] overflow-hidden flex flex-col border transform transition-all duration-300 ease-out
                    {$theme === 'dark' ? 'bg-gradient-to-br from-gray-800 to-gray-900 border-gray-700' : 'bg-white border-gray-300'}"
             class:scale-100={showDialog}
             class:scale-95={!showDialog}
             class:opacity-100={showDialog}
             class:opacity-0={!showDialog}>
            <div class="flex justify-between items-center p-4 border-b
                        {$theme === 'dark' ? 'border-gray-700 bg-gray-800' : 'border-gray-200 bg-gray-50'}">
                <h3 class="text-2xl font-extrabold tracking-wide {$theme === 'dark' ? 'text-white' : 'text-gray-800'}">
                    Detalle de Notas
                    {#if asignatura}
                        <span class="text-sm {$theme === 'dark' ? 'text-purple-400' : 'text-purple-600'}"> ({asignatura})</span>
                    {/if}
                    {#if periodo}
                        <span class="text-sm {$theme === 'dark' ? 'text-green-400' : 'text-green-600'}"> (Periodo: {periodo})</span>
                    {/if}
                    <br>
                    {#if studentName}
                        <span class="text-sm {$theme === 'dark' ? 'text-yellow-400' : 'text-yellow-600'}">Estudiante: {studentName}</span><br>
                    {/if}
                    {#if docenteName}
                        <span class="text-sm {$theme === 'dark' ? 'text-blue-400' : 'text-blue-600'}">Docente: {docenteName}</span>
                    {/if}
                </h3>
                <div class="flex items-center space-x-2">
                    <button on:click={openNotasHistoryDialog} class="p-2 rounded-full transition duration-300
                                {$theme === 'dark' ? 'text-purple-400 hover:bg-gray-700' : 'text-purple-700 hover:bg-gray-200'}"
                            title="Ver Historial">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </button>
                    <button on:click={theme.toggle} class="p-2 rounded-full transition duration-300
                                {$theme === 'dark' ? 'text-yellow-400 hover:bg-gray-700' : 'text-gray-700 hover:bg-gray-200'}"
                            title="Toggle theme">
                        {#if $theme === 'dark'}
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h1M3 12H2m8.003-4.373l.707-.707M10.322 16.322l-.707.707M4.929 4.929l.707.707M16.322 10.322l.707-.707M16.322 16.322l.707.707M4.929 19.071l.707-.707M18.364 5.636l-1.414 1.414M6.343 17.657l-1.414 1.414M12 12a5 5 0 110-10 5 5 0 010 10z" />
                            </svg>
                        {:else}
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
                            </svg>
                        {/if}
                    </button>
                    <button on:click={closeDialog} class="text-gray-400 hover:text-red-500 transition duration-300 transform hover:scale-110" title="Cerrar">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
            </div>

            <div class="p-4 overflow-y-auto flex-grow {$theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}">
                {#if loading}
                    <div class="flex flex-col items-center justify-center h-48 rounded-lg p-6 shadow-inner
                                {$theme === 'dark' ? 'bg-gray-800' : 'bg-gray-100'}">
                        <div class="relative flex justify-center items-center">
                            <div class="animate-spin rounded-full h-16 w-16 border-t-4 border-b-4 {$theme === 'dark' ? 'border-blue-500' : 'border-blue-600'}"></div>
                            <svg class="absolute h-8 w-8 {$theme === 'dark' ? 'text-blue-400' : 'text-blue-500'}" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                            </svg>
                        </div>
                        <span class="mt-4 text-lg font-semibold animate-pulse {$theme === 'dark' ? 'text-blue-400' : 'text-blue-600'}">Cargando detalles de notas...</span>
                        <p class="text-sm mt-2 {$theme === 'dark' ? 'text-gray-500' : 'text-gray-400'}">Por favor, espera un momento.</p>
                    </div>
                {:else if error}
                    <div class="border text-white px-6 py-4 rounded-lg relative shadow-lg flex items-center space-x-3
                                {$theme === 'dark' ? 'bg-red-900 border-red-700' : 'bg-red-100 border-red-400 text-red-800'}"
                         role="alert">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 {$theme === 'dark' ? 'text-red-400' : 'text-red-600'}" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        <div>
                            <strong class="font-bold {$theme === 'dark' ? 'text-red-300' : 'text-red-700'}">¡Error!</strong>
                            <span class="block sm:inline ml-2">{error}</span>
                        </div>
                    </div>
                {:else if notasDetalle.length > 0}
                    <div class="overflow-x-auto rounded-lg border shadow-lg
                                {$theme === 'dark' ? 'border-gray-700' : 'border-gray-200'}">
                        <table class="min-w-full text-sm text-left
                                    {$theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}">
                            <thead class="text-xs uppercase tracking-wider border-b
                                        {$theme === 'dark' ? 'bg-gray-700 text-gray-400 border-gray-600' : 'bg-gray-100 text-gray-600 border-gray-200'}">
                                <tr>
                                    <th scope="col" class="px-4 py-3">Aspecto</th>
                                    <th scope="col" class="px-4 py-3">Nota</th>
                                    
                                    
                                    <th scope="col" class="px-4 py-3">Fecha Aspecto</th>
                                    <th scope="col" class="px-4 py-3">Fecha Nota</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y
                                        {$theme === 'dark' ? 'divide-gray-700' : 'divide-gray-200'}">
                                {#each sortedNotasDetalle as nota}
                                    {#if nota.Nota !== null}
                                        <tr class="transition duration-200 ease-in-out
                                                    {$theme === 'dark' ? 'bg-gray-800 hover:bg-gray-700' : 'bg-white hover:bg-gray-50'}">
                                            <td class="px-4 py-3 font-medium">{nota.Aspecto || 'N/A'}</td>
                                            <td class="px-4 py-3 {colorNotaDetalle(nota.Nota)}">{nota.Nota || 'N/A'}</td>
                                            
                                            
                                            <td class="px-4 py-3">{nota.FechaAspecto}</td>
                                            <td class="px-4 py-3">{nota.FechaNota}</td>
                                        </tr>
                                    {/if}
                                {/each}
                            </tbody>
                        </table>
                    </div>
                {:else}
                    <p class="text-center py-8 {$theme === 'dark' ? 'text-gray-400' : 'text-gray-600'}">No se encontraron detalles de notas para esta selección.</p>
                {/if}
            </div>

            <div class="p-4 border-t flex justify-end
                        {$theme === 'dark' ? 'border-gray-700 bg-gray-800' : 'border-gray-200 bg-gray-50'}">
                <button on:click={closeDialog} class="px-6 py-2 rounded-lg text-white font-semibold transition duration-300 ease-in-out transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-opacity-50
                            {$theme === 'dark' ? 'bg-blue-600 hover:bg-blue-700 focus:ring-blue-500' : 'bg-blue-500 hover:bg-blue-600 focus:ring-blue-400'}">Cerrar</button>
            </div>
        </div>
    </div>
{/if}

<NotasHistoryDialog
    bind:showDialog={showNotasHistoryDialog}
    studentId={estudianteId}
    subject={asignatura}
    periodo={periodo}
    year={year}
    on:close={closeNotasHistoryDialog}
/>
