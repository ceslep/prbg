<script lang="ts">
  import { createEventDispatcher, onMount } from 'svelte';
  import { GET_INFOCANT_ENDPOINT } from '../../constants';
  import { theme } from './themeStore';
  import Skeleton from './Skeleton.svelte';
  import type { InfoCantData } from './types';
  import { payload } from './storeConcentrador'; // Import payload store

  export let showDialog: boolean = false;

  let data: InfoCantData[] = [];
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
    } catch (e: any) {
      error = e.message;
      console.error("Error fetching InfoCant data:", e);
    } finally {
      loading = false;
    }
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
      {:else if data.length > 0}
        <div class="overflow-x-auto overflow-y-auto max-h-[60vh] rounded-lg border shadow-lg {$theme === 'dark' ? 'border-gray-700' : 'border-gray-200'}">
          <table class="min-w-full text-sm text-left {$theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}">
            <thead class="text-xs uppercase tracking-wider border-b {$theme === 'dark' ? 'bg-gray-700 text-gray-400 border-gray-600' : 'bg-gray-100 text-gray-600 border-gray-200'}">
              <tr>
                <th scope="col" class="px-4 py-3">Sede</th>
                <th scope="col" class="px-4 py-3">Nivel</th>
                <th scope="col" class="px-4 py-3">Número</th>
                <th scope="col" class="px-4 py-3">Total Estudiantes</th>
              </tr>
            </thead>
            <tbody class="divide-y {$theme === 'dark' ? 'divide-gray-700' : 'divide-gray-200'}">
              {#each data as item}
                <tr class="transition duration-200 ease-in-out {$theme === 'dark' ? 'bg-gray-800 hover:bg-gray-700' : 'bg-white hover:bg-gray-50'}">
                  <td class="px-4 py-3 text-center font-medium">{item.sede}</td>
                  <td class="px-4 py-3 text-center">{item.nivel}</td>
                  <td class="px-4 py-3 text-center">{item.numero}</td>
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