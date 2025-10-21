<script lang="ts">
  import { onMount } from 'svelte';
  import { fetchInasistenciasDetallado } from './api';
  import type { Inasistencia, InasistenciasDetalladoPayload } from './types';
  import Skeleton from './Skeleton.svelte';
  import { theme } from './themeStore';

  export let showDialog: boolean;
  export let estudianteId: string;
  export let nombres: string;
  export let asignatura: string;
  export let periodo: string;

  let inasistencias: Inasistencia[] = [];
  let loading = false;
  let error: string | null = null;

  function closeDialog() {
    showDialog = false;
    inasistencias = [];
    error = null;
  }

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

  // Reactive statement to re-fetch data when props change and dialog is open
  let lastFetchedKey: string | null = null;
  $: {
    if (showDialog && estudianteId && nombres && asignatura && periodo) {
      const key = `${estudianteId}-${nombres}-${asignatura}-${periodo}`;
      if (key !== lastFetchedKey) {
        lastFetchedKey = key;
        loadInasistencias();
      }
    } else if (!showDialog) {
      lastFetchedKey = null;
      inasistencias = []; // Clear data when dialog is closed
    }
  }
</script>

{#if showDialog}
  <div class="fixed inset-0 bg-black bg-opacity-80 flex items-center justify-center p-4 z-50 backdrop-blur-sm transition-opacity duration-300"
       class:opacity-100={showDialog}
       class:opacity-0={!showDialog}>
    <div class="rounded-2xl shadow-2xl max-w-3xl w-full max-h-[90vh] overflow-hidden flex flex-col border transform transition-all duration-300 ease-out
                {$theme === 'dark' ? 'bg-gradient-to-br from-gray-800 to-gray-900 border-gray-700' : 'bg-white border-gray-300'}"
         class:scale-100={showDialog}
         class:scale-95={!showDialog}
         class:opacity-100={showDialog}
         class:opacity-0={!showDialog}>
      <div class="flex justify-between items-center p-4 border-b
                  {$theme === 'dark' ? 'border-gray-700 bg-gray-800' : 'border-gray-200 bg-gray-50'}">
        <h3 class="text-2xl font-extrabold tracking-wide {$theme === 'dark' ? 'text-white' : 'text-gray-800'}">
          Inasistencias Detalladas
          {#if nombres}
            <span class="text-sm {$theme === 'dark' ? 'text-yellow-400' : 'text-yellow-600'}">Estudiante: {nombres}</span><br>
          {/if}
          {#if asignatura}
            <span class="text-sm {$theme === 'dark' ? 'text-purple-400' : 'text-purple-600'}">Asignatura: {asignatura}</span>
          {/if}
          {#if periodo}
            <span class="text-sm {$theme === 'dark' ? 'text-green-400' : 'text-green-600'}">Periodo: {periodo}</span>
          {/if}
        </h3>
        <button on:click={closeDialog} class="text-gray-400 hover:text-red-500 transition duration-300 transform hover:scale-110" title="Cerrar">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>

      <div class="p-4 overflow-y-auto flex-grow {$theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}">
        {#if loading}
          <Skeleton rows={5} columns={4} theme={$theme} />
        {:else if error}
          <p class="error text-red-500">Error al cargar las inasistencias: {error}</p>
        {:else if inasistencias.length > 0}
          <div class="overflow-x-auto rounded-lg border shadow-lg
                      {$theme === 'dark' ? 'border-gray-700' : 'border-gray-200'}">
            <table class="min-w-full text-sm text-left
                          {$theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}">
              <thead class="text-xs uppercase tracking-wider border-b
                            {$theme === 'dark' ? 'bg-gray-700 text-gray-400 border-gray-600' : 'bg-gray-100 text-gray-600 border-gray-200'}">
                <tr>
                  <th scope="col" class="px-6 py-3">Fecha</th>
                  <th scope="col" class="px-6 py-3">Horas</th>
                  <th scope="col" class="px-6 py-3">Hora Clase</th>
                  <th scope="col" class="px-6 py-3">Detalle</th>
                  <th scope="col" class="px-6 py-3">Causa Excusa</th>
                  <th scope="col" class="px-6 py-3">Motivo Excusa</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-200 {$theme === 'dark' ? 'divide-gray-700 bg-gray-800' : 'bg-white'}">
                {#each inasistencias as inasistencia (inasistencia.ind)}
                  <tr class="{$theme === 'dark' ? 'hover:bg-gray-700' : 'hover:bg-gray-100'}">
                    <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'} {inasistencia.fecha.length < 4 ? 'text-center' : ''}">{inasistencia.fecha}</td>
                    <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'} !text-center">{inasistencia.horas}</td>
                    <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'} {inasistencia.hora_clase.length < 4 ? 'text-center' : ''}">{inasistencia.hora_clase}</td>
                    <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'}">
                      {#if inasistencia.excusa_motivo}
                        <span class="flex items-center justify-center gap-1" title="Excusa presente">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-500" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M8.257 3.099c.765-1.3 2.647-1.3 3.412 0l7.66 13.139A1.999 1.999 0 0118 18H2a1.999 1.999 0 01-1.66-2.762l7.66-13.14zM10 6a1 1 0 011 1v3a1 1 0 11-2 0V7a1 1 0 011-1zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
                          </svg>
                        </span>
                      {:else if inasistencia.detalle}
                        <span class="flex items-center justify-center gap-1">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-500" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
                          </svg>
                          {inasistencia.detalle}
                        </span>
                      {:else}
                        <span class="flex items-center justify-center">N/A</span>
                      {/if}
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'}">
                      {#if inasistencia.excusa_causa}
                        <span class="flex items-center gap-1 {inasistencia.excusa_causa.length < 4 ? 'justify-center' : ''}">
                          {inasistencia.excusa_causa}
                        </span>
                      {:else}
                        <span class="flex items-center justify-center">N/A</span>
                      {/if}
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap {$theme === 'dark' ? 'text-gray-200' : 'text-gray-900'}">
                      {#if inasistencia.excusa_motivo}
                        <span class="flex items-center gap-1 {inasistencia.excusa_motivo.length < 4 ? 'justify-center' : ''}">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                          </svg>
                          {inasistencia.excusa_motivo}
                        </span>
                      {:else}
                        <span class="flex items-center justify-center">N/A</span>
                      {/if}
                    </td>
                  </tr>
                {/each}
              </tbody>
            </table>
          </div>
        {:else}
          <p class="text-center py-8 {$theme === 'dark' ? 'text-gray-400' : 'text-gray-600'}">No se encontraron inasistencias para los criterios seleccionados.</p>
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

<style>
  /* Remove the old .inasistencias-detallado style as it's now a dialog */
  /*
  .inasistencias-detallado {
    margin: 20px;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }
  */

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