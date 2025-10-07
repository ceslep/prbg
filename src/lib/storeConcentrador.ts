import { fetchConcentrador, defaultConcentradorPayload, type ConcentradorPayload } from './api'
// import { parseConcentradorHTML } from './parseConcentrador' // REMOVE THIS IMPORT
import type { ConcentradorParsed } from './types'

import { writable, get, derived } from "svelte/store"

export const loading = writable(false)
export const error = writable<string | null>(null)
export const rawHTML = writable('') // Keep rawHTML for now, but it won't be set by loadConcentrador
export const parsed = writable<ConcentradorParsed | null>(null)
export const payload = writable<ConcentradorPayload>({ ...defaultConcentradorPayload })
export const search = writable('')
export const showPeriodos = writable(false)
export const selectedPeriodos = writable<string[]>(['UNO','DOS','TRES','CUATRO','DEF'])

export const lastDuration = writable<number | null>(null)

let abortCtrl: AbortController
const cache = new Map<string, ConcentradorParsed>()

export async function loadConcentrador() {
  if (abortCtrl) {
    abortCtrl.abort()
  }
  abortCtrl = new AbortController()
  const key = JSON.stringify(get(payload))
  if (cache.has(key)) {
    parsed.set(cache.get(key)!)
    return
  }
  const t0 = performance.now()
  loading.set(true)
  error.set(null)
  try {
    const data = await fetchConcentrador(get(payload)) // data is now ConcentradorParsed
    // rawHTML.set(data.html) // REMOVED
    parsed.set(data) // Directly set the parsed data
    cache.set(key, data) // Cache the data directly
    // Persistir último payload
    localStorage.setItem('concentrador_payload', JSON.stringify(get(payload)))
  } catch (e: unknown) {
    if ((e as any)?.name === 'AbortError') return
    error.set(e instanceof Error ? e.message : 'Error desconocido')
  } finally {
    lastDuration.set(+(performance.now() - t0).toFixed(0))
    loading.set(false)
  }
}

// Restaurar payload guardado

try {
  const saved = localStorage.getItem('concentrador_payload')
  if (saved) {
    const parsedSaved = JSON.parse(saved)
    payload.set(parsedSaved)
  }
} catch {} // eslint-disable-line no-empty

export function exportCSV() {
  const p = get(parsed)
  if (!p) return
  const sep = ','
  const asign = p.asignaturasOrden.filter(Boolean)
  const header = ['Estudiante', ...asign.map(a => `"${a}"`)].join(sep)
  const lines = p.estudiantes.map(est => {
    const cols = asign.map(a => {
      const asig = est.asignaturas.find(x => x.asignatura === a)
      const def = asig?.periodos.find(p => p.periodo === 'DEF')?.valoracion
      return def != null ? def.toFixed(2) : ''
    })
    return `"${est.nombres.replace(/"/g,'""')}"${sep}${cols.join(sep)}`
  })
  const csv = [header, ...lines].join('\n')
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = 'concentrador.csv'
  a.click()
  URL.revokeObjectURL(url)
}

export const asignaturasOrden = derived(parsed, ($parsed) => $parsed?.asignaturasOrden ?? [])

export function toggleShowPeriodos() { showPeriodos.update(v => !v) }