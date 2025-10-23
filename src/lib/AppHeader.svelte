<script lang="ts">
  import { theme } from './themeStore'
  import { loadConcentrador, loading, lastDuration, exportCSV, exportExcel, concentradorType } from './storeConcentrador'

  export let showPayloadForm: boolean
  export let showInfoCantDialog: boolean

  function handleConcentradorTypeChange(event: Event) {
    const target = event.target as HTMLInputElement;
    concentradorType.set(target.checked ? 'areas' : 'asignaturas');
    loadConcentrador(true); // Reload data when concentrador type changes
  }
</script>

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
      on:click={() => (showPayloadForm = !showPayloadForm)}
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

    <!-- Switch para tipo de concentrador -->
    <div class="flex items-center space-x-2">
      <span class="text-sm {$theme === 'dark' ? 'text-gray-300' : 'text-gray-700'}">Asignaturas</span>
      <label class="relative inline-flex items-center cursor-pointer">
        <input type="checkbox" value="" class="sr-only peer" on:change={handleConcentradorTypeChange} checked={$concentradorType === 'areas'}>
        <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600"></div>
        <span class="ml-3 text-sm font-medium {$theme === 'dark' ? 'text-gray-300' : 'text-gray-700'}">Áreas</span>
      </label>
    </div>

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

    <!-- Nuevo Botón para mostrar InfoCantDialog -->
    <button
      on:click={() => (showInfoCantDialog = true)}
      class="p-2 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme === 'dark' ? 'bg-gray-700 text-gray-300 hover:bg-gray-600' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'}"
      aria-label="Mostrar Información de Cantidades"
      title="Información de Cantidades"
    >
      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
      </svg>
    </button>
  </div>

  <!-- Indicador de tiempo de carga -->
  {#if $lastDuration}
    <span class="text-xs {$theme === 'dark' ? 'text-gray-500' : 'text-gray-600'}">Carga en: {$lastDuration}ms</span>
  {/if}
</header>