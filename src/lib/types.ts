export interface PeriodoValoracion {
  periodo: string
  valoracion: number
}

export interface AsignaturaNota {
  asignatura: string
  periodos: PeriodoValoracion[]
  estudianteId: string
  docenteId?: string
}

export interface EstudianteRow {
  id: string
  nombres: string
  asignaturas: AsignaturaNota[]
}

export interface Asignatura {
  abreviatura: string;
  nombre: string;
  docente: string;
}

export interface ConcentradorParsed {
  estudiantes: EstudianteRow[];
  asignaturasOrden: string[];
  asignaturas: Asignatura[];
}
