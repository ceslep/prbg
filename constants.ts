// Archivo de constantes para endpoints de la aplicación IE de Occidente
// Agrega aquí otros endpoints relacionados cuando sea necesario.

export const API_BASE_URL = 'https://app.iedeoccidente.com/consex';
export const GET_CONCENTRADOR_ENDPOINT = `${API_BASE_URL}/getConcentrador2.php`;
export const GET_ASIGNACIONES_ENDPOINT = `${API_BASE_URL}/getasignacion.php`;
export const GET_NOTAS_DETALLADO_ENDPOINT = `${API_BASE_URL}/getNotasDetallado.php`;

// Ejemplo de uso (fetch):
// fetch(GET_CONCENTRADOR_ENDPOINT)
//   .then(r => r.json())
//   .then(data => console.log(data));
