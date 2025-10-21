export interface PeriodoValoracion {
  periodo: string
  valoracion: number
}

export interface Periodo {
  ind: string;
  nombre: string;
  selected: string;
}

export interface Year {
  year: string;
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


export interface NotaHistory {
    ind: string;
    estudiante: string;
    grado: string;
    asignatura: string;
    docente: string;
    periodo: string;
    valoracion: string;
    nota1: string | null;
    nota2: string | null;
    nota3: string | null;
    nota4: string | null;
    nota5: string | null;
    nota6: string | null;
    nota7: string | null;
    nota8: string | null;
    nota9: string | null;
    nota10: string | null;
    nota11: string | null;
    nota12: string | null;
    porcentaje1: string | null;
    porcentaje2: string | null;
    porcentaje3: string | null;
    porcentaje4: string | null;
    porcentaje5: string | null;
    porcentaje6: string | null;
    porcentaje7: string | null;
    porcentaje8: string | null;
    porcentaje9: string | null;
    porcentaje10: string | null;
    porcentaje11: string | null;
    porcentaje12: string | null;
    aspecto1: string | null;
    aspecto2: string | null;
    aspecto3: string | null;
    aspecto4: string | null;
    aspecto5: string | null;
    aspecto6: string | null;
    aspecto7: string | null;
    aspecto8: string | null;
    aspecto9: string | null;
    aspecto10: string | null;
    aspecto11: string | null;
    aspecto12: string | null;
    fecha1: string | null;
    fecha2: string | null;
    fecha3: string | null;
    fecha4: string | null;
    fecha5: string | null;
    fecha6: string | null;
    fecha7: string | null;
    fecha8: string | null;
    fecha9: string | null;
    fecha10: string | null;
    fecha11: string | null;
    fecha12: string | null;
    anotacion1: string | null;
    anotacion2: string | null;
    anotacion3: string | null;
    anotacion4: string | null;
    anotacion5: string | null;
    anotacion6: string | null;
    anotacion7: string | null;
    anotacion8: string | null;
    anotacion9: string | null;
    anotacion10: string | null;
    anotacion11: string | null;
    anotacion12: string | null;
    fechaa1: string | null;
    fechaa2: string | null;
    fechaa3: string | null;
    fechaa4: string | null;
    fechaa5: string | null;
    fechaa6: string | null;
    fechaa7: string | null;
    fechaa8: string | null;
    fechaa9: string | null;
    fechaa10: string | null;
    fechaa11: string | null;
    fechaa12: string | null;
    fechahora: string;
    year: string;
}

export interface InfoCantData {
  sede: string;
  nivel: number;
  numero: number;
  total_estudiantes: number;
}

export interface InasistenciasDetalladoPayload {
  estudiante: string;
  nombres: string;
  asignatura: string;
  periodo: string;
}

export interface Inasistencia {
  ind: string;
  fecha: string;
  mes: string;
  dia: string;
  horas: string;
  excusa: string;
  hora_clase: string;
  detalle: string;
  fechac: string;
  excusa_causa: string | null;
  excusa_motivo: string | null;
}
