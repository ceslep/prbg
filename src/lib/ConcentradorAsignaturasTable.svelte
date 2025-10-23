<script lang="ts">
  import type { EstudianteRow, ConcentradorParsed, NotasDetalladoPayload } from './types'
  import type { ConcentradorPayload } from './api'
  import { theme } from './themeStore'
  import VirtualRows from './VirtualRows.svelte'

  export let parsed: ConcentradorParsed | null
  export let loading: boolean
  export let handleValoracionClick: (est: EstudianteRow, asignaturaAbrev: string, periodo: string, valoracion: string) => Promise<void>
  export let handleShowInasistencias: (estudianteId: string, nombres: string, asignatura: string, periodo: string) => void
  export let asignaturasOrden: string[]
  export let showPeriodos: boolean
  export let selectedPeriodos: string[]
  export let payload: ConcentradorPayload

  let search = ''

  $: filteredEstudiantes = (() => {
    if (!parsed) return [] as EstudianteRow[]
    const list = parsed.estudiantes
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

  function getPeriodBorderColor(periodo: string) {
    switch (periodo) {
      case 'UNO': return 'border-blue-500'
      case 'DOS': return 'border-green-500'
      case 'TRES': return 'border-yellow-500'
      case 'CUATRO': return 'border-purple-500'
      case 'D': return 'border-indigo-500'
      default: return 'border-gray-500'
    }
  }

  function getShortPeriodName(periodo: string) {
    switch (periodo) {
      case 'UNO': return '1'
      case 'DOS': return '2'
      case 'TRES': return '3'
      case 'CUATRO': return '4'
      case 'DEF': return 'D'
      default: return periodo
    }
  }

  function getItemName(abreviatura: string) {
    if (!parsed || !parsed.asignaturas) return abreviatura
    const item = parsed.asignaturas.find(a => a.abreviatura === abreviatura)
    return item ? item.nombre : abreviatura
  }

  function colorNota(valor: string) {
    if (!valor) return $theme === 'dark' ? 'bg-gray-700 text-gray-400' : 'bg-gray-200 text-gray-700'
    const v = parseFloat(valor)
    if (isNaN(v)) return $theme === 'dark' ? 'bg-gray-700 text-gray-400' : 'bg-gray-200 text-gray-700'
    if (v >= 4) return 'bg-emerald-500 text-white'
    if (v >= 3) return 'bg-amber-500 text-white'
    return 'bg-rose-500 text-white'
  }
</script>

{#if parsed && !loading}
  <div class="rounded-lg shadow-lg overflow-hidden flex-grow {$theme === 'dark' ? 'bg-gray-800' : 'bg-gray-100'}">
    <div class="overflow-x-auto overflow-y-auto max-h-[70vh]">
      <table class="min-w-full text-sm text-left {$theme === 'dark' ? 'text-gray-300' : 'text-gray-900'}">
        <thead class="text-xs uppercase tracking-wider sticky top-0 z-10 {$theme === 'dark' ? 'bg-gray-700 text-gray-400' : 'bg-gray-200 text-gray-600'}">
          <tr>
            <th scope="col" class="p-2 text-left sticky left-0 z-10 {$theme === 'dark' ? 'bg-gray-700' : 'bg-gray-200'}" rowspan="{showPeriodos ? 2 : 1}">
              <div class="flex flex-col">
                <span class="flex items-center gap-1">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                  </svg>
                  Estudiante
                </span>
                <input
                  placeholder="Buscar estudiante..."
                  bind:value={search}
                  class="rounded-md px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 mt-1 {$theme === 'dark' ? 'bg-gray-600 border-gray-500 text-white' : 'bg-gray-100 border-gray-300 text-gray-900'}"
                />
              </div>
            </th>
            {#each asignaturasOrden as itemAbrev}
              {#if itemAbrev}
                <th scope="col" class="p-2 whitespace-nowrap text-center">
                  <span class="block text-xs font-medium">{getItemName(itemAbrev)}</span>
                </th>
              {/if}
            {/each}
          </tr>
          {#if showPeriodos}
            <tr class="border-t {$theme === 'dark' ? 'bg-gray-700 border-gray-600' : 'bg-gray-200 border-gray-300'}">
              {#each asignaturasOrden as itemAbrev}
                {#if itemAbrev}
                  <th class="p-0">
                    <div class="grid gap-1 justify-items-center" style="grid-template-columns: repeat({selectedPeriodos.length + 1}, minmax(32px, 1fr));">
                      {#each selectedPeriodos.filter((p: string) => p !== 'DEF') as per}
                        <span class="px-1 rounded-full border-2 {getPeriodBorderColor(per)}" title="{itemAbrev} - {per}">
                          {getShortPeriodName(per)}
                        </span>
                      {/each}
                      <span class="rounded-md px-1 text-xs font-bold border-2 {getPeriodBorderColor('D')}" title="{itemAbrev} - Definitiva">
                        DEF
                      </span>
                    </div>
                  </th>
                {/if}
              {/each}
            </tr>
          {/if}
        </thead>
        <tbody class="divide-y {$theme === 'dark' ? 'divide-gray-700' : 'divide-gray-300'}">
          {#each filteredEstudiantes as est (est.nombres)}
            <tr class="transition duration-150 {$theme === 'dark' ? 'hover:bg-gray-700' : 'hover:bg-gray-200'}">
              <td class="p-4 font-medium sticky left-0 z-10 whitespace-nowrap {$theme === 'dark' ? 'text-white bg-gray-800 hover:bg-gray-700' : 'text-gray-900 bg-gray-100 hover:bg-gray-200'}">{est.nombres}</td>
              {#each asignaturasOrden as itemAbrev}
                {#if itemAbrev}
                  <td class="p-2 text-center align-middle">
                    {#if !showPeriodos}
                      <button
                        class="font-bold text-lg {colorNota(valorPeriodo(est, itemAbrev, payload.periodo))} px-2 py-1 rounded-md border-2 {getPeriodBorderColor(payload.periodo)} cursor-pointer"
                        on:click={() => handleValoracionClick(est, itemAbrev, payload.periodo, valorPeriodo(est, itemAbrev, payload.periodo))}
                        title="{est.nombres} - {getItemName(itemAbrev)} - {getShortPeriodName(payload.periodo)}: {valorPeriodo(est, itemAbrev, payload.periodo)}"
                      >
                        {valorPeriodo(est, itemAbrev, payload.periodo)}
                      </button>
                    {:else}
                      <div class="grid gap-1 justify-items-center" style="grid-template-columns: repeat({selectedPeriodos.length + 1}, minmax(32px, 1fr));">
                        {#each selectedPeriodos.filter((p: string) => p !== 'DEF') as per}
                          <button
                            class="rounded-md px-1 py-1 text-xs font-bold {colorNota(valorPeriodo(est, itemAbrev, per))} border-2 {getPeriodBorderColor(per)} cursor-pointer"
                            on:click={() => handleValoracionClick(est, itemAbrev, per, valorPeriodo(est, itemAbrev, per))}
                            title="{est.nombres} - {getItemName(itemAbrev)} - {getShortPeriodName(per)}: {valorPeriodo(est, itemAbrev, per) || '-'}"
                          >
                            {valorPeriodo(est, itemAbrev, per) || '-'}
                          </button>
                        {/each}
                        <button
                          class="rounded-md px-1 py-1 text-xs font-bold {colorNota(valorPeriodo(est, itemAbrev, 'DEF'))} border-2 {getPeriodBorderColor('D')} cursor-pointer"
                          on:click={() => handleValoracionClick(est, itemAbrev, 'DEF', valorPeriodo(est, itemAbrev, 'DEF'))}
                          title="{est.nombres} - {getItemName(itemAbrev)} - Definitiva: {valorPeriodo(est, itemAbrev, 'DEF') || '-'}"
                        >
                          {valorPeriodo(est, itemAbrev, 'DEF') || '-'}
                        </button>
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