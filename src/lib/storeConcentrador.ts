import { fetchConcentrador, fetchConcentradorAreas, defaultConcentradorPayload, type ConcentradorPayload } from './api'
import type { ConcentradorParsed, ConcentradorAreasParsed } from './types'

import { writable, get, derived } from "svelte/store"

export const loading = writable(false)
export const error = writable<string | null>(null)
export const rawHTML = writable('')
export const parsed = writable<ConcentradorParsed | ConcentradorAreasParsed | null>(null)
export const payload = writable<ConcentradorPayload>({ ...defaultConcentradorPayload })
export const search = writable('')
export const showPeriodos = writable(false)
export const selectedPeriodos = writable<string[]>(['UNO','DOS','TRES','CUATRO','DEF'])
export const concentradorType = writable<'asignaturas' | 'areas'>('asignaturas') // New store

export const lastDuration = writable<number | null>(null)

let abortCtrl: AbortController
const cache = new Map<string, ConcentradorParsed | ConcentradorAreasParsed>()

export async function loadConcentrador(forceReload: boolean = false) {
  if (abortCtrl) {
    abortCtrl.abort()
  }
  abortCtrl = new AbortController()
  const currentType = get(concentradorType)
  const key = JSON.stringify(get(payload)) + `-${currentType}`
  if (!forceReload && cache.has(key)) {
    parsed.set(cache.get(key)!)
    return
  }
  const t0 = performance.now()
  loading.set(true)
  error.set(null)
  parsed.set(null) // Clear parsed data to show skeleton immediately
  try {
    let data: ConcentradorParsed | ConcentradorAreasParsed
    if (currentType === 'asignaturas') {
      data = await fetchConcentrador(get(payload))
    } else {
      data = await fetchConcentradorAreas(get(payload))
    }
    parsed.set(data)
    cache.set(key, data)
    localStorage.setItem('concentrador_payload', JSON.stringify(get(payload)))
    localStorage.setItem('concentrador_type', currentType)
  } catch (e: unknown) {
    if ((e as any)?.name === 'AbortError') return
    error.set(e instanceof Error ? e.message : 'Error desconocido')
  } finally {
    lastDuration.set(+(performance.now() - t0).toFixed(0))
    loading.set(false)
  }
}

// Restore saved payload and concentrador type
try {
  const savedPayload = localStorage.getItem('concentrador_payload')
  if (savedPayload) {
    const parsedSaved = JSON.parse(savedPayload)
    payload.set(parsedSaved)
  }
  const savedType = localStorage.getItem('concentrador_type')
  if (savedType === 'areas') {
    concentradorType.set('areas')
  }
} catch {} // eslint-disable-line no-empty

export function exportCSV() {
  const p = get(parsed)
  const currentType = get(concentradorType)
  if (!p) return
  const sep = ','

  let headerColumns: string[]
  let dataRows: string[]

  if (currentType === 'asignaturas') {
    const asign = (p as ConcentradorParsed).asignaturasOrden.filter(Boolean)
    headerColumns = ['Estudiante', ...asign.map(a => `"${a}"`) ]
    dataRows = (p as ConcentradorParsed).estudiantes.map(est => {
      const cols = asign.map(a => {
        const asig = est.asignaturas.find(x => x.asignatura === a)
        const def = asig?.periodos.find(p => p.periodo === 'DEF')?.valoracion
        return def != null ? def.toFixed(2) : ''
      })
      return `"${est.nombres.replace(/"/g,'""')}"${sep}${cols.join(sep)}`
    })
  } else { // currentType === 'areas'
    const areas = (p as ConcentradorAreasParsed).areasOrden.filter(Boolean)
    headerColumns = ['Estudiante', ...areas.map(a => `"${a}"`) ]
    dataRows = (p as ConcentradorAreasParsed).estudiantes.map(est => {
      const cols = areas.map(a => {
        const area = est.areas.find(x => x.area === a)
        const def = area?.periodos.find(p => p.periodo === 'DEF')?.valoracion
        return def != null ? def.toFixed(2) : ''
      })
      return `"${est.nombres.replace(/"/g,'""')}"${sep}${cols.join(sep)}`
    })
  }

  const csv = [headerColumns.join(sep), ...dataRows].join('\n')
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = 'concentrador.csv'
  a.click()
  URL.revokeObjectURL(url)
}

export function exportExcel() {
  const p = get(parsed)
  const currentType = get(concentradorType)
  if (!p) return
  const sep = '\t' // Use tab as separator for Excel

  let headerColumns: string[]
  let dataRows: string[]

  if (currentType === 'asignaturas') {
    const asign = (p as ConcentradorParsed).asignaturasOrden.filter(Boolean)
    headerColumns = ['Estudiante', ...asign.map(a => `"${a}"`) ]
    dataRows = (p as ConcentradorParsed).estudiantes.map(est => {
      const cols = asign.map(a => {
        const asig = est.asignaturas.find(x => x.asignatura === a)
        const def = asig?.periodos.find(p => p.periodo === 'DEF')?.valoracion
        return def != null ? def.toFixed(2) : ''
      })
      return `"${est.nombres.replace(/"/g,'""')}"${sep}${cols.join(sep)}`
    })
  } else { // currentType === 'areas'
    const areas = (p as ConcentradorAreasParsed).areasOrden.filter(Boolean)
    headerColumns = ['Estudiante', ...areas.map(a => `"${a}"`) ]
    dataRows = (p as ConcentradorAreasParsed).estudiantes.map(est => {
      const cols = areas.map(a => {
        const area = est.areas.find(x => x.area === a)
        const def = area?.periodos.find(p => p.periodo === 'DEF')?.valoracion
        return def != null ? def.toFixed(2) : ''
      })
      return `"${est.nombres.replace(/"/g,'""')}"${sep}${cols.join(sep)}`
    })
  }

  const csv = [headerColumns.join(sep), ...dataRows].join('\n')
  const blob = new Blob([csv], { type: 'application/vnd.ms-excel;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = 'concentrador.xls'
  a.click()
  URL.revokeObjectURL(url)
}

export const currentOrden = derived([parsed, concentradorType], ([$parsed, $concentradorType]) => {
  if (!$parsed) return []
  if ($concentradorType === 'asignaturas') {
    return ($parsed as ConcentradorParsed).asignaturasOrden ?? []
  } else {
    return ($parsed as ConcentradorAreasParsed).areasOrden ?? []
  }
})

export function toggleShowPeriodos() { showPeriodos.update(v => !v) }