<script lang="ts">
  import PayloadForm from './lib/PayloadForm.svelte'
  import { loadConcentrador, loading, error, rawHTML, parsed, showPeriodos, selectedPeriodos, asignaturasOrden, lastDuration, exportCSV, exportExcel, payload } from './lib/storeConcentrador'
  import type { EstudianteRow, NotasDetalladoPayload, NotaDetalle } from './lib/types'
  import { onMount } from 'svelte'
  import NotasDetalleDialog from './lib/NotasDetalleDialog.svelte'
  import Skeleton from './lib/Skeleton.svelte'
  import { theme } from './lib/themeStore'
  import { fetchNotasDetallado } from './lib/api'
  import VirtualRows from './lib/VirtualRows.svelte'

  let search = ''
  let showNotasDetalleDialog = false
  let currentNotasDetalle: NotaDetalle[] = []
  let notasDetalleLoading = false
  let notasDetalleError: string | null = null
  let selectedStudentName = ''
  let selectedEstudianteId = ''
  let selectedAsignaturaNombre = ''
  let showPayloadForm = true // Controla visibilidad del formulario

  onMount(() => {
    // loadConcentrador() will now be called from PayloadForm.svelte after it initializes
  })

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
    if (!valor) return $theme === 'dark' ? 'bg-gray-700 text-gray-400' : 'bg-gray-200 text-gray-700'
    const v = parseFloat(valor)
    if (isNaN(v)) return $theme === 'dark' ? 'bg-gray-700 text-gray-400' : 'bg-gray-200 text-gray-700'
    if (v >= 4) return 'bg-emerald-500 text-white'
    if (v >= 3) return 'bg-amber-500 text-white'
    return 'bg-rose-500 text-white'
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

  function getAsignaturaName(abreviatura: string) {
    if (!$parsed || !$parsed.asignaturas) return abreviatura
    const asignatura = $parsed.asignaturas.find(a => a.abreviatura === abreviatura)
    return asignatura ? asignatura.nombre : abreviatura
  }

  async function handleValoracionClick(est: EstudianteRow, asignaturaAbrev: string, periodo: string, valoracion: string) {
    if (!valoracion || valoracion === '-') return

    showNotasDetalleDialog = true
    currentNotasDetalle = []
    notasDetalleLoading = true
    notasDetalleError = null

    const selectedAsignatura = $parsed?.asignaturas?.find(a => a.abreviatura === asignaturaAbrev)
    selectedEstudianteId = est.id
    selectedStudentName = est.nombres
    selectedAsignaturaNombre = selectedAsignatura?.nombre || asignaturaAbrev

    const payloadDetalle: NotasDetalladoPayload = {
      estudiante: est.id,
      nombres: est.nombres,
      asignatura: selectedAsignatura?.nombre || asignaturaAbrev,
      asignat: asignaturaAbrev,
      valoracion: valoracion,
      periodo: periodo,
      year: $payload.year,
      asignacion: $payload.Asignacion,
      nivel: $payload.nivel,
      numero: $payload.numero,
    }

    try {
      const data = await fetchNotasDetallado(payloadDetalle)
      currentNotasDetalle = data
    } catch (e: any) {
      notasDetalleError = e.message || 'Error al cargar el detalle de notas.'
    } finally {
      notasDetalleLoading = false
    }
  }
</script>

<div class="min-h-screen p-4 sm:p-6 lg:p-8 space-y-6 flex flex-col {$theme === 'dark' ? 'bg-gray-900 text-white' : 'bg-white text-gray-900'}">

  <!-- === CABECERA === -->
  <header class="flex justify-between items-center flex-wrap gap-3">
    <div class="flex gap-2">
      <!-- Botón de tema -->
      <button
        on:click={theme.toggle}
        class="p-2 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme === 'dark' ? 'bg-gray-700 text-gray-300 hover:bg-gray-600' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}"
        aria-label="Toggle theme"
      >
        {#if $theme === 'dark'}
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
          </svg>
        {:else}
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
          </svg>
        {/if}
      </button>

      <!-- Botón para ocultar/mostrar formulario -->
      <button
        on:click={() => showPayloadForm = !showPayloadForm}
        class="p-2 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme === 'dark' ? 'bg-gray-700 text-gray-300 hover:bg-gray-600' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}"
        title="{showPayloadForm ? 'Ocultar Controles' : 'Mostrar Controles'}"
      >
        {#if showPayloadForm}
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
          </svg>
        {:else}
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.542-7 1.274-4.057 5.064-7 9.542-7 .79 0 1.573.114 2.317.325M12 12l2.5-2.5M12 12l-2.5 2.5M12 12l-2.5-2.5M12 12l2.5 2.5" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
          </svg>
        {/if}
      </button>

      <!-- Botón para exportar CSV -->
      <button
        on:click={exportCSV}
        disabled={$loading}
        class="p-2 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme === 'dark' ? 'bg-gray-700 text-gray-300 hover:bg-gray-600' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}"
        aria-label="Exportar CSV"
        title="Exportar a CSV"
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M9 13h6m-3-3v6m5 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
        </svg>
      </button>

      <!-- Botón para exportar Excel -->
      <button
        on:click={exportExcel}
        disabled={$loading}
        class="p-2 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme === 'dark' ? 'bg-gray-700 text-gray-300 hover:bg-gray-600' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}"
        aria-label="Exportar Excel"
        title="Exportar a Excel"
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
        </svg>
      </button>

      <!-- Botón para recargar datos -->
      <button
        on:click={() => loadConcentrador(true)}
        disabled={$loading}
        class="p-2 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme === 'dark' ? 'bg-gray-700 text-gray-300 hover:bg-gray-600' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}"
        aria-label="Recargar Datos"
        title="Recargar Datos"
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
        </svg>
      </button>
    </div>

    <!-- Indicador de tiempo de carga -->
    {#if $lastDuration}
      <span class="text-xs {$theme === 'dark' ? 'text-gray-500' : 'text-gray-600'}">Carga en: {$lastDuration}ms</span>
    {/if}
  </header>

  <!-- === FORMULARIO COLAPSABLE === -->
  {#if showPayloadForm}
    <section class="rounded-lg p-6 shadow-lg mt-0 {$theme === 'dark' ? 'bg-gray-800' : 'bg-gray-100'}">
      <PayloadForm disabled={$loading} />
    </section>
  {/if}

  <!-- === CONTROLES SIEMPRE VISIBLES === -->
  <div class="flex flex-wrap gap-4 items-center">
    <label class="flex items-center space-x-2">
      <input
        type="checkbox"
        bind:checked={$showPeriodos}
        class="h-4 w-4 text-blue-500 rounded focus:ring-blue-500 {$theme === 'dark' ? 'bg-gray-700 border-gray-600' : 'bg-gray-100 border-gray-300'}"
      />
      <span class="text-sm {$theme === 'dark' ? 'text-gray-300' : 'text-gray-700'}">Mostrar todos los periodos</span>
    </label>

    
  </div>

  <!-- === MENSAJE DE ERROR === -->
  {#if $error}
    <div class="bg-rose-800 border border-rose-700 text-white px-4 py-3 rounded-lg relative" role="alert">
      <strong class="font-bold">Error:</strong>
      <span class="block sm:inline">{$error}</span>
    </div>
  {/if}

  <!-- === TABLA DE ESTUDIANTES === -->
  {#if $parsed && !$loading}
    <div class="rounded-lg shadow-lg overflow-hidden flex-grow {$theme === 'dark' ? 'bg-gray-800' : 'bg-gray-100'}">
      <div class="overflow-x-auto overflow-y-auto max-h-[70vh]">
        <table class="min-w-full text-sm text-left {$theme === 'dark' ? 'text-gray-300' : 'text-gray-900'}">
          <thead class="text-xs uppercase tracking-wider sticky top-0 z-10 {$theme === 'dark' ? 'bg-gray-700 text-gray-400' : 'bg-gray-200 text-gray-600'}">
            <tr>
              <th scope="col" class="p-2 text-left sticky left-0 z-10 {$theme === 'dark' ? 'bg-gray-700' : 'bg-gray-200'}" rowspan="{$showPeriodos ? 2 : 1}">
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
              {#each $asignaturasOrden as asig}
                {#if asig}
                  <th scope="col" class="p-2 whitespace-nowrap text-center">
                    <span class="block text-xs font-medium">{getAsignaturaName(asig)}</span>
                  </th>
                {/if}
              {/each}
            </tr>
            {#if $showPeriodos}
              <tr class="border-t {$theme === 'dark' ? 'bg-gray-700 border-gray-600' : 'bg-gray-200 border-gray-300'}">
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
          <tbody class="divide-y {$theme === 'dark' ? 'divide-gray-700' : 'divide-gray-300'}">
            {#if filteredEstudiantes.length > 60}
              <tr><td colspan={$asignaturasOrden.length + 1} class="p-0">
                <VirtualRows items={filteredEstudiantes} rowHeight={48} containerHeight={600} let:item let:i>
                  <div class="p-3 border-b flex items-center justify-between {$theme === 'dark' ? 'border-gray-700 bg-gray-800 text-white' : 'border-gray-300 bg-gray-100 text-gray-900'}">
                    <div class="font-medium">{item.nombres}</div>
                    <div class="text-xs {$theme === 'dark' ? 'text-gray-400' : 'text-gray-600'}">{i + 1} / {filteredEstudiantes.length}</div>
                  </div>
                </VirtualRows>
              </td></tr>
            {:else}
              {#each filteredEstudiantes as est (est.nombres)}
                <tr class="transition duration-150 {$theme === 'dark' ? 'hover:bg-gray-700' : 'hover:bg-gray-200'}">
                  <td class="p-4 font-medium sticky left-0 z-10 whitespace-nowrap {$theme === 'dark' ? 'text-white bg-gray-800 hover:bg-gray-700' : 'text-gray-900 bg-gray-100 hover:bg-gray-200'}">{est.nombres}</td>
                  {#each $asignaturasOrden as asig}
                    {#if asig}
                      <td class="p-2 text-center align-middle">
                        {#if !$showPeriodos}
                          <button
                            class="font-bold text-lg {colorNota(valorPeriodo(est, asig, $payload.periodo))} px-2 py-1 rounded-md border-2 {getPeriodBorderColor($payload.periodo)} cursor-pointer"
                            on:click={() => handleValoracionClick(est, asig, $payload.periodo, valorPeriodo(est, asig, $payload.periodo))}
                            title="{est.nombres} - {getAsignaturaName(asig)} - {getShortPeriodName($payload.periodo)}: {valorPeriodo(est, asig, $payload.periodo)}"
                          >
                            {valorPeriodo(est, asig, $payload.periodo)}
                          </button>
                        {:else}
                          <div class="grid gap-1 justify-items-center" style="grid-template-columns: repeat({$selectedPeriodos.length + 1}, minmax(32px, 1fr));">
                            {#each $selectedPeriodos.filter(p => p !== 'DEF') as per}
                              <button
                                class="rounded-md px-1 py-1 text-xs font-bold {colorNota(valorPeriodo(est, asig, per))} border-2 {getPeriodBorderColor(per)} cursor-pointer"
                                on:click={() => handleValoracionClick(est, asig, per, valorPeriodo(est, asig, per))}
                                title="{est.nombres} - {getAsignaturaName(asig)} - {getShortPeriodName(per)}: {valorPeriodo(est, asig, per) || '-'}"
                              >
                                {valorPeriodo(est, asig, per) || '-'}
                              </button>
                            {/each}
                            <button
                              class="rounded-md px-1 py-1 text-xs font-bold {colorNota(valorPeriodo(est, asig, 'DEF'))} border-2 {getPeriodBorderColor('D')} cursor-pointer"
                              on:click={() => handleValoracionClick(est, asig, 'DEF', valorPeriodo(est, asig, 'DEF'))}
                              title="{est.nombres} - {getAsignaturaName(asig)} - Definitiva: {valorPeriodo(est, asig, 'DEF') || '-'}"
                            >
                              {valorPeriodo(est, asig, 'DEF') || '-'}
                            </button>
                          </div>
                        {/if}
                      </td>
                    {/if}
                  {/each}
                </tr>
              {/each}
            {/if}
          </tbody>
        </table>
      </div>
    </div>
  {/if}

  <!-- === SKELETON (cargando) === -->
  {#if $loading && !$parsed}
    {#if $asignaturasOrden && $asignaturasOrden.length}
      {@const cols = $asignaturasOrden.length + 1}
      {@const rest = 70 / Math.max(1, $asignaturasOrden.length)}
      {@const widths = ["30%", ...Array($asignaturasOrden.length).fill(`${rest}%`)]}
      <Skeleton rows={8} columns={cols} headerWidth="30%" columnWidths={widths} theme={$theme} />
    {:else}
      <Skeleton rows={8} columns={5} headerWidth="33%" theme={$theme} />
    {/if}
  {/if}

  <!-- === DIALOGO DE NOTAS DETALLADAS === -->
  <NotasDetalleDialog
    bind:showDialog={showNotasDetalleDialog}
    notasDetalle={currentNotasDetalle}
    loading={notasDetalleLoading}
    error={notasDetalleError}
    year={$payload.year}
    periodo={$payload.periodo}
    estudianteId={selectedEstudianteId}
    asignatura={selectedAsignaturaNombre}
    studentName={selectedStudentName}
  />

  <!-- === INDICADOR DE DEBUG (opcional) === -->
  {#if showNotasDetalleDialog}
    <div style="position: fixed; top: 10px; right: 10px; background-color: green; color: white; padding: 5px; border-radius: 4px; font-size: 12px;">
      Dialog is open
    </div>
  {/if}
</div>