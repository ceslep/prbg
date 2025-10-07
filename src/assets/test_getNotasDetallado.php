<?php

// Simulate input data
$test_payload = [
    "periodo" => "1",
    "year" => 2023,
    "estudiante" => "12345",
    "asignatura" => "MATH101",
    "asignacion" => "A",
    "nivel" => "1",
    "numero" => "1"
];
$GLOBALS['test_input_data'] = json_encode($test_payload);

// Simulate $_SERVER variables for CORS and request method
$_SERVER['HTTP_ORIGIN'] = "http://localhost:5173";
$_SERVER['REQUEST_METHOD'] = "POST"; // Or GET, depending on how you expect it

// Start output buffering to capture the script's output
ob_start();

// Include the script to be tested
require 'getNotasDetallado.php';

// Get the output and clean the buffer
$output = ob_get_clean();

// Decode the JSON output
$response_data = json_decode($output, true);

// --- Assertions ---

// 1. Check if the output is valid JSON
if (json_last_error() !== JSON_ERROR_NONE) {
    echo "Test Failed: Output is not valid JSON. Error: " . json_last_error_msg() . "\n";
    echo "Output: " . $output . "\n";
    exit(1);
}

// 2. Check if the response is an array (assuming it returns a list of notes)
if (!is_array($response_data)) {
    echo "Test Failed: Response is not an array.\n";
    echo "Output: " . $output . "\n";
    exit(1);
}

// 3. Check if the array is not empty (assuming there should be data for the given payload)
if (empty($response_data)) {
    echo "Test Warning: Response array is empty. This might be expected if no data matches the criteria, but check your test data.\n";
}

// 4. Check for expected keys in the first item (if not empty)
if (!empty($response_data)) {
    $first_item = $response_data[0];
    $expected_keys = ["Valoracion", "Nota", "Aspecto", "FechaAspecto", "FechaNota", "Porcentaje", "Docente", "fechaHora", "periodo", "elDocente", "nnota"];
    foreach ($expected_keys as $key) {
        if (!array_key_exists($key, $first_item)) {
            echo "Test Failed: Expected key '$key' not found in response item.\n";
            echo "First item: " . print_r($first_item, true) . "\n";
            exit(1);
        }
    }
    // Example of checking a specific value (adjust based on your expected data)
    // if ($first_item['Docente'] !== 'Expected Docente Name') {
    //     echo "Test Failed: Docente name mismatch. Expected 'Expected Docente Name', got '" . $first_item['Docente'] . "'.\n";
    //     exit(1);
    // }
}

echo "All basic tests passed for getNotasDetallado.php!\n";

?>