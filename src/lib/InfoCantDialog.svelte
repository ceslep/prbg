<script lang="ts">
  import { createEventDispatcher, onMount } from 'svelte';
  import { GET_INFOCANT_ENDPOINT } from '../../constants';
  import { theme } from './themeStore';
  import Skeleton from './Skeleton.svelte';
  import type { InfoCantData } from './types';
  import { payload } from './storeConcentrador'; // Import payload store

  export let showDialog: boolean = false;

  let data: InfoCantData[] = [];
  let processedData: (InfoCantData & { isNivelSummary?: boolean; isSedeTotal?: boolean; isGrandTotal?: boolean; nivelDisplay?: string })[] = [];
  let loading: boolean = false;
  let error: string | null = null;

  const dispatch = createEventDispatcher();

  async function fetchInfoCant() {
    loading = true;
    error = null;
    try {
      const response = await fetch(GET_INFOCANT_ENDPOINT, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ year: $payload.year }), // Send selected year as payload
      });
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      data = await response.json();
      processData(data);
    } catch (e: any) {
      error = e.message;
      console.error("Error fetching InfoCant data:", e);
    } finally {
      loading = false;
    }
  }

  function processData(rawData: InfoCantData[]) {
    const groupedBySede: { [key: string]: InfoCantData[] } = {};
    rawData.forEach(item => {
      if (!groupedBySede[item.sede]) {
        groupedBySede[item.sede] = [];
      }
      groupedBySede[item.sede].push(item);
    });

    const tempProcessedData: (InfoCantData & { isNivelSummary?: boolean; isSedeTotal?: boolean; isGrandTotal?: boolean; nivelDisplay?: string })[] = [];
    let grandTotalStudents = 0;

    for (const sede in groupedBySede) {
      const sedeData = groupedBySede[sede];
      const groupedByNivel: { [key: number]: InfoCantData[] } = {};

      // Add individual rows for this sede
      sedeData.forEach(item => {
        tempProcessedData.push(item);
        if (!groupedByNivel[item.nivel]) {
          groupedByNivel[item.nivel] = [];
        }
        groupedByNivel[item.nivel].push(item);
      });

      let sedeTotal = 0;

      // Add nivel summary rows for this sede
      for (const nivel in groupedByNivel) {
        const nivelData = groupedByNivel[nivel];
        const nivelTotal = nivelData.reduce((sum, item) => sum + item.total_estudiantes, 0);
        sedeTotal += nivelTotal;

        tempProcessedData.push({
          sede: sede,
          nivel: parseInt(nivel),
          numero: 0, // Not applicable for nivel summary
          total_estudiantes: nivelTotal,
          isNivelSummary: true,
          nivelDisplay: `Nivel ${nivel} Total`
        });
      }

      // Add sede total row
      tempProcessedData.push({
        sede: sede,
        nivel: 0, // Not applicable for sede total
        numero: 0, // Not applicable for sede total
        total_estudiantes: sedeTotal,
        isSedeTotal: true,
        nivelDisplay: 'Total Sede'
      });
      grandTotalStudents += sedeTotal;
    }

    // Add grand total row
    tempProcessedData.push({
      sede: 'TOTAL GENERAL',
      nivel: 0,
      numero: 0,
      total_estudiantes: grandTotalStudents,
      isGrandTotal: true,
      nivelDisplay: ''
    });

    processedData = tempProcessedData;
  }

  onMount(() => {
    if (showDialog) {
      fetchInfoCant();
    }
  });

  $: if (showDialog) {
    fetchInfoCant();
  }

  function closeDialog() {
    showDialog = false;
    dispatch('close');
  }
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
      <h2 class="{$theme === 'dark' ? 'text-white' : 'text-gray-800'}">Información de Cantidades</h2>

      {#if loading}
        <Skeleton rows={5} columns={4} theme={$theme} />
      {:else if error}
        <p class="{$theme === 'dark' ? 'text-red-400' : 'text-red-600'}">Error: {error}</p>
      {:else if processedData.length > 0}
        <div class="overflow-x-auto overflow-y-auto max-h-[60vh] rounded-lg border shadow-lg {$theme === 'dark' ? 'border-gray-700' : 'border-gray-200'}">
          <table class="min-w-full text-sm text-left {$theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}">
            <thead class="sticky top-0 z-10 text-xs uppercase tracking-wider border-b {$theme === 'dark' ? 'bg-gray-700 text-gray-400 border-gray-600' : 'bg-gray-100 text-gray-600 border-gray-200'}">
              <tr>
                <th scope="col" class="px-4 py-3">Sede</th>
                <th scope="col" class="px-4 py-3">Nivel</th>
                <th scope="col" class="px-4 py-3">Número</th>
                <th scope="col" class="px-4 py-3">Total Estudiantes</th>
              </tr>
            </thead>
            <tbody class="divide-y {$theme === 'dark' ? 'divide-gray-700' : 'divide-gray-200'}">
              {#each processedData as item, i}
                <tr class={`transition duration-200 ease-in-out
                  ${item.isGrandTotal ? ($theme === 'dark' ? 'bg-purple-900 text-white font-extrabold text-lg' : 'bg-purple-200 text-purple-800 font-extrabold text-lg') :
                  item.isSedeTotal ? ($theme === 'dark' ? 'bg-blue-900 text-white font-bold' : 'bg-blue-100 text-blue-800 font-bold') :
                  item.isNivelSummary ? ($theme === 'dark' ? 'bg-green-900 text-white font-semibold' : 'bg-green-100 text-green-800 font-semibold') :
                  (i % 2 === 0 ? ($theme === 'dark' ? 'bg-gray-800 hover:bg-gray-700' : 'bg-white hover:bg-gray-50') : ($theme === 'dark' ? 'bg-gray-700' : 'bg-gray-100'))}`}>
                  <td class="px-4 py-3 text-center font-medium">
                    {#if item.isGrandTotal}
                      {item.sede}
                    {:else if item.isSedeTotal}
                      {item.sede}
                    {:else}
                      {item.sede}
                    {/if}
                  </td>
                  <td class="px-4 py-3 text-center">
                    {#if item.isSedeTotal}
                      {item.nivelDisplay}
                    {:else if item.isNivelSummary}
                      {item.nivelDisplay}
                    {:else if !item.isGrandTotal}
                      {item.nivel}
                    {/if}
                  </td>
                  <td class="px-4 py-3 text-center">
                    {#if !item.isGrandTotal && !item.isSedeTotal && !item.isNivelSummary}
                      {item.numero}
                    {/if}
                  </td>
                  <td class="px-4 py-3 text-center">{item.total_estudiantes}</td>
                </tr>
              {/each}
            </tbody>
          </table>
        </div>
      {:else}
        <p class="{$theme === 'dark' ? 'text-gray-400' : 'text-gray-600'}">No se encontraron datos de cantidades.</p>
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
</style>