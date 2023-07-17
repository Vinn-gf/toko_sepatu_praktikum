<!DOCTYPE html>
<html>

<head>
    <title>Edit Data</title>
</head>
<!-- Custom fonts for this template -->
<link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<body>
    <div class="container col-md-6 mt-4">
        <h1>Edit Data Detail Bayar</h1>
        <div class="card">
            <div class="card-header bg-success text-white ">
                Edit Data Detail Bayar
            </div>
            <div class="card-body">
                <?php
                include('../koneksi.php');

                $id_detail = $_GET['id_detail'];

                //menampilkan tb_siswa berdasarkan id
                $row = mysqli_query($koneksi, "select * from view_db where id_detail = '$id_detail'");
                $row = mysqli_fetch_assoc($row);

                ?>
                <form action="" method="post" role="form">
                    <div class="form-group">
                        <label>ID Detail Bayar</label>
                        <input type="text" name="id_detail" required="" class="form-control" value="<?php echo $row['id_detail']; ?>">
                    </div>
                    <div class="form-group mt-2">
                        <label>ID Sepatu</label>
                        <input type="text" name="id_sepatu" class="form-control" value="<?php echo $row['id_sepatu']; ?>">
                    </div>

                    <div class="form-group mt-2">
                        <label>Jumlah Beli</label>
                        <input type="number" name="jumlah_beli" class="form-control" value="<?php echo $row['jumlah_beli']; ?>">
                    </div>

                    <button type="submit" class="btn btn-success" name="submit" value="simpan" style="margin-top: 20px;">Update Data</button>
                </form>

                <?php

                //jika klik tombol submit maka akan melakukan perubahan
                if (isset($_POST['submit'])) {
                    $id_detail = $_POST['id_detail'];
                    $id_sepatu = $_POST['id_sepatu'];
                    $jumlah_beli = $_POST['jumlah_beli'];

                    //query mengubah tb_siswa
                    mysqli_query($koneksi, "CALL update_detail('$id_detail', '$id_sepatu', '$jumlah_beli')") or die(mysqli_error($koneksi));

                    //redirect ke halaman index.php
                    echo "<script>alert('Data Berhasil Diupdate.');window.location='detail_bayar.php';</script>";
                }



                ?>
            </div>
        </div>
    </div>
</body>
<script src="../vendor/jquery/jquery.min.js"></script>
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="../js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="../vendor/datatables/jquery.dataTables.min.js"></script>
<script src="../vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="../js/demo/datatables-demo.js"></script>

</html>