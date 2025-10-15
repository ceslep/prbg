<script lang="ts">
    import { createEventDispatcher } from 'svelte';
    import { GET_NOTAS_HISTORY_ENDPOINT } from '../../constants';
    import type { NotaHistory } from './types';
    import Skeleton from './Skeleton.svelte';
    import { theme } from './themeStore';

    export let showDialog: boolean = false;
    export let studentId: string;
    export let subject: string;
    export let periodo: string;
    export let year: string;

    let notasHistory: NotaHistory[] = [];
    let loading: boolean = false;
    let error: string | null = null;

    const dispatch = createEventDispatcher();

    function areNotasEqual(nota1: NotaHistory, nota2: NotaHistory): boolean {
        // Compare all properties except 'fechahora'
        const keys = Object.keys(nota1) as Array<keyof NotaHistory>;
        for (const key of keys) {
            if (key === 'fechahora') continue;
            if (nota1[key] !== nota2[key]) {
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
        <div class="dialog-content" on:click|stopPropagation role="dialog" aria-modal="true" tabindex="-1" on:keydown={(e) => { if (e.key === 'Escape') closeDialog(); }}>
            <h2>Historial de Notas para {studentId} - {subject}</h2>

            {#if loading}
                <Skeleton rows={5} columns={6} theme={$theme} />
            {:else if error}
                <p class="error">Error: {error}</p>
            {:else if notasHistory.length > 0}
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Periodo</th>
                                <th>Valoración</th>
                                <th>Nota 1</th>
                                <th>Aspecto 1</th>
                                <th>Fecha 1</th>
                                <th>Fecha y Hora</th>
                                <!-- Add more headers as needed -->
                            </tr>
                        </thead>
                        <tbody>
                            {#each notasHistory as nota}
                                <tr>
                                    <td>{nota.periodo}</td>
                                    <td>{nota.valoracion}</td>
                                    <td>{nota.nota1 || 'N/A'}</td>
                                    <td>{nota.aspecto1 || 'N/A'}</td>
                                    <td>{nota.fecha1 || 'N/A'}</td>
                                    <td>{nota.fechahora}</td>
                                    <!-- Add more data cells as needed -->
                                </tr>
                            {/each}
                        </tbody>
                    </table>
                </div>
            {:else}
                <p>No se encontró historial de notas para este estudiante y asignatura.</p>
            {/if}

            <button on:click={closeDialog}>Cerrar</button>
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

    .dialog-content {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        max-width: 90%;
        max-height: 90%;
        overflow-y: auto;
        color: black; /* Ensure text is visible */
    }

    .table-container {
        max-height: 400px; /* Adjust as needed */
        overflow-y: auto;
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
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }

    .error {
        color: red;
    }

    button {
        margin-top: 15px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #0056b3;
    }
</style>