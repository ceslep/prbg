<script lang="ts">
    import { payload, showPeriodos, selectedPeriodos } from './storeConcentrador';
    import type { Sede } from './api';
    import { fetchAsignaciones } from './api';
    import { onMount } from 'svelte';

    export let disabled: boolean = false;

    const allPeriods = ['UNO', 'DOS', 'TRES', 'CUATRO', 'DEF'];
    const periodOrder = {'UNO': 1, 'DOS': 2, 'TRES': 3, 'CUATRO': 4, 'DEF': 5};

    let sedes: Sede[] = [];
    let niveles: string[] = [];
    let numeros: string[] = [];

    onMount(async () => {
        try {
            sedes = await fetchAsignaciones();
            if (sedes.length > 0) {
                if (!$payload.Asignacion) {
                    $payload.Asignacion = sedes[0].ind;
                }
                updateNiveles(false);
            }
        } catch (error) {
            console.error(error);
        }
    });

    function updateNiveles(resetNumero = true) {
        const selectedSede = sedes.find(s => s.ind === $payload.Asignacion);
        if (selectedSede) {
            const uniqueNiveles = [...new Set(selectedSede.grados.map(g => g.nivel))];
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
        const selectedSede = sedes.find(s => s.ind === $payload.Asignacion);
        if (selectedSede) { 
            const filteredNumeros = selectedSede.grados
                .filter(g => g.nivel === $payload.nivel)
                .map(g => g.numero);
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
            $selectedPeriodos = $selectedPeriodos.filter(x => x !== p);
        }
        $selectedPeriodos = $selectedPeriodos.sort((a, b) => {
            return periodOrder[a as keyof typeof periodOrder] - periodOrder[b as keyof typeof periodOrder];
        });
    }
</script>

<div class="bg-gray-800 text-white p-6 rounded-lg shadow-lg w-full max-w-full mx-auto">
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-4 items-end">
        <div class="flex flex-col">
            <label for="fld-asignacion" class="mb-1 font-semibold text-gray-400 text-sm">Sede</label>
            <select id="fld-asignacion" class="bg-gray-700 border border-gray-600 rounded-md px-2 py-1 text-sm text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200" bind:value={$payload.Asignacion} on:change={() => updateNiveles()} disabled={disabled}>
                {#each sedes as sede}
                    <option value={sede.ind}>{sede.sede}</option>
                {/each}
            </select>
        </div>

        <div class="flex flex-col">
            <label for="fld-nivel" class="mb-1 font-semibold text-gray-400 text-sm">Nivel</label>
            <select id="fld-nivel" class="bg-gray-700 border border-gray-600 rounded-md px-2 py-1 text-sm text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200" bind:value={$payload.nivel} on:change={() => updateNumeros()} disabled={disabled}>
                {#each niveles as nivel}
                    <option value={nivel}>{nivel}</option>
                {/each}
            </select>
        </div>

        <div class="flex flex-col">
            <label for="fld-numero" class="mb-1 font-semibold text-gray-400 text-sm">Número</label>
            <select id="fld-numero" class="bg-gray-700 border border-gray-600 rounded-md px-2 py-1 text-sm text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200" bind:value={$payload.numero} disabled={disabled}>
                {#each numeros as numero}
                    <option value={numero}>{numero}</option>
                {/each}
            </select>
        </div>

        <div class="flex flex-col">
            <label for="fld-periodo" class="mb-1 font-semibold text-gray-400 text-sm">Periodo</label>
            <select id="fld-periodo" class="bg-gray-700 border border-gray-600 rounded-md px-2 py-1 text-sm text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200" bind:value={$payload.periodo} disabled={disabled}>
                <option value="UNO">UNO</option>
                <option value="DOS">DOS</option>
                <option value="TRES">TRES</option>
                <option value="CUATRO">CUATRO</option>
                <option value="DEF">DEF</option>
            </select>
        </div>

        <div class="flex flex-col">
            <label for="fld-year" class="mb-1 font-semibold text-gray-400 text-sm">Año</label>
            <input id="fld-year" type="number" class="bg-gray-700 border border-gray-600 rounded-md px-2 py-1 text-sm text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200" bind:value={$payload.year} disabled={disabled} />
        </div>

        <div class="flex flex-col">
            <label for="fld-activos" class="mb-1 font-semibold text-gray-400 text-sm">Activos</label>
            <select id="fld-activos" class="bg-gray-700 border border-gray-600 rounded-md px-2 py-1 text-sm text-white focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200" bind:value={$payload.activos} disabled={disabled}>
                <option value={true}>Sí</option>
                <option value={false}>No</option>
            </select>
        </div>



    </div>

    {#if $showPeriodos}
        <div class="mt-6 border-t border-gray-700 pt-6">
            <h3 class="text-lg font-semibold text-white mb-4">Seleccionar Periodos</h3>
            <div class="flex flex-wrap gap-4">
                {#each allPeriods as p (p)}
                    <label class="flex items-center space-x-2 cursor-pointer p-2 rounded-md hover:bg-gray-700 transition duration-200">
                        <input type="checkbox" value={p} checked={$selectedPeriodos.includes(p)} on:change={() => handlePeriodoChange(p)} class="h-5 w-5 bg-gray-600 border-gray-500 rounded text-blue-500 focus:ring-blue-500" />
                        <span class="text-gray-300 font-medium">{p}</span>
                    </label>
                {/each}
            </div>
        </div>
    {/if}
</div>