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
require_once "datos_conexion.php";

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
    'areas' => [],
    'areasOrden' => []
];

// ----------------------
// 1. Consulta áreas y construye areasOrden
// ----------------------
$sql1 = "
    SELECT 
        pa.abreviatura AS abreviatura,
        pa.area AS nombre,
        IF(pa.orden IS NULL, 200, pa.orden) AS ordenar
    FROM porcentajes_area_colegio pa
    WHERE pa.nivel = ?
      AND pa.year = ?
    GROUP BY pa.area, pa.abreviatura, ordenar
    ORDER BY ordenar
";

$stmt_areas = $mysqli->prepare($sql1);
$stmt_areas->bind_param("is", $nivel, $YEAR);
$stmt_areas->execute();
$rareas = $stmt_areas->get_result();

$array_areas_data = [];
while ($area_row = $rareas->fetch_assoc()) {
    $response['areas'][] = [
        'abreviatura' => $area_row['abreviatura'],
        'nombre' => $area_row['nombre'],
        'docente' => null // Docente for area is not directly available, set to null for now
    ];
    $response['areasOrden'][] = $area_row['abreviatura'];
    $array_areas_data[] = $area_row;
}
$rareas->free();

// ----------------------
// 2. Estudiantes
// ----------------------
$sql2 = "
    SELECT estudiante, nombres, grado 
    FROM estugrupos 
    WHERE nivel = ? AND numero = ? AND asignacion = ? AND year = ?
";

$current_year = date('Y');
if ($activos || $YEAR === $current_year) { // Use $activos from payload
    $sql2 .= " AND activo = 'S'";
}
$sql2 .= " ORDER BY nombres";

$stmt_estudiantes = $mysqli->prepare($sql2);
$stmt_estudiantes->bind_param("ssis", $nivel, $numero, $asignacion, $YEAR);
$stmt_estudiantes->execute();
$restudiantes = $stmt_estudiantes->get_result();

    // Prepare statement for aggregated area grades per period
    $stmt_area_grades = $mysqli->prepare("
        SELECT
            pac.area AS area_abreviatura,
            n.periodo,
            SUM(n.valoracion * (pac.porcentaje / 100)) / SUM(pac.porcentaje / 100) AS valoracion_area_periodo
        FROM notas n
        JOIN porcentajes_area_colegio pac ON n.asignatura = pac.asignatura AND n.year = pac.year AND n.grado = ?
        WHERE n.year = ? AND n.estudiante = ?
        GROUP BY pac.area, n.periodo
    ");

while ($estudiante_row = $restudiantes->fetch_assoc()) {
    $estudianteId = $estudiante_row['estudiante'];
    $nombres = $estudiante_row['nombres'];
    $grado = $estudiante_row['grado'];

    // Fetch aggregated area grades for the current student
    $stmt_area_grades->bind_param("sis", $grado, $YEAR, $estudianteId);
    $stmt_area_grades->execute();
    $result_area_grades = $stmt_area_grades->get_result();

    $area_grades_by_period = [];
    while ($row = $result_area_grades->fetch_assoc()) {
        $area_grades_by_period[$row['area_abreviatura']][$row['periodo']] = (float)$row['valoracion_area_periodo'];
    }

    $areas_list = [];
    foreach ($array_areas_data as $area_data) {
        $area_abreviatura = $area_data['abreviatura'];
        $periodos_valoracion = [];
        $periodos_sum_for_def = [];

        foreach (['UNO', 'DOS', 'TRES', 'CUATRO'] as $p) {
            if (isset($area_grades_by_period[$area_abreviatura][$p])) {
                $final_period_valoracion = $area_grades_by_period[$area_abreviatura][$p];
                $periodos_valoracion[] = [
                    'periodo' => $p,
                    'valoracion' => $final_period_valoracion
                ];
                $periodos_sum_for_def[] = $final_period_valoracion;
            }
        }

        // Calculate DEF (Definitive) for the area
        if (!empty($periodos_sum_for_def)) {
            $def_valoracion = array_sum($periodos_sum_for_def) / count($periodos_sum_for_def);
            $periodos_valoracion[] = [
                'periodo' => 'DEF',
                'valoracion' => $def_valoracion
            ];
        }

        $areas_list[] = [
            'area' => $area_abreviatura,
            'periodos' => $periodos_valoracion,
            'estudianteId' => $estudianteId,
            'docenteId' => null // Docente for area is not directly available
        ];
    }

    $response['estudiantes'][] = [
        'id' => $estudianteId,
        'nombres' => $nombres,
        'areas' => $areas_list
    ];
}
$stmt_estudiantes->close();
$stmt_area_grades->close();
$restudiantes->free();
$mysqli->close();

echo json_encode($response);
?>