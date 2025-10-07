<script lang="ts">
  import PayloadForm from './lib/PayloadForm.svelte'
  import { loadConcentrador, loading, error, rawHTML, parsed, showPeriodos, selectedPeriodos, asignaturasOrden, lastDuration, exportCSV, payload } from './lib/storeConcentrador'
  import type { EstudianteRow } from './lib/types'
  import { onMount } from 'svelte'

  let search = ''

  onMount(() => {
    if (!$parsed) {
      loadConcentrador()
    }
  }); // Corrected: added semicolon and closing curly brace

  $: filteredEstudiantes = (() => {
    if (!$parsed) return [] as EstudianteRow[]
    const list = $parsed.estudiantes
    if (!search.trim()) return list
    const q = search.toLowerCase()
    return list.filter((est: EstudianteRow) => est.nombres.toLowerCase().includes(q))
  })()

  function valorPeriodo(est: EstudianteRow, asignatura: string, periodo: string) {
    const a = est.asignaturas.find(a => a.asignatura === asignatura)
    if (!a) return ''
    const p = a.periodos.find(p => p.periodo === periodo)
    return p ? p.valoracion.toFixed(1) : ''
  }

  function promedioDef(est: EstudianteRow, asignatura: string) {
    return valorPeriodo(est, asignatura, 'DEF')
  }

  function colorNota(valor: string) {
    if (!valor) return 'bg-gray-700 text-gray-400'
    const v = parseFloat(valor)
    if (isNaN(v)) return 'bg-gray-700 text-gray-400'
    if (v >= 4) return 'bg-emerald-500 text-white'
    if (v >= 3) return 'bg-amber-500 text-white'
    return 'bg-rose-500 text-white'
  }

  function getPeriodBorderColor(periodo: string) {
    switch (periodo) {
      case 'UNO': return 'border-blue-500';
      case 'DOS': return 'border-green-500';
      case 'TRES': return 'border-yellow-500';
      case 'CUATRO': return 'border-purple-500';
      case 'D': return 'border-indigo-500';
      default: return 'border-gray-500';
    }
  }

  function getShortPeriodName(periodo: string) {
    switch (periodo) {
      case 'UNO': return '1';
      case 'DOS': return '2';
      case 'TRES': return '3';
      case 'CUATRO': return '4';
      case 'DEF': return 'D';
      default: return periodo;
    }
  }

  function getAsignaturaName(abreviatura: string) {
    if (!$parsed || !$parsed.asignaturas) return abreviatura;
    const asignatura = $parsed.asignaturas.find(a => a.abreviatura === abreviatura);
    return asignatura ? asignatura.nombre : abreviatura;
  }


</script>

<div class="bg-gray-900 min-h-screen text-white p-4 sm:p-6 lg:p-8 space-y-6">
  <header class="flex justify-between items-center">
    
    {#if $lastDuration}<span class="text-xs text-gray-500">Carga en: {$lastDuration}ms</span>{/if}
  </header>

  <section class="bg-gray-800 rounded-lg p-6 shadow-lg mt-0">
    
    <PayloadForm disabled={$loading} />
    <div class="mt-6 flex gap-4 items-center flex-wrap justify-between"> <!-- Added justify-between -->
      <div class="flex items-center"> <!-- Group checkbox and label -->
        <input id="fld-show-periodos" type="checkbox" bind:checked={$showPeriodos} class="h-5 w-5 bg-gray-700 border-gray-600 rounded text-blue-500 focus:ring-blue-500" />
        <label for="fld-show-periodos" class="ml-3 text-gray-300">Mostrar Periodos</label>
      </div>

      <div class="flex gap-4 items-center"> <!-- Group buttons -->
        <button onclick={loadConcentrador} class="px-4 py-2 rounded-md bg-blue-600 text-white font-semibold hover:bg-blue-700 transition duration-200 disabled:opacity-50 disabled:cursor-not-allowed flex items-center" disabled={$loading} title="Consultar">
          {#if $loading}
            <svg class="animate-spin h-5 w-5 mr-3" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            <span>Cargando...</span>
          {:else}
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          {/if}
        </button>
        <button onclick={exportCSV} class="px-4 py-2 rounded-md bg-emerald-600 text-white font-semibold hover:bg-emerald-700 transition duration-200 disabled:opacity-50 flex items-center" disabled={!$parsed} title="Exportar CSV">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
          </svg>
        </button>
      </div>
    </div>
  </section>

  {#if $error}
    <div class="bg-rose-800 border border-rose-700 text-white px-4 py-3 rounded-lg relative" role="alert">
      <strong class="font-bold">Error:</strong>
      <span class="block sm:inline">{$error}</span>
    </div>
  {/if}

  {#if $parsed && !$loading}
    <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full text-sm text-left text-gray-300">
          <thead class="bg-gray-700 text-xs text-gray-400 uppercase tracking-wider sticky top-0 z-10">
            <tr>
              <th scope="col" class="p-2 text-left sticky left-0 bg-gray-700 z-10" rowspan="{$showPeriodos ? 2 : 1}">
                <div class="flex flex-col">
                  <span>Estudiante</span>
                  <input placeholder="Buscar estudiante..." bind:value={search} class="bg-gray-600 border border-gray-500 rounded-md px-2 py-1 text-sm text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 mt-1" />
                </div>
              </th>
              {#each $asignaturasOrden as asig}
                {#if asig}
                  <th scope="col" class="p-2 whitespace-nowrap text-center">
                    <span class="block text-xs font-medium">{getAsignaturaName(asig)}</span>
                  </th>
                {/if}
              {/each}
            </tr>
            {#if $showPeriodos}
              <tr class="bg-gray-700 border-t border-gray-600">
                {#each $asignaturasOrden as asig}
                  {#if asig}
                    <th class="p-0">
                      <div class="grid gap-1 justify-items-center" style="grid-template-columns: repeat({$selectedPeriodos.length + 1}, minmax(32px, 1fr));">
                        {#each $selectedPeriodos.filter(p => p !== 'DEF') as per}
                          <span class="px-1 rounded-full border-2 {getPeriodBorderColor(per)}" title="{asig} - {per}">
                                {getShortPeriodName(per)}
                              </span>
                            {/each}
                            <span class="rounded-md px-1 text-xs font-bold border-2 {getPeriodBorderColor('D')}" title="{asig} - Definitiva">
                              DEF
                            </span>
                          </div>
                      </th>
                  {/if}
                {/each}
              </tr>
            {/if}
          </thead>
          <tbody class="divide-y divide-gray-700">
            {#each filteredEstudiantes as est (est.nombres)}
              <tr class="hover:bg-gray-700 transition duration-150">
                <td class="p-4 font-medium text-white sticky left-0 bg-gray-800 hover:bg-gray-700 z-10 whitespace-nowrap">{est.nombres}</td>
                {#each $asignaturasOrden as asig}
                  {#if asig}
                    <td class="p-2 text-center align-middle">
                      {#if !$showPeriodos}
                        <span class="font-bold text-lg {colorNota(valorPeriodo(est, asig, $payload.periodo))} px-2 py-1 rounded-md border-2 {getPeriodBorderColor($payload.periodo)}">{valorPeriodo(est, asig, $payload.periodo)}</span>
                      {:else}
                        <div class="grid gap-1 justify-items-center" style="grid-template-columns: repeat({$selectedPeriodos.length + 1}, minmax(32px, 1fr));">
                          {#each $selectedPeriodos.filter(p => p !== 'DEF') as per}
                            <span class="rounded-md px-1 py-1 text-xs font-bold {colorNota(valorPeriodo(est, asig, per))} border-2 {getPeriodBorderColor(per)}" title="{asig} - {per}">
                              {valorPeriodo(est, asig, per) || '-'}
                            </span>
                          {/each}
                          <span class="rounded-md px-1 py-1 text-xs font-bold {colorNota(valorPeriodo(est, asig, 'DEF'))} border-2 {getPeriodBorderColor('D')}" title="{asig} - Definitiva">
                            {valorPeriodo(est, asig, 'DEF') || '-'}
                          </span>
                        </div>
                      {/if}
                    </td>
                  {/if}
                {/each}
              </tr>
            {/each}
          </tbody>
        </table>
      </div>
    </div>
  {/if}
</div>