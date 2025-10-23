// Archivo de constantes para endpoints de la aplicación IE de Occidente
// Agrega aquí otros endpoints relacionados cuando sea necesario.

export const API_BASE_URL = 'https://app.iedeoccidente.com/consex';
export const GET_CONCENTRADOR_ENDPOINT = `${API_BASE_URL}/getConcentrador2.php`;
export const GET_ASIGNACIONES_ENDPOINT = `${API_BASE_URL}/getasignacion.php`;
export const GET_NOTAS_DETALLADO_ENDPOINT = `${API_BASE_URL}/getNotasDetallado.php`;
export const GET_NOTAS_HISTORY_ENDPOINT = `${API_BASE_URL}/getNotasHistory.php`;
export const GET_PERIODOS_ENDPOINT = `${API_BASE_URL}/getPeriodos.php`;
export const GET_YEARS_ENDPOINT = `${API_BASE_URL}/getYearsData.php`;
export const GET_INFOCANT_ENDPOINT = `${API_BASE_URL}/getInfoCant.php`; // New endpoint for InfoCant
export const GET_INASISTENCIAS_DETALLADO_ENDPOINT = `${API_BASE_URL}/inasistenciasDetallado.php`;
export const GET_VALORACIONES_ENDPOINT = `${API_BASE_URL}/getValoraciones.php`;
export const GET_CONCENTRADOR_AREAS_ENDPOINT = `${API_BASE_URL}/getConcentradorAreas.php`;
export const GET_NOTAS_DETALLADO_AREAS_ENDPOINT = `${API_BASE_URL}/getNotasDetalladoAreas.php`;

// Ejemplo de uso (fetch):
// fetch(GET_CONCENTRADOR_ENDPOINT)
//   .then(r => r.json())
//   .then(data => console.log(data));
