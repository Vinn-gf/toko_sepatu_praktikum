<?php
include '../koneksi.php'; //menghubungkan ke file koneksi untuk ke database
$id_detail = $_GET['id_detail']; //menampung id

//query hapus
$data = mysqli_query($koneksi, "CALL delete_detailBayar('$id_detail')") or die(mysqli_error($koneksi));

//alert dan redirect ke index.php
echo "<script>alert('Data Berhasil Dihapus.');window.location='detail_bayar.php';</script>";
