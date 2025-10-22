import { GET_CONCENTRADOR_ENDPOINT, GET_ASIGNACIONES_ENDPOINT, GET_NOTAS_DETALLADO_ENDPOINT, GET_PERIODOS_ENDPOINT, GET_YEARS_ENDPOINT, GET_INASISTENCIAS_DETALLADO_ENDPOINT, GET_VALORACIONES_ENDPOINT } from '../../constants'
import type { ConcentradorParsed, NotasDetalladoPayload, NotaDetalle, Periodo, Year, InasistenciasDetalladoPayload, Inasistencia, ValoracionPayload, Valoracion } from './types' // Import ConcentradorParsed

export interface Sede {
  ind: string;
  sede: string;
  grados: { nivel: string; numero: string }[];
}

export interface ConcentradorPayload {
  Asignacion: string
  nivel: string
  numero: string
  periodo: string
  year: string
  activos: boolean
}

// Update ConcentradorResponse to directly be ConcentradorParsed
export type ConcentradorResponse = ConcentradorParsed;

export const defaultConcentradorPayload: ConcentradorPayload = {
  Asignacion: '1',
  nivel: '11',
  numero: '1',
  periodo: 'CUATRO',
  year: new Date().getFullYear().toString(),
  activos: true
}

export async function fetchAsignaciones(): Promise<Sede[]> {
  const res = await fetch(GET_ASIGNACIONES_ENDPOINT)
  if (!res.ok) {
    throw new Error('Error al obtener asignaciones: ' + res.status)
  }
  return res.json()
}

export async function fetchPeriodos(): Promise<Periodo[]> {
  const res = await fetch(GET_PERIODOS_ENDPOINT)
  if (!res.ok) {
    throw new Error('Error al obtener periodos: ' + res.status)
  }
  return res.json()
}

export async function fetchYears(): Promise<Year[]> {
  const res = await fetch(GET_YEARS_ENDPOINT)
  if (!res.ok) {
    throw new Error('Error al obtener años: ' + res.status)
  }
  return res.json()
}

export async function fetchConcentrador(payload: ConcentradorPayload = defaultConcentradorPayload): Promise<ConcentradorResponse> {
  const res = await fetch(GET_CONCENTRADOR_ENDPOINT, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(payload)
  })
  if (!res.ok) {
    throw new Error('Error al obtener concentrador: ' + res.status)
  }
  return res.json()
}

export async function fetchNotasDetallado(payload: NotasDetalladoPayload): Promise<NotaDetalle[]> {
  const res = await fetch(GET_NOTAS_DETALLADO_ENDPOINT, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(payload)
  })
  if (!res.ok) {
    throw new Error('Error al obtener notas detalladas: ' + res.status)
  }
  return res.json()
}

export async function fetchInasistenciasDetallado(payload: InasistenciasDetalladoPayload): Promise<Inasistencia[]> {
  const res = await fetch(GET_INASISTENCIAS_DETALLADO_ENDPOINT, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(payload)
  })
  if (!res.ok) {
    throw new Error('Error al obtener inasistencias detalladas: ' + res.status)
  }
  return res.json()
}

export async function fetchValoraciones(payload: ValoracionPayload): Promise<Valoracion> {
  const res = await fetch(GET_VALORACIONES_ENDPOINT, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(payload)
  })
  if (!res.ok) {
    throw new Error('Error al obtener valoraciones: ' + res.status)
  }
  return res.json()
}