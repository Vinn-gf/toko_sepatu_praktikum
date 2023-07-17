<?php
include '../koneksi.php'; //menghubungkan ke file koneksi untuk ke database
$id_merk = $_GET['id_merk']; //menampung id

//query hapus
$data = mysqli_query($koneksi, "CALL delete_merk('$id_merk')") or die(mysqli_error($koneksi));

//alert dan redirect ke index.php
echo "<script>alert('Data Berhasil Dihapus.');window.location='merk.php';</script>";
