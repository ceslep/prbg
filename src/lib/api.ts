import { GET_CONCENTRADOR_ENDPOINT, GET_ASIGNACIONES_ENDPOINT } from '../../constants'
import type { ConcentradorParsed } from './types' // Import ConcentradorParsed

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
  year: '2025',
  activos: true
}

export async function fetchAsignaciones(): Promise<Sede[]> {
  const res = await fetch(GET_ASIGNACIONES_ENDPOINT)
  if (!res.ok) {
    throw new Error('Error al obtener asignaciones: ' + res.status)
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