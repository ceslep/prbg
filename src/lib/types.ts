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
  asignaturas?: Asignatura[];
}

export interface NotasDetalladoPayload {
  estudiante: string;
  nombres: string;
  asignatura: string;
  asignat: string;
  valoracion: string;
  periodo: string;
  year: string;
  asignacion: string;
  nivel: string;
  numero: string;
}

export interface NotaDetalle {
  Valoracion: string;
  Nota: string | null;
  Aspecto: string | null;
  FechaAspecto: string;
  FechaNota: string;
  Porcentaje: string | null;
  Docente: string;
  fechaHora: string;
  periodo: string;
  elDocente: string;
  nnota: string;
}
