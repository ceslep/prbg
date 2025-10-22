<?php
const DEBUG_MODE = false;

// Orígenes permitidos
$allowed_origins = [
    "http://localhost:5173",
    "http://localhost:4173",
    "https://app.iedeoccidente.com"
];

// CORS
if (isset($_SERVER['HTTP_ORIGIN']) && in_array(trim($_SERVER['HTTP_ORIGIN']), $allowed_origins)) {
    header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
    header("Access-Control-Allow-Credentials: true");
}

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

header("Content-Type: application/json; charset=utf-8");

require_once("datos_conexion.php");

$mysqli = new mysqli($host, $user, $pass, $database);
if ($mysqli->connect_error) {
    echo json_encode(["error" => "Conexión fallida: " . $mysqli->connect_error]);
    exit();
}
$mysqli->set_charset("utf8");

// Parámetros por defecto en modo DEBUG
if (DEBUG_MODE) {
    $input = [
        "estudiante" => "1058078934",
        "asignatura" => "QUIMIC",
        "periodo"    => "CUATRO",
        "year"       => "2025",
        "Asignacion" => "1",
        "nivel"      => "11",
        "numero"     => "1",
        "activos"    => true
    ];
} else {
    $input = json_decode(file_get_contents("php://input"), true);
}

// Validar campos obligatorios
$required = ['estudiante', 'asignatura', 'periodo', 'year', 'Asignacion', 'nivel', 'numero'];
foreach ($required as $field) {
    if (!isset($input[$field])) {
        echo json_encode(["error" => "Falta el campo: $field"]);
        exit();
    }
}

$estudiante = $input['estudiante'];
$asignatura = $input['asignatura'];
$periodo    = $input['periodo'];
$year       = $input['year'];
$asignacion = $input['Asignacion'];
$nivel      = $input['nivel'];
$numero     = $input['numero'];
$activos    = isset($input['activos']) ? (bool)$input['activos'] : false;

// --- SQL Query Construction ---
$select_fields = "n.estudiante, eg.nombres, n.asignatura, aa.materia as asignat, n.valoracion";
$join_tables = "FROM estugrupos eg
                LEFT JOIN notas n ON eg.estudiante = n.estudiante AND eg.year = n.year
                LEFT JOIN asignacion_asignaturas aa ON n.asignatura = aa.asignatura AND n.year = aa.year
                INNER JOIN orden_asignaturas oa ON aa.asignatura = oa.asignatura";
$where_clauses = [
    "eg.asignacion = ?",
    "aa.nivel = ?",
    "aa.numero = ?",
    "eg.nivel = ?",
    "eg.numero = ?",
    "n.estudiante = ?",
    "n.asignatura = ?",
    "n.year = ?",
    "eg.year = ?",
    "aa.year = ?"
];
$params = [$asignacion, $nivel, $numero, $nivel, $numero, $estudiante, $asignatura, $year, $year, $year];
$types = "ssssssssss"; // Initial types for the fixed parameters

// Conditional clauses based on periodo
if ($periodo !== "CINCO" && $periodo !== "MINIMAS") {
    $where_clauses[] = "(n.periodo = ? OR n.periodo IS NULL)";
    $params[] = $periodo;
    $types .= "s";
} else if ($periodo === "MINIMAS") {
    // Assuming 'CUATRO' is a specific period to exclude for MINIMAS
    $where_clauses[] = "n.periodo != 'CUATRO'";
}

// Conditional clause for activos
if ($year === date('Y') && $activos) {
    $where_clauses[] = "eg.activo = 'S'";
}

$group_by = "";
$order_by = "eg.nombres, oa.orden";

// Adjust select fields and group by for specific periods
if ($periodo === "CINCO") {
    $select_fields = "eg.estudiante, eg.nombres, n.asignatura, aa.materia as asignat, SUM(n.valoracion)/4 as valoracion";
    $group_by = "GROUP BY eg.estudiante, n.asignatura";
} else if ($periodo === "MINIMAS") {
    $select_fields = "eg.estudiante, eg.nombres, n.asignatura, aa.materia as asignat, (12 - SUM(n.valoracion)) as valoracion, eg.nivel, eg.numero";
    $group_by = "GROUP BY eg.estudiante, n.asignatura";
}

$sql = "SELECT " . $select_fields . " " . $join_tables . " WHERE " . implode(" AND ", $where_clauses) . " " . $group_by . " ORDER BY " . $order_by;

// Depuración
if (DEBUG_MODE) {
    $debug_sql = $sql;
    $param_index = 0;
    foreach ($params as $param) {
        // Simple substitution: add quotes for strings, no quotes for numbers
        // This is a basic approach and might need refinement for complex types or edge cases
        if (is_string($param)) {
            $debug_sql = preg_replace('/\?/', "'" . $mysqli->real_escape_string($param) . "'", $debug_sql, 1);
        } else {
            $debug_sql = preg_replace('/\?/', $param, $debug_sql, 1);
        }
        $param_index++;
    }
    error_log("Consulta SQL (con parámetros): " . $debug_sql);
    error_log("Parámetros (JSON): " . json_encode($params));
}

$stmt = $mysqli->prepare($sql);
if (!$stmt) {
    echo json_encode(["error" => "Error en la preparación de la consulta: " . $mysqli->error]);
    exit();
}

// Bind parameters dynamically
$stmt->bind_param($types, ...$params);
$stmt->execute();
$result = $stmt->get_result();

$datos = [];
while ($row = $result->fetch_assoc()) {
    $datos[] = $row;
}

echo json_encode($datos, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);

$stmt->close();
$mysqli->close();
?>