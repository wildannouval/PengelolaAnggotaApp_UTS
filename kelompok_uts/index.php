<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
// Koneksi ke database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "kelompok_uts";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Koneksi ke database gagal: " . $conn->connect_error);
}

$method = $_SERVER["REQUEST_METHOD"];

if ($method === "GET") {
    // Mengambil data anggota
    $sql = "SELECT * FROM anggota";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $mahasiswa = array();
        while ($row = $result->fetch_assoc()) {
            $mahasiswa[] = $row;
        }
        echo json_encode($mahasiswa);
    } else {
        echo "Data anggota kosong.";
    }
}

if ($method === "POST") {
    // Menambahkan data anggota
    $data = json_decode(file_get_contents("php://input"), true);
    $nama = $data["nama"];
    $tugas = $data["tugas"];
    $sql = "INSERT INTO anggota (nama, tugas) VALUES ('$nama', '$tugas')";
    if ($conn->query($sql) === TRUE) {
        $data['pesan'] = 'berhasil';
        //echo "Berhasil tambah data";
    } else {
        $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
    }
    echo json_encode($data);
}

if ($method === "PUT") {
    // Memperbarui data anggota
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data["id"];
    $nama = $data["nama"];
    $tugas = $data["tugas"];
    $sql = "UPDATE anggota SET nama='$nama', tugas='$tugas' WHERE id=$id";
    if ($conn->query($sql) === TRUE) {
        $data['pesan'] = 'data berhasil diubah';
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

if ($method === "DELETE") {
    // Menghapus data anggota
    $id = $_GET["id"];
    $sql = "DELETE FROM anggota WHERE id=$id";
    if ($conn->query($sql) === TRUE) {
        $data['pesan'] = 'berhasil';
    } else {
        $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
    }
    echo json_encode($data);
}

$conn->close();
