<?php
include '../koneksi.php'; //menghubungkan ke file koneksi untuk ke database
$id_sepatu = $_GET['id_sepatu']; //menampung id

//query hapus
$data = mysqli_query($koneksi, "CALL delete_sepatu('$id_sepatu')") or die(mysqli_error($koneksi));

//alert dan redirect ke index.php
echo "<script>alert('Data Berhasil Dihapus.');window.location='sepatu.php';</script>";
