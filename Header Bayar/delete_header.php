<?php
include '../koneksi.php'; //menghubungkan ke file koneksi untuk ke database
$no_nota = $_GET['no_nota']; //menampung id

//query hapus
$data = mysqli_query($koneksi, "CALL delete_headerBayar('$no_nota')") or die(mysqli_error($koneksi));

//alert dan redirect ke index.php
echo "<script>alert('Data Berhasil Dihapus.');window.location='header_bayar.php';</script>";
