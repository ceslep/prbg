<?php
// Orígenes permitidos
$allowed_origins = [
    "http://localhost:5173",
    "http://localhost:4173",
    "https://app.iedeoccidente.com"
];

// Verifica si la cabecera Origin existe y está permitida
if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowed_origins)) {
    header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
    header("Access-Control-Allow-Credentials: true");
}

// Manejo de preflight (OPTIONS) para CORS
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

header('Content-Type: application/json');

// Conexión a BD
require_once "../datos_conexion.php";

$mysqli = new mysqli($host, $user, $pass, $database);
$mysqli->query("SET NAMES utf8");
$mysqli->set_charset('utf8');

// 📥 Datos recibidos
$datos = json_decode(file_get_contents("php://input"));
$nivel      = $datos->nivel ?? null;
$numero     = $datos->numero ?? null;
$periodo    = $datos->periodo ?? null; // This 'periodo' is for the payload, not for filtering grades
$asignacion = $datos->Asignacion ?? null;
$YEAR       = $datos->year ?? null;
$activos    = $datos->activos ?? false;

// Initialize response structure
$response = [
    'estudiantes' => [],
    'asignaturasOrden' => []
];

// ----------------------
// 1. Consulta asignaturas y construye asignaturasOrden
// ----------------------
$sql1 = "
    SELECT 
        asignacion_asignaturas.asignatura, 
        asignacion_asignaturas.abreviatura, 
        asignacion_asignaturas.docente, 
        asignacion_asignaturas.materia, 
        IF(parametros_informe.orden IS NULL, 200, parametros_informe.orden) AS ordenar 
    FROM asignacion_asignaturas
    LEFT JOIN parametros_informe 
        ON asignacion_asignaturas.asignatura = parametros_informe.codigo_materia
    INNER JOIN docentes 
        ON asignacion_asignaturas.docente = docentes.identificacion
    WHERE asignacion_asignaturas.nivel = ? 
      AND asignacion_asignaturas.numero = ? 
      AND asignacion = ? 
      AND asignacion_asignaturas.year = ? 
      AND parametros_informe.year = ?
";

$current_year = date('Y');
if ($YEAR === $current_year) {
    $sql1 .= " AND asignacion_asignaturas.visible = 'S'";
}
$sql1 .= " ORDER BY ordenar";

$stmt_asignaturas = $mysqli->prepare($sql1);
$stmt_asignaturas->bind_param("ssiss", $nivel, $numero, $asignacion, $YEAR, $YEAR);
$stmt_asignaturas->execute();
$rasignaturas = $stmt_asignaturas->get_result();

$array_asignaturas_data = [];
$response['asignaturas'] = [];
while ($asignatura_row = $rasignaturas->fetch_assoc()) {
    $response['asignaturas'][] = [
        'abreviatura' => $asignatura_row['asignatura'],
        'nombre' => $asignatura_row['materia'],
        'docente' => $asignatura_row['docente']
    ];
    $response['asignaturasOrden'][] = $asignatura_row['asignatura'];
    $array_asignaturas_data[] = $asignatura_row;
}
$rasignaturas->free();

// ----------------------
// 2. Estudiantes y sus asignaturas con notas
// ----------------------
$sql2 = "
    SELECT estudiante, nombres 
    FROM estugrupos 
    WHERE nivel = ? AND numero = ? AND asignacion = ? AND year = ?
";

if ($activos || $YEAR === $current_year) { // Use $activos from payload
    $sql2 .= " AND activo = 'S'";
}
$sql2 .= " ORDER BY nombres";

$stmt_estudiantes = $mysqli->prepare($sql2);
$stmt_estudiantes->bind_param("ssis", $nivel, $numero, $asignacion, $YEAR);
$stmt_estudiantes->execute();
$restudiantes = $stmt_estudiantes->get_result();

// Prepare statements for grades and average grades to be used inside the loop
$stmt_grades = $mysqli->prepare("SELECT asignatura, valoracion, periodo FROM notas WHERE year = ? AND estudiante = ?");
$stmt_avg_grades = $mysqli->prepare("SELECT asignatura, AVG(valoracion) as valoracion FROM notas WHERE year = ? AND estudiante = ? GROUP BY asignatura");

while ($estudiante_row = $restudiantes->fetch_assoc()) {
    $estudianteId = $estudiante_row['estudiante'];
    $nombres = $estudiante_row['nombres'];

    // Fetch grades for the current student
    $student_grades = [];
    $stmt_grades->bind_param("ss", $YEAR, $estudianteId);
    $stmt_grades->execute();
    $result_grades = $stmt_grades->get_result();
    while ($row = $result_grades->fetch_assoc()) {
        $student_grades[$row['asignatura']][$row['periodo']] = (float)$row['valoracion'];
    }

    // Fetch average grades for the current student
    $stmt_avg_grades->bind_param("ss", $YEAR, $estudianteId);
    $stmt_avg_grades->execute();
    $result_avg_grades = $stmt_avg_grades->get_result();
    while ($row = $result_avg_grades->fetch_assoc()) {
        $student_grades[$row['asignatura']]['DEF'] = (float)$row['valoracion'];
    }

    $asignaturas_list = [];
    foreach ($array_asignaturas_data as $asignatura_data) {
        $asignatura_name = $asignatura_data['asignatura'];
        $docenteId = $asignatura_data['docente'];

        $periodos_valoracion = [];
        if (isset($student_grades[$asignatura_name])) {
            foreach (['UNO', 'DOS', 'TRES', 'CUATRO', 'DEF'] as $p) {
                if (isset($student_grades[$asignatura_name][$p])) {
                    $periodos_valoracion[] = [
                        'periodo' => $p,
                        'valoracion' => $student_grades[$asignatura_name][$p]
                    ];
                }
            }
        }

        $asignaturas_list[] = [
            'asignatura' => $asignatura_name,
            'periodos' => $periodos_valoracion,
            'estudianteId' => $estudianteId,
            'docenteId' => $docenteId
        ];
    }

    $response['estudiantes'][] = [
        'id' => $estudianteId,
        'nombres' => $nombres,
        'asignaturas' => $asignaturas_list
    ];
}

$stmt_grades->close();
$stmt_avg_grades->close();
$restudiantes->free();
$mysqli->close();

echo json_encode($response);
?>