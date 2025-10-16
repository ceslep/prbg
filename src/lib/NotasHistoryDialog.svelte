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
    $: if (notasHistory.length > 0) {
        const allKeys = Object.keys(notasHistory[0]);
        const notaKeys = allKeys.filter(key => key.startsWith('nota') && key.length <= 6 && parseInt(key.substring(4)) >= 1 && parseInt(key.substring(4)) <= 12);
        columnNames = notaKeys;
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
        notas.forEach(nota => {
            if (!uniqueNotas.some(uniqueNota => areNotasEqual(uniqueNota, nota))) {
                uniqueNotas.push(nota);
            }
        });
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

    $: if (showDialog && studentId && subject && periodo && year) {
        fetchNotasHistory();
    }

    function closeDialog() {
        showDialog = false;
        dispatch('close');
    }
</script>

{#if showDialog}
    <div class="dialog-backdrop" on:click={closeDialog} role="button" tabindex="0" on:keydown={(e) => { if (e.key === 'Escape') closeDialog(); }}>
        <div class="dialog-content flex flex-col p-6 {$theme === 'dark' ? 'bg-gradient-to-br from-gray-800 to-gray-900 text-gray-200' : 'bg-white text-gray-800'}" on:click|stopPropagation role="dialog" aria-modal="true" tabindex="-1" on:keydown={(e) => { if (e.key === 'Escape') closeDialog(); }}>
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
                                    <th class="{$theme === 'dark' ? 'bg-gray-700 text-gray-400' : 'bg-gray-100 text-gray-600'}">{colName.replace('nota', 'N')}</th>
                                {/each}
                            </tr>
                        </thead>
                        <tbody>
                            {#each notasHistory as nota}
                                <tr class="{$theme === 'dark' ? 'bg-gray-800 hover:bg-gray-700' : 'bg-white hover:bg-gray-50'}">
                                    {#each columnNames as colName}
                                        {@const aspectoColName = colName.replace('nota', 'aspecto')}
                                        {@const fechaColName = colName.replace('nota', 'fecha')}
                                        {@const hintText = `Aspecto: ${nota[aspectoColName] || 'N/A'}\nFecha: ${nota[fechaColName] || 'N/A'}`}
                                        <td class="text-center">
                                            <Tooltip content="{hintText}">
                                                {nota[colName] || ''}
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

            <button on:click={closeDialog} class="mt-4 ml-auto px-4 py-2 rounded-md text-white font-semibold transition duration-200 {$theme === 'dark' ? 'bg-blue-600 hover:bg-blue-700' : 'bg-blue-500 hover:bg-blue-600'}">Cerrar</button>
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
        max-height: 400px; /* Adjust as needed */
        overflow-y: auto;
        overflow-x: auto; /* Added for horizontal scrolling */
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
        /* Removed text-align: left; to allow Tailwind's text-center to work */
    }

    th {
        /* background-color: #f2f2f2; */
        text-align: center; /* Ensure headers are centered */
    }

    /* Removed .error and button styles as they are now handled by Tailwind */
</style>