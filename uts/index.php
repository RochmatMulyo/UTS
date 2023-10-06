<?php
include('koneksi.php');
$method = $_SERVER["REQUEST_METHOD"];

if ($method === "GET") {
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
        $sql = "SELECT * FROM pekerjaan WHERE id = $id";
        
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            $pekerjaan = $result->fetch_assoc();
            echo json_encode($pekerjaan);
        } else {
            echo "Data pekerjaan dengan ID $id tidak ditemukan.";
        }
    } 
    else {
        $sql = "SELECT * FROM pekerjaan";
        $result = $conn->query($sql);
        
        if ($result->num_rows > 0) {
            $pekerjaan = array();
            while ($row = $result->fetch_assoc()) {
                $pekerjaan[] = $row;
            }
            echo json_encode($pekerjaan);
        } else {
            echo "Data pekerjaan kosong.";
        }
    }
}


if ($method === "POST") {
    // Menambahkan data mahasiswa
   $data = json_decode(file_get_contents("php://input"), true);
   $pekerjaan = $data["pekerjaan"];
   $status = $data["status"];
   $sql = "INSERT INTO pekerjaan (pekerjaan, status) VALUES ('$pekerjaan', '$status')";
   if ($conn->query($sql) === TRUE) {
   $data['pesan'] = 'berhasil';
   //echo "Berhasil tambah data";
   } else {
   $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
   }
   echo json_encode($data);
   } 

   if ($method === "PUT") {
    // Memperbarui data mahasiswa
        $data = json_decode(file_get_contents("php://input"), true);
        $id = $data["id"];
        $pekerjaan = $data["pekerjaan"];
        $status = $data["status"];
        $sql = "UPDATE pekerjaan SET pekerjaan='$pekerjaan', status='$status' WHERE id=$id";
        if ($conn->query($sql) === TRUE) {
            $data['pesan'] = 'berhasil';
        } else {
         $data['pesan'] =  "Error: " . $sql . "<br>" . $conn->error;
        }
        echo json_encode($data);
   } 

   if ($method === "DELETE") {
    // Menghapus data mahasiswa
   $id = $_GET["id"];
   $sql = "DELETE FROM pekerjaan WHERE id=$id";
   if ($conn->query($sql) === TRUE) {
   $data['pesan'] = 'berhasil';
   } else {
   $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
   }
   echo json_encode($data);
   }
   $conn->close();
?>