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
        <h1>Edit Data Sepatu</h1>
        <div class="card">
            <div class="card-header bg-success text-white ">
                Edit Data Sepatu
            </div>
            <div class="card-body">
                <?php
                include('../koneksi.php');

                $no_nota = $_GET['no_nota'];

                //menampilkan tb_siswa berdasarkan id
                $row = mysqli_query($koneksi, "select * from view_hb where no_nota = '$no_nota'");
                $row = mysqli_fetch_assoc($row);

                ?>
                <form action="" method="post" role="form">
                    <div class="form-group">
                        <label>No. Nota</label>
                        <input type="text" name="no_nota" required="" class="form-control" value="<?php echo $row['no_nota']; ?>">
                    </div>

                    <div class="form-group">
                        <input type="hidden" name="tanggal" required="" class="form-control" value="<?php echo $row['tanggal']; ?>">
                    </div>

                    <div class="form-group mt-2">
                        <label>Total Pembelian</label>
                        <input type="number" readonly="" name="total_pembelian" class="form-control" value="<?php echo $row['total_pembelian']; ?>">
                    </div>

                    <div class="form-group mt-2">
                        <label>Bayar</label>
                        <input type="text" name="bayar" class="form-control" value="<?php echo $row['bayar']; ?>">
                    </div>

                    <div class="form-group mt-2">
                        <input type="hidden" name="sisa_bayar" class="form-control" value="<?php echo $row['sisa_bayar']; ?>">
                    </div>

                    <button type="submit" class="btn btn-success" name="submit" value="simpan" style="margin-top: 20px;">Update Data</button>
                </form>

                <?php

                //jika klik tombol submit maka akan melakukan perubahan
                if (isset($_POST['submit'])) {
                    $no_nota = $_POST['no_nota'];
                    $tanggal = $_POST['tanggal'];
                    $total_pembelian = $_POST['total_pembelian'];
                    $bayar = $_POST['bayar'];
                    $sisa_bayar = $bayar - $total_pembelian;

                    if ($bayar < $total_pembelian) {
                        echo "<div class='alert alert-danger mt-3' role='alert'>Jumlah pembayaran tidak mencukupi total pembelian.</div>";
                    } else {
                        mysqli_query($koneksi, "CALL updateHeader('$no_nota', '$total_pembelian', '$bayar', '$sisa_bayar')") or die(mysqli_error($koneksi));

                        echo "<script>alert('Data Berhasil Diupdate.');window.location='header_bayar.php';</script>";
                    }
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