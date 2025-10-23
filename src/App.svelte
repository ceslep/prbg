<script lang="ts">
  import PayloadForm from './lib/PayloadForm.svelte'
  import { loadConcentrador, loading, error, parsed, showPeriodos, selectedPeriodos, currentOrden, lastDuration, exportCSV, exportExcel, payload, concentradorType } from './lib/storeConcentrador'
  import type { EstudianteRow, NotasDetalladoPayload, NotaDetalle, ConcentradorParsed, ConcentradorAreasParsed, EstudianteRowArea } from './lib/types'
  import { onMount } from 'svelte'
  import { get } from 'svelte/store'
  import NotasDetalleDialog from './lib/NotasDetalleDialog.svelte'
  import Skeleton from './lib/Skeleton.svelte'
  import { theme } from './lib/themeStore'
  import { fetchNotasDetallado, fetchNotasDetalladoAreas } from './lib/api'
  import InfoCantDialog from './lib/InfoCantDialog.svelte'
  import InasistenciasDetallado from './lib/InasistenciasDetallado.svelte' // Import the new component
  import ConcentradorAsignaturasTable from './lib/ConcentradorAsignaturasTable.svelte'
  import ConcentradorAreasTable from './lib/ConcentradorAreasTable.svelte'
  import AppHeader from './lib/AppHeader.svelte'
  let showNotasDetalleDialog = false
  let showInfoCantDialog = false
  let showInasistenciasDetallado = false // New state variable for InasistenciasDetallado
  let currentNotasDetalle: NotaDetalle[] = []
  let notasDetalleLoading = false
  let notasDetalleError: string | null = null
  let selectedStudentName = ''
  let selectedEstudianteId = ''
  let selectedAsignaturaNombre = ''
  let selectedPeriodoForDialog = '' // New variable to store the clicked period for the dialog
  let inasistenciasEstudianteId = ''
  let inasistenciasNombres = ''
  let inasistenciasAsignatura = ''
  let inasistenciasPeriodo = ''
  let showPayloadForm = true // Controla visibilidad del formulario

  function handleShowInasistencias(estudianteId: string, nombres: string, asignatura: string, periodo: string) {
    inasistenciasEstudianteId = estudianteId;
    inasistenciasNombres = nombres;
    inasistenciasAsignatura = asignatura;
    inasistenciasPeriodo = periodo;
    showInasistenciasDetallado = true;
    showInasistenciasDetallado = true;
  }

  onMount(() => {
    // loadConcentrador() will now be called from PayloadForm.svelte after it initializes
  })



  async function handleValoracionClick(est: EstudianteRow | EstudianteRowArea, itemAbrev: string, periodo: string, valoracion: string) {
    if (!valoracion || valoracion === '-') return

    showNotasDetalleDialog = true
    currentNotasDetalle = []
    notasDetalleLoading = true
    notasDetalleError = null

    let selectedItemName = itemAbrev;
    const currentConcentradorType = get(concentradorType);

    if ($parsed) {
      if (currentConcentradorType === 'asignaturas') {
        const p = $parsed as ConcentradorParsed;
        const selectedAsignatura = p.asignaturas?.find(a => a.abreviatura === itemAbrev);
        selectedItemName = selectedAsignatura?.nombre || itemAbrev;
      } else {
        const p = $parsed as ConcentradorAreasParsed;
        const selectedArea = p.areas?.find(a => a.abreviatura === itemAbrev);
        selectedItemName = selectedArea?.nombre || itemAbrev;
      }
    }

    selectedEstudianteId = est.id
    selectedStudentName = est.nombres
    selectedAsignaturaNombre = selectedItemName
    selectedPeriodoForDialog = periodo // Set the clicked period

    console.log('Debug: est.id for Inasistencias', est.id); // Add this line for debugging

    const payloadDetalle: NotasDetalladoPayload = {
      estudiante: est.id,
      nombres: est.nombres,
      asignatura: selectedItemName,
      asignat: itemAbrev,
      valoracion: valoracion,
      periodo: periodo,
      year: $payload.year,
      asignacion: $payload.Asignacion,
      nivel: $payload.nivel,
      numero: $payload.numero,
    }

    try {
      let data: NotaDetalle[];
      if (currentConcentradorType === 'asignaturas') {
        data = await fetchNotasDetallado(payloadDetalle);
      } else {
        data = await fetchNotasDetalladoAreas(payloadDetalle);
      }
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
  <AppHeader bind:showPayloadForm={showPayloadForm} bind:showInfoCantDialog={showInfoCantDialog} />

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
  {#if $concentradorType === 'asignaturas'}
    <ConcentradorAsignaturasTable
      parsed={$parsed as ConcentradorParsed}
      loading={$loading}
      {handleValoracionClick}
      {handleShowInasistencias}
      asignaturasOrden={$currentOrden}
      showPeriodos={$showPeriodos}
      selectedPeriodos={$selectedPeriodos}
      payload={$payload}
    />
  {:else}
    <ConcentradorAreasTable
      parsed={$parsed as ConcentradorAreasParsed}
      loading={$loading}
      {handleValoracionClick}
      {handleShowInasistencias}
      currentOrden={$currentOrden}
      showPeriodos={$showPeriodos}
      selectedPeriodos={$selectedPeriodos}
      payload={$payload}
    />
  {/if}

  <!-- === SKELETON (cargando) === -->
  {#if $loading && !$parsed}
    {#if $currentOrden && $currentOrden.length}
      {@const cols = $currentOrden.length + 1}
      {@const rest = 70 / Math.max(1, $currentOrden.length)}
      {@const widths = ["30%", ...Array($currentOrden.length).fill(`${rest}%`)]}
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
    periodo={selectedPeriodoForDialog}
    estudianteId={selectedEstudianteId}
    asignatura={selectedAsignaturaNombre}
    studentName={selectedStudentName}
    onShowInasistencias={handleShowInasistencias}
  />

  <!-- === INDICADOR DE DEBUG (opcional) === -->
  {#if showNotasDetalleDialog}
    <div style="position: fixed; top: 10px; right: 10px; background-color: green; color: white; padding: 5px; border-radius: 4px; font-size: 12px;">
      Dialog is open
    </div>
  {/if}

  <!-- === DIALOGO DE INFORMACIÓN DE CANTIDADES === -->
  <InfoCantDialog bind:showDialog={showInfoCantDialog} />

  {#if showInasistenciasDetallado}
    <InasistenciasDetallado
      estudianteId={inasistenciasEstudianteId}
      nombres={inasistenciasNombres}
      asignatura={inasistenciasAsignatura}
      periodo={inasistenciasPeriodo}
      bind:showDialog={showInasistenciasDetallado}
    />
  {/if}
</div>