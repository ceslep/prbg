<script lang="ts">
    import { createEventDispatcher } from 'svelte';
    import { GET_NOTAS_HISTORY_ENDPOINT } from '../../constants';
    import type { NotaHistory } from './types';
    import Skeleton from './Skeleton.svelte';
    import { theme } from './themeStore';
    import Tooltip from './Tooltip.svelte';

    export let showDialog: boolean = false;
    export let studentId: string;
    export let subject: string;
    export let periodo: string;
    export let year: string;

    let notasHistory: NotaHistory[] = [];
    let loading: boolean = false;
    let error: string | null = null;

    let columnNames: string[] = [];

    // Reactivo para calcular columnas válidas y ordenarlas
    $: {
        if (notasHistory.length > 0) {
            const allKeys = Object.keys(notasHistory[0]);
            const notaKeys = allKeys.filter(key => {
                if (!key.startsWith('nota') || key.length > 6) return false;
                const suffix = key.substring(4);
                if (!/^\d+$/.test(suffix)) return false;
                const num = parseInt(suffix, 10);
                return num >= 1 && num <= 12;
            }).sort((a, b) => parseInt(a.substring(4), 10) - parseInt(b.substring(4), 10));
            columnNames = notaKeys;
        } else {
            columnNames = [];
        }
    }

    const dispatch = createEventDispatcher();

    function areNotasEqual(nota1: NotaHistory, nota2: NotaHistory): boolean {
        for (let i = 1; i <= 12; i++) {
            const notaKey = `nota${i}` as keyof NotaHistory;
            if (nota1[notaKey] !== nota2[notaKey]) {
                return false;
            }
        }
        return true;
    }

    function getUniqueNotas(notas: NotaHistory[]): NotaHistory[] {
        const uniqueNotas: NotaHistory[] = [];
        for (const nota of notas) {
            if (!uniqueNotas.some(uniqueNota => areNotasEqual(uniqueNota, nota))) {
                uniqueNotas.push(nota);
            }
        }
        return uniqueNotas;
    }

    async function fetchNotasHistory() {
        loading = true;
        error = null;
        try {
            const response = await fetch(GET_NOTAS_HISTORY_ENDPOINT, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    estudiante: studentId,
                    asignatura: subject,
                    periodo: periodo,
                    year: year,
                }),
            });
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const fetchedNotas: NotaHistory[] = await response.json();
            notasHistory = getUniqueNotas(fetchedNotas);
        } catch (e: any) {
            error = e.message;
            console.error("Error fetching notas history:", e);
        } finally {
            loading = false;
        }
    }

    // Evitar fetch duplicado
    let lastFetchedKey: string | null = null;
    $: {
        const key = `${studentId}-${subject}-${periodo}-${year}`;
        if (showDialog && studentId && subject && periodo && year) {
            if (key !== lastFetchedKey) {
                lastFetchedKey = key;
                fetchNotasHistory();
            }
        } else {
            lastFetchedKey = null;
        }
    }

    function closeDialog() {
        showDialog = false;
        dispatch('close');
    }

    function isNotaHistoryRowEmpty(nota: NotaHistory): boolean {
        for (let i = 1; i <= 12; i++) {
            const notaKey = `nota${i}` as keyof NotaHistory;
            if (nota[notaKey] !== null && nota[notaKey] !== '') {
                return false;
            }
        }
        return true;
    }

    function getHintText(nota: NotaHistory, colName: string): string {
        const aspectoKey = colName.replace('nota', 'aspecto');
        const fechaKey = colName.replace('nota', 'fecha');
        // Usamos 'as any' solo si confiamos en la estructura; alternativa: definir tipo completo
        const aspecto = (nota as any)[aspectoKey] ?? 'N/A';
        const fecha = (nota as any)[fechaKey] ?? 'N/A';
        return `Aspecto: ${aspecto}\nFecha: ${fecha}`;
    }

    function shouldBlinkRed(value: string | null): boolean {
        if (value === null || value === '') return false;
        const num = parseFloat(value);
        return !isNaN(num) && num < 3;
    }

    $: filteredNotasHistory = notasHistory.filter(nota => !isNotaHistoryRowEmpty(nota));
</script>

{#if showDialog}
    <div 
        class="dialog-backdrop" 
        on:click={closeDialog} 
        role="button" 
        tabindex="0" 
        on:keydown={(e) => { if (e.key === 'Escape') closeDialog(); }}
        aria-label="Cerrar diálogo"
    >
        <div 
            class="dialog-content flex flex-col p-6 {$theme === 'dark' ? 'bg-gradient-to-br from-gray-800 to-gray-900 text-gray-200' : 'bg-white text-gray-800'}" 
            on:click|stopPropagation 
            role="dialog" 
            aria-modal="true" 
            tabindex="-1" 
            on:keydown={(e) => { if (e.key === 'Escape') closeDialog(); }}
        >
            <h2 class="{$theme === 'dark' ? 'text-white' : 'text-gray-800'}">Historial de Notas para {studentId} - {subject}</h2>

            {#if loading}
                <Skeleton rows={5} columns={6} theme={$theme} />
            {:else if error}
                <p class="{$theme === 'dark' ? 'text-red-400' : 'text-red-600'}">Error: {error}</p>
            {:else if notasHistory.length > 0}
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                {#each columnNames as colName}
                                    <th class="{$theme === 'dark' ? 'bg-gray-700 text-gray-400' : 'bg-gray-100 text-gray-600'}">
                                        {colName.replace('nota', 'N')}
                                    </th>
                                {/each}
                            </tr>
                        </thead>
                        <tbody>
                            {#each filteredNotasHistory as nota}
                                <tr class="{$theme === 'dark' ? 'bg-gray-800 hover:bg-gray-700' : 'bg-white hover:bg-gray-50'}">
                                    {#each columnNames as colName}
                                        <td class="text-center">
                                            <Tooltip content={getHintText(nota, colName)}>
                                                <span class:blink-red={shouldBlinkRed(nota[colName as keyof NotaHistory])}>
                                                    {nota[colName as keyof NotaHistory] || ''}
                                                </span>
                                            </Tooltip>
                                        </td>
                                    {/each}
                                </tr>
                            {/each}
                        </tbody>
                    </table>
                </div>
            {:else}
                <p class="{$theme === 'dark' ? 'text-gray-400' : 'text-gray-600'}">No se encontró historial de notas para este estudiante y asignatura.</p>
            {/if}

            <button 
                on:click={closeDialog} 
                class="mt-4 ml-auto px-4 py-2 rounded-md text-white font-semibold transition duration-200 {$theme === 'dark' ? 'bg-blue-600 hover:bg-blue-700' : 'bg-blue-500 hover:bg-blue-600'}"
            >
                Cerrar
            </button>
        </div>
    </div>
{/if}

<style>
    .dialog-backdrop {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 1000;
    }

    .table-container {
        max-height: 400px;
        overflow-y: auto;
        overflow-x: auto;
        margin-top: 15px;
        margin-bottom: 15px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
    }

    th {
        text-align: center;
    }

    @keyframes blink {
        0% { opacity: 1; }
        50% { opacity: 0.5; }
        100% { opacity: 1; }
    }

    .blink-red {
        animation: blink 1s linear infinite;
        color: #ef4444;
    }
</style>