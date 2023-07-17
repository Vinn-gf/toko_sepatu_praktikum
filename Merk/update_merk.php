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
        <h1>Edit Data Merk</h1>
        <div class="card">
            <div class="card-header bg-success text-white ">
                Edit Data Merk
            </div>
            <div class="card-body">
                <?php
                include('../koneksi.php');

                $id_merk = $_GET['id_merk'];

                //menampilkan tb_siswa berdasarkan id
                $row = mysqli_query($koneksi, "select * from view_merk where id_merk = '$id_merk'");
                $row = mysqli_fetch_assoc($row);

                ?>
                <form action="" method="post" role="form">
                    <div class="form-group">
                        <label>ID Merk</label>
                        <input type="text" name="id_merk" required="" class="form-control" value="<?php echo $row['id_merk']; ?>">
                    </div>
                    <div class="form-group mt-2">
                        <label>Nama Merk</label>
                        <input type="text" name="nama_merk" class="form-control" value="<?php echo $row['nama_merk']; ?>">
                    </div>

                    <div class="form-group mt-2">
                        <label>Model Sepatu</label>
                        <input type="text" name="model_sepatu" class="form-control" value="<?php echo $row['model_sepatu']; ?>">
                    </div>

                    <button type="submit" class="btn btn-success" name="submit" value="simpan" style="margin-top: 20px;">Update Data</button>
                </form>

                <?php

                //jika klik tombol submit maka akan melakukan perubahan
                if (isset($_POST['submit'])) {
                    $id_merk = $_POST['id_merk'];
                    $nama_merk = $_POST['nama_merk'];
                    $model_sepatu = $_POST['model_sepatu'];

                    //query mengubah tb_siswa
                    mysqli_query($koneksi, "CALL update_merk('$id_merk', '$nama_merk', '$model_sepatu')") or die(mysqli_error($koneksi));

                    //redirect ke halaman index.php
                    echo "<script>alert('Data Berhasil Diupdate.');window.location='merk.php';</script>";
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