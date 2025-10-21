<script lang="ts">
  import { payload, showPeriodos, selectedPeriodos, loadConcentrador } from "./storeConcentrador";
  import type { Sede } from "./api";
  import { fetchAsignaciones, fetchPeriodos, fetchYears } from "./api";
  import type { Periodo, Year } from "./types";
  import { onMount } from "svelte";
  import { theme } from "./themeStore";

  export let disabled: boolean = false;

  const allPeriods = ["UNO", "DOS", "TRES", "CUATRO", "DEF"];
  const periodOrder = { UNO: 1, DOS: 2, TRES: 3, CUATRO: 4, DEF: 5 };

  let sedes: Sede[] = [];
  let periods: Periodo[] = [];
  let years: Year[] = [];
  let niveles: string[] = [];
  let numeros: string[] = [];

  // ✅ Derivamos un string para el valor del select de "Activos"
  $: activosString = $payload.activos ? "true" : "false";

  // ✅ Función para actualizar el booleano correctamente
  function setActivos(value: string) {
    $payload.activos = value === "true";
  }

  onMount(async () => {
    const run = async () => {
      try {
        sedes = await fetchAsignaciones();
        if (sedes.length > 0) {
          if (!$payload.Asignacion) {
            $payload.Asignacion = sedes[0].ind;
          }
          updateNiveles(false);
        }

        periods = await fetchPeriodos();
        if (periods.length > 0) {
          const selectedPeriod = periods.find(p => p.selected === "selected");
          if (selectedPeriod) {
            $payload.periodo = selectedPeriod.nombre;
          } else if (!$payload.periodo) {
            $payload.periodo = periods[0].nombre;
          }
        }

        years = await fetchYears();
        if (years.length > 0) {
          const currentYear = new Date().getFullYear().toString();
          const currentYearExists = years.some(y => y.year === currentYear);

          if (currentYearExists) {
            $payload.year = currentYear;
          } else if (!$payload.year) {
            // If current year doesn't exist in fetched data and payload.year is not set,
            // default to the first year from fetched data (assuming it's the latest/most relevant)
            $payload.year = years[0].year;
          }
        } else if (!$payload.year) {
          // If no years are fetched and payload.year is not set, default to current year
          $payload.year = new Date().getFullYear().toString();
        }

        // After all payload values are set, load the concentrador data
        loadConcentrador(false);

      } catch (error) {
        console.error("Error al cargar datos iniciales:", error);
      }
    };

    if ("requestIdleCallback" in window) {
      // @ts-ignore
      window.requestIdleCallback(() => run());
    } else {
      setTimeout(() => run(), 50);
    }
  });

  function updateNiveles(resetNumero = true) {
    const selectedSede = sedes.find((s) => s.ind === $payload.Asignacion);
    if (selectedSede) {
      const uniqueNiveles = [
        ...new Set(selectedSede.grados.map((g: { nivel: string; numero: string }) => g.nivel)),
      ];
      niveles = uniqueNiveles;
      if (niveles.length > 0) {
        if (!$payload.nivel || !niveles.includes($payload.nivel)) {
          $payload.nivel = niveles[0];
        }
        updateNumeros(resetNumero);
      }
    }
  }

  function updateNumeros(resetNumero = true) {
    const selectedSede = sedes.find((s) => s.ind === $payload.Asignacion);
    if (selectedSede) {
      const filteredNumeros = selectedSede.grados
        .filter((g: { nivel: string; numero: string }) => g.nivel === $payload.nivel)
        .map((g: { nivel: string; numero: string }) => g.numero);
      numeros = filteredNumeros;
      if (resetNumero && numeros.length > 0) {
        if (!$payload.numero || !numeros.includes($payload.numero)) {
          $payload.numero = numeros[0];
        }
      }
    }
  }

  function handlePeriodoChange(p: string) {
    if (!$selectedPeriodos.includes(p)) {
      $selectedPeriodos = [...$selectedPeriodos, p];
    } else {
      $selectedPeriodos = $selectedPeriodos.filter((x) => x !== p);
    }
    $selectedPeriodos = $selectedPeriodos.sort((a, b) => {
      return (
        periodOrder[a as keyof typeof periodOrder] -
        periodOrder[b as keyof typeof periodOrder]
      );
    });
  }
</script>

<div
  class="p-6 rounded-lg shadow-lg w-full max-w-full mx-auto {$theme === 'dark'
    ? 'bg-gray-800 text-white'
    : 'bg-white text-gray-900'}"
>
  <div
    class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-4 items-end"
  >
    <!-- Sede -->
    <div class="flex flex-col">
      <label
        for="fld-asignacion"
        class="mb-1 font-semibold text-sm {$theme === 'dark'
          ? 'text-gray-400'
          : 'text-gray-700'}">Sede</label
      >
      <select
        id="fld-asignacion"
        class="rounded-md px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme ===
        'dark'
          ? 'bg-gray-700 border-gray-600 text-white'
          : 'bg-gray-100 border-gray-300 text-gray-900'}"
        bind:value={$payload.Asignacion}
        on:change={() => updateNiveles()}
        {disabled}
      >
        {#each sedes as sede}
          <option value={sede.ind}>{sede.sede}</option>
        {/each}
      </select>
    </div>

    <!-- Nivel -->
    <div class="flex flex-col">
      <label
        for="fld-nivel"
        class="mb-1 font-semibold text-sm {$theme === 'dark'
          ? 'text-gray-400'
          : 'text-gray-700'}">Nivel</label
      >
      <select
        id="fld-nivel"
        class="rounded-md px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme ===
        'dark'
          ? 'bg-gray-700 border-gray-600 text-white'
          : 'bg-gray-100 border-gray-300 text-gray-900'}"
        bind:value={$payload.nivel}
        on:change={() => { updateNumeros(); loadConcentrador(true); }}
        {disabled}
      >
        {#each niveles as nivel}
          <option value={nivel}>{nivel}</option>
        {/each}
      </select>
    </div>

    <!-- Número -->
    <div class="flex flex-col">
      <label
        for="fld-numero"
        class="mb-1 font-semibold text-sm {$theme === 'dark'
          ? 'text-gray-400'
          : 'text-gray-700'}">Número</label
      >
      <select
        id="fld-numero"
        class="rounded-md px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme ===
        'dark'
          ? 'bg-gray-700 border-gray-600 text-white'
          : 'bg-gray-100 border-gray-300 text-gray-900'}"
        bind:value={$payload.numero}
        on:change={() => loadConcentrador(true)}
        {disabled}
      >
        {#each numeros as numero}
          <option value={numero}>{numero}</option>
        {/each}
      </select>
    </div>

    <!-- Periodo -->
    <div class="flex flex-col">
      <label
        for="fld-periodo"
        class="mb-1 font-semibold text-sm {$theme === 'dark'
          ? 'text-gray-400'
          : 'text-gray-700'}">Periodo</label
      >
      <select
        id="fld-periodo"
        class="rounded-md px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme ===
        'dark'
          ? 'bg-gray-700 border-gray-600 text-white'
          : 'bg-gray-100 border-gray-300 text-gray-900'}"
        bind:value={$payload.periodo}
        {disabled}
      >
        {#each periods as period}
          <option value={period.nombre}>{period.nombre}</option>
        {/each}
      </select>
    </div>

    <!-- Año -->
    <div class="flex flex-col">
      <label
        for="fld-year"
        class="mb-1 font-semibold text-sm {$theme === 'dark'
          ? 'text-gray-400'
          : 'text-gray-700'}">Año</label
      >
      <select
        id="fld-year"
        class="rounded-md px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme ===
        'dark'
          ? 'bg-gray-700 border-gray-600 text-white'
          : 'bg-gray-100 border-gray-300 text-gray-900'}"
        bind:value={$payload.year}
        {disabled}
      >
        {#each years as yearOption}
          <option value={yearOption.year}>{yearOption.year}</option>
        {/each}
      </select>
    </div>

    <!-- Activos (CORREGIDO) -->
    <div class="flex flex-col">
      <label
        for="fld-activos"
        class="mb-1 font-semibold text-sm {$theme === 'dark'
          ? 'text-gray-400'
          : 'text-gray-700'}">Activos</label
      >
      <select
        id="fld-activos"
        class="rounded-md px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200 {$theme ===
        'dark'
          ? 'bg-gray-700 border-gray-600 text-white'
          : 'bg-gray-100 border-gray-300 text-gray-900'}"
        value={activosString}
        on:change={(e) => {
          const target = e.target as HTMLSelectElement;
          setActivos(target.value);
        }}
        {disabled}
      >
        <option value="true">Sí</option>
        <option value="false">No</option>
      </select>
    </div>
  </div>

  <!-- Sección de selección de periodos -->
  {#if $showPeriodos}
    <div class="mt-6 border-t border-gray-300 pt-6 dark:border-gray-700">
      <h3 class="text-lg font-semibold text-gray-900 mb-4 dark:text-white">
        Seleccionar Periodos
      </h3>
      <div class="flex flex-wrap gap-4">
        {#each allPeriods as p (p)}
          <label
            class="flex items-center space-x-2 cursor-pointer p-2 rounded-md hover:bg-gray-200 transition duration-200 dark:hover:bg-gray-700"
          >
            <input
              type="checkbox"
              checked={$selectedPeriodos.includes(p)}
              on:change={() => handlePeriodoChange(p)}
              class="h-5 w-5 bg-gray-100 border-gray-300 rounded text-blue-500 focus:ring-blue-500 dark:bg-gray-600 dark:border-gray-500"
            />
            <span class="text-gray-700 font-medium dark:text-gray-300">{p}</span
            >
          </label>
        {/each}
      </div>
    </div>
  {/if}
</div>
