<?php
require_once "../datos_conexion.php";

define('DEBUG_MODE', false); // Set to true to output SQL for debugging, false for normal operation

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


$mysqli = new mysqli($host, $user, $pass, $database);
$input_data = isset($GLOBALS['test_input_data']) ? $GLOBALS['test_input_data'] : file_get_contents("php://input");
$datos = json_decode($input_data);
$mysqli->query("SET NAMES utf8");
$mysqli->set_charset('utf8');

function generateSQL($i)
{
    $sql = " SELECT 
                n.valoracion,
                n.nota{$i} as Nota,
                n.aspecto{$i} as Aspecto,
                CASE MONTH(n.fechaa{$i})
                    WHEN 1 THEN 'Enero'
                    WHEN 2 THEN 'Febrero'
                    WHEN 3 THEN 'Marzo'
                    WHEN 4 THEN 'Abril'
                    WHEN 5 THEN 'Mayo'
                    WHEN 6 THEN 'Junio'
                    WHEN 7 THEN 'Julio'
                    WHEN 8 THEN 'Agosto'
                    WHEN 9 THEN 'Septiembre'
                    WHEN 10 THEN 'Octubre'
                    WHEN 11 THEN 'Noviembre'
                    WHEN 12 THEN 'Diciembre'
                END as mesA,
                DATE_FORMAT(n.fechaa{$i},'%d') as diaA,
                CASE MONTH(n.fecha{$i})
                    WHEN 1 THEN 'Enero'
                    WHEN 2 THEN 'Febrero'
                    WHEN 3 THEN 'Marzo'
                    WHEN 4 THEN 'Abril'
                    WHEN 5 THEN 'Mayo'
                    WHEN 6 THEN 'Junio'
                    WHEN 7 THEN 'Julio'
                    WHEN 8 THEN 'Agosto'
                    WHEN 9 THEN 'Septiembre'
                    WHEN 10 THEN 'Octubre'
                    WHEN 11 THEN 'Noviembre'
                    WHEN 12 THEN 'Diciembre'
                END as mes,
                DATE_FORMAT(n.fecha{$i},'%d') as dia,
                n.porcentaje{$i} as Porcentaje,
                n.periodo,
                n.fechahora,
                {$i} as nnota,
                n.asignatura,
                pac.area as area_name
            FROM notas n
            JOIN porcentajes_area_colegio pac ON n.asignatura = pac.asignatura AND n.year = pac.year AND n.grado = pac.nivel
            WHERE n.estudiante = ? AND pac.area = ? AND n.year = ?";
    return $sql;
}

/**
 * ONLY FOR DEVELOPMENT AND DEBUGGING. DO NOT USE IN PRODUCTION.
 * Interpolates parameters into a prepared SQL statement for debugging.
 * Reintroduces SQL injection vulnerability if used to execute queries.
 */
function getDebugSQL($sql, $params) {
    $parts = explode('?', $sql);
    $debugSql = array_shift($parts);
    foreach ($params as $param) {
        if (is_string($param)) {
            $debugSql .= "'" . addslashes($param) . "'" . array_shift($parts);
        } elseif (is_numeric($param)) {
            $debugSql .= $param . array_shift($parts);
        } else { // Handle other types as NULL or adjust as needed
            $debugSql .= "NULL" . array_shift($parts);
        }
    }
    return $debugSql;
}

// Fetch Docente for the area (simplified: get first docente for any subject in the area)
$stmt_docente = $mysqli->prepare("
    SELECT DISTINCT d.identificacion, d.nombres 
    FROM docentes d
    JOIN asignacion_asignaturas aa ON d.identificacion = aa.docente
    JOIN porcentajes_area_colegio pac ON aa.asignatura = pac.asignatura AND aa.year = pac.year AND aa.nivel = pac.nivel
    WHERE pac.area = ? AND aa.nivel = ? AND aa.numero = ? AND aa.asignacion = ? AND aa.year = ?
    LIMIT 1
");
$docente_params = [$datos->asignat, $datos->nivel, $datos->numero, $datos->asignacion, $datos->year];
$stmt_docente->bind_param("ssiss", ...$docente_params);
$stmt_docente->execute();
$resultDocente = $stmt_docente->get_result();
$docenteData = $resultDocente->fetch_assoc();
$nombres = $docenteData['nombres'] ?? 'N/A';
$idDocente = $docenteData['identificacion'] ?? 'N/A';
$resultDocente->free();
$stmt_docente->close();

// Clear any pending results from the connection before preparing the next statement
while ($mysqli->next_result()) { // This loop consumes any remaining result sets
}

$unionSqls = [];
$all_params = [];
$param_types_string = '';

for ($i = 1; $i <= 12; $i++) {
    $sql_part = generateSQL($i);
    $unionSqls[] = $sql_part;

    // Add parameters for each subquery
    $all_params[] = $datos->estudiante;
    $all_params[] = $datos->asignat; // This is the area abbreviation
    $all_params[] = $datos->year;
    $param_types_string .= 'ssi'; // s for estudiante, s for area, i for year

    if (($datos->periodo != "MINIMAS") && ($datos->periodo != "FINAL")) {
        $unionSqls[count($unionSqls) - 1] .= " AND n.periodo = ?";
        $all_params[] = $datos->periodo;
        $param_types_string .= 's'; // s for periodo
    }
}

$fullSql = implode(" UNION ALL ", $unionSqls) . " ORDER BY n.fechahora DESC";

if (DEBUG_MODE) {
    error_log("Debug SQL (Main Query):\n" . getDebugSQL($fullSql, $all_params));
    exit();
}

$stmtNotas = $mysqli->prepare($fullSql);
if (!$stmtNotas) {
    echo json_encode(["error" => "Error en la preparación de la consulta de notas: " . $mysqli->error]);
    exit();
}

$stmtNotas->bind_param($param_types_string, ...$all_params);
$stmtNotas->execute();
$result = $stmtNotas->get_result();
$detailed_notes = [];
while ($dato = $result->fetch_assoc()) {
    // Only include notes that have a value
    if (isset($dato["Nota"]) && $dato["Nota"] !== null && $dato["Nota"] !== "0.00") {
        $detailed_notes[] = array(
            "Valoracion" => $dato["valoracion"],
            "Nota" => $dato["Nota"],
            "Aspecto" => $dato["Aspecto"],
            "FechaAspecto" => ($dato["mesA"] ?? '') . ' ' . ($dato["diaA"] ?? ''),
            "FechaNota" => ($dato["mes"] ?? '') . ' ' . ($dato["dia"] ?? ''),
            "Porcentaje" => $dato["Porcentaje"],
            "Docente" => $nombres, // Use the fetched docente name
            "fechaHora" => $dato["fechahora"],
            "periodo" => $dato["periodo"],
            "elDocente" => $idDocente, // Use the fetched docente ID
            "nnota" => $dato['nnota'],
            "asignatura" => $dato['asignatura'], // Add asignatura for context
            "area_name" => $dato['area_name'] // Add area name for context
        );
    }
}
$stmtNotas->close();

echo json_encode($detailed_notes);
$result->free();
$mysqli->close();
?>
