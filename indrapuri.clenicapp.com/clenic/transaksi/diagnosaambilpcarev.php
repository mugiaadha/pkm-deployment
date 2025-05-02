<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include '../koneksi.php';

$kdcabang = $_GET['kdcabang'];
$notrans = $_GET['notrans'];

$query = "SELECT kddiagnosa 
          FROM ermcpptdiagnosa 
          WHERE notrans = '$notrans' AND status = 'diagnosa' 
          ORDER BY indexno ASC";

$response = [
    'kddiag1' => null,
    'kddiag2' => null,
    'kddiag3' => null
];

$result = mysqli_query($conn, $query);
$i = 1;
while ($row = mysqli_fetch_assoc($result)) {
    if ($i > 3) break; // maksimal 3 diagnosa
    $response["kddiag$i"] = $row['kddiagnosa'];
    $i++;
}

// Bungkus dengan array agar output seperti: [ { ... } ]
echo json_encode([$response]);

mysqli_close($conn);
?>
