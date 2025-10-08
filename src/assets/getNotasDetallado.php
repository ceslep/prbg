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
    $sql = " SELECT valoracion,nota{$i} as Nota,aspecto{$i} as Aspecto,
        CASE MONTH(fechaa{$i})
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
        DATE_FORMAT(fechaa{$i},'%d') as diaA,
        CASE MONTH(fecha{$i})
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
        DATE_FORMAT(fecha{$i},'%d') as dia,porcentaje{$i} as Porcentaje,periodo,fechahora, {$i} as nnota FROM notas
        WHERE estudiante = ? AND asignatura = ? AND year = ?";
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
        } else {
            $debugSql .= "NULL" . array_shift($parts); // Handle other types as NULL or adjust as needed
        }
    }
    return $debugSql;
}




$stmt = $mysqli->prepare("SELECT identificacion, nombres FROM docentes WHERE identificacion = (SELECT docente FROM asignacion_asignaturas INNER JOIN docentes ON asignacion_asignaturas.docente = docentes.identificacion WHERE asignatura = ? AND nivel = ? AND numero = ? AND docentes.asignacion = ? AND asignacion_asignaturas.year = ?)");
$docente_params = [$datos->asignatura, $datos->nivel, $datos->numero, $datos->asignacion, $datos->year];



$stmt->bind_param("ssiss", ...$docente_params);
$stmt->execute();
$resultDocente = $stmt->get_result();
$docenteData = $resultDocente->fetch_assoc();
$nombres = $docenteData['nombres'];
$idDocente = $docenteData['identificacion'];
$resultDocente->free(); // Explicitly free the result set
$stmt->close();

// Clear any pending results from the connection before preparing the next statement
while ($mysqli->next_result()) {
    // This loop consumes any remaining result sets
    // from previous queries on the connection.
    // We don't need to do anything with the results here, just consume them.
}

$unionSqls = [];
$all_params = [];
$param_types_string = '';

for ($i = 1; $i <= 12; $i++) {
    $sql_part = generateSQL($i);
    $unionSqls[] = $sql_part;

    // Add parameters for each subquery
    $all_params[] = $datos->estudiante;
    $all_params[] = $datos->asignatura;
    $all_params[] = $datos->year;
    $param_types_string .= 'ssi'; // s for estudiante, s for asignatura, i for year

    if (($datos->periodo != "MINIMAS") && ($datos->periodo != "FINAL")) {
        $unionSqls[count($unionSqls) - 1] .= " AND periodo = ?";
        $all_params[] = $datos->periodo;
        $param_types_string .= 's'; // s for periodo
    }
}

$fullSql = implode(" UNION ALL ", $unionSqls) . " ORDER BY fechahora DESC";

if (DEBUG_MODE) {
    echo "Debug SQL (Main Query):\n";
    echo getDebugSQL($fullSql, $all_params) . "\n";
    exit();
}

$stmtNotas = $mysqli->prepare($fullSql);
$stmtNotas->bind_param($param_types_string, ...$all_params);
$stmtNotas->execute(); // ¡Añadida la llamada a execute()!
$result = $stmtNotas->get_result();
$datos = [];
while ($dato = $result->fetch_assoc()) {
    if ($dato["Nota"] != "0.00") {
        $dato["nombres"] = $nombres;
        $dato["idDocente"] = $idDocente;
        $datos[] = array("Valoracion" => $dato["valoracion"], "Nota" => $dato["Nota"], "Aspecto" => $dato["Aspecto"], "FechaAspecto" => $dato["mesA"] . ' ' . $dato["diaA"], "FechaNota" => $dato["mes"] . ' ' . $dato["dia"], "Porcentaje" => $dato["Porcentaje"], "Docente" => $dato['nombres'], "fechaHora" => $dato["fechahora"], "periodo" => $dato["periodo"], "elDocente" => $dato['idDocente'], "nnota" => $dato['nnota']);
    }
}
$stmtNotas->close(); // Cerrar la segunda sentencia
echo json_encode($datos);
$result->free();
$mysqli->close();
