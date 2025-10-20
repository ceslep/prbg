<script lang="ts">
  import { onMount } from 'svelte';
  import { fetchInasistenciasDetallado } from './api';
  import type { Inasistencia, InasistenciasDetalladoPayload } from './types';
  import Skeleton from './Skeleton.svelte';
  import { theme } from './themeStore';

  export let estudianteId: string;
  export let nombres: string;
  export let asignatura: string;
  export let periodo: string;

  let inasistencias: Inasistencia[] = [];
  let loading = false;
  let error: string | null = null;

  async function loadInasistencias() {
    loading = true;
    error = null;
    try {
      const payload: InasistenciasDetalladoPayload = {
        estudiante: estudianteId,
        nombres: nombres,
        asignatura: asignatura,
        periodo: periodo
      };
      inasistencias = await fetchInasistenciasDetallado(payload);
    } catch (e: any) {
      error = e.message;
    } finally {
      loading = false;
    }
  }

  // Reactive statement to re-fetch data when props change
  let lastFetchedKey: string | null = null;
  $: {
    const key = `${estudianteId}-${nombres}-${asignatura}-${periodo}`;
    if (estudianteId && nombres && asignatura && periodo) {
      if (key !== lastFetchedKey) {
        lastFetchedKey = key;
        loadInasistencias();
      }
    } else {
      lastFetchedKey = null;
      inasistencias = []; // Clear data if props are not complete
    }
  }
</script>

<div class="inasistencias-detallado {$theme === 'dark' ? 'bg-gray-800 text-white' : 'bg-white text-gray-900'}">
  <h2 class="text-xl font-bold mb-4">Inasistencias Detalladas para {nombres} - {asignatura} ({periodo})</h2>

  {#if loading}
    <Skeleton rows={5} columns={4} theme={$theme} />
  {:else if error}
    <p class="error text-red-500">Error al cargar las inasistencias: {error}</p>
  {:else if inasistencias.length > 0}
    <div class="overflow-x-auto">
      <table class="min-w-full divide-y divide-gray-200 {$theme === 'dark' ? 'divide-gray-700' : ''}">
        <thead class="{$theme === 'dark' ? 'bg-gray-700' : 'bg-gray-50'}">
          <tr>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider {$theme === 'dark' ? 'text-gray-300' : ''}">Fecha</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider {$theme === 'dark' ? 'text-gray-300' : ''}">Horas</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider {$theme === 'dark' ? 'text-gray-300' : ''}">Hora Clase</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider {$theme === 'dark' ? 'text-gray-300' : ''}">Detalle</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-200 {$theme === 'dark' ? 'divide-gray-700 bg-gray-800' : 'bg-white'}">
          {#each inasistencias as inasistencia (inasistencia.ind)}
            <tr class="{$theme === 'dark' ? 'hover:bg-gray-700' : 'hover:bg-gray-100'}">
              <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'}">{inasistencia.fecha}</td>
              <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'}">{inasistencia.horas}</td>
              <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'}">{inasistencia.hora_clase}</td>
              <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'}">{inasistencia.detalle}</td>
            </tr>
          {/each}
        </tbody>
      </table>
    </div>
  {:else}
    <p class="{$theme === 'dark' ? 'text-gray-400' : 'text-gray-600'}">No se encontraron inasistencias para los criterios seleccionados.</p>
  {/if}
</div>

<style>
  .inasistencias-detallado {
    margin: 20px;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  table {
    width: 100%;
    border-collapse: collapse;
  }

  th, td {
    border: 1px solid #e2e8f0;
    padding: 8px;
    text-align: left;
  }

  th {
    background-color: #f7fafc;
  }
</style>