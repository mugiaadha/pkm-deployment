<?php

header("Access-Control-Allow-Origin: *");
  header('Access-Control-Allow-Headers: Origin,Content-Type');
  include '../koneksi.php';
$nama=$_GET['nama'];

// Query mengambil data
$query = "SELECT kddiagnosa, diagnosa FROM mdiagnosa WHERE kddiagnosa LIKE '%$nama%'";
$result=mysqli_query($conn, $query);

$diagnosa_list = [];
while ($row = mysqli_fetch_array($result,MYSQLI_ASSOC)) {
    $diagnosa_list[] = [
        "kdDiag" => $row["kddiagnosa"],
        "nmDiag" => $row["diagnosa"],
        "nonSpesialis" => true  // Default value, bisa disesuaikan
    ];
}

$response = [
    "metaData" => [
        "code" => "200",
        "message" => "OK"
    ],
    "response" => [
        "count" => count($diagnosa_list),
        "list" => $diagnosa_list
    ]
];

echo json_encode($response);

// Menutup koneksi\mysql_close($conn);
?>
