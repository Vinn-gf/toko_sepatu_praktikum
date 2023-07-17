<?php
include "../koneksi.php"
?>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Responsi Basis Data II</title>

    <!-- Custom fonts for this template -->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
                <div class="sidebar-brand-text mx-3">Dashboard</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="../index.php">
                    <i class="fas fa-fw fa-table"></i>
                    <span>Dashboard</span></a>
            </li>

            <!-- Heading -->
            <div class="sidebar-heading">
                Addons
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Table</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="merk.php">Tabel Merk</a>
                        <a class="collapse-item" href="../Sepatu/sepatu.php">Tabel Sepatu</a>
                        <a class="collapse-item" href="../Detail Bayar/detail_bayar.php">Tabel Detail Bayar</a>
                        <a class="collapse-item" href="../Header Bayar/header_bayar.php">Tabel Header Bayar</a>
                    </div>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseView" aria-expanded="true" aria-controls="collapseView">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>View</span>
                </a>
                <div id="collapseView" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="../View/sepatu_puma.php">Sepatu Puma</a>
                        <a class="collapse-item" href="../View/view_PemasukanHarian.php">Pemasukan Harian</a>
                    </div>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAgregasi" aria-expanded="true" aria-controls="collapseAgregasi">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Aggregation</span>
                </a>
                <div id="collapseAgregasi" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="../Aggregation/max_sepatu.php">Sepatu Termahal</a>
                        <a class="collapse-item" href="../Aggregation/min_sepatu.php">Sepatu Termurah</a>
                        <a class="collapse-item" href="../Aggregation/most_sepatu.php">Sepatu Terbanyak Dibeli</a>
                    </div>
            </li>

            <hr class="sidebar-divider d-none d-md-block">


            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

                    <!-- Topbar Search -->
                    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                    </form>

                    <!-- Topbar Navbar -->
                    <form action="">
                        <ul class="navbar-nav ml-auto">
                            <!-- Nav Item - User Information -->
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small">Vinn</span>
                                    <i class="fas fa-regular fa-user"></i>
                                </a>
                            </li>
                        </ul>
                    </form>
                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <!-- Add Merk -->
                <div class="container-fluid">
                    <div class="card shadow mb-4">
                        <div class="card-header bg-primary text-white">
                            Tambah Data Merk
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <form action="" method="post" role="form">
                                    <div class="form-group">
                                        <label>ID Merk</label>
                                        <input type="text" name="id_merk" required="" class="form-control">
                                    </div>
                                    <div class="form-group mt-2">
                                        <label>Nama Merk</label>
                                        <input type="text" name="nama_merk" class="form-control">
                                    </div>


                                    <div class="form-group mt-2">
                                        <label>Model Sepatu</label>
                                        <input type="text" name="model_sepatu" class="form-control">
                                    </div>

                                    <button type="submit" class="btn btn-primary" name="submit" value="simpan" style="margin-top:10px;">Simpan data</button>
                                </form>

                                <?php
                                //melakukan pengecekan jika button submit diklik maka akan menjalankan perintah simpan dibawah ini
                                if (isset($_POST['submit'])) {
                                    //menampung data dari inputan
                                    $id_merk = $_POST['id_merk'];
                                    $nama_merk = $_POST['nama_merk'];
                                    $model_sepatu = $_POST['model_sepatu'];

                                    //query untuk menambahkan barang ke database, pastikan urutan nya sama dengan di database
                                    $datas = mysqli_query($koneksi, "CALL insert_merk('$id_merk', '$nama_merk', '$model_sepatu')") or die(mysqli_error($koneksi));
                                    //id barang tidak dimasukkan, karena sudah menggunakan AUTO_INCREMENT, id akan otomatis

                                    //ini untuk menampilkan alert berhasil dan redirect ke halaman index
                                    echo "<script>alert('Data Berhasil Ditambahkan.');window.location='merk.php';</script>";
                                }
                                ?>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Add -->

                <!-- Tampil Data Tabel Merk -->
                <div class="container-fluid">
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>ID Merk</th>
                                            <th>Nama Merk</th>
                                            <th>Model Sepatu</th>
                                            <th width="100px">Aksi</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <?php
                                        $data_merk = mysqli_query($koneksi, "select * from view_merk");
                                        while ($row = mysqli_fetch_array($data_merk)) {
                                        ?>
                                            <tr>
                                                <td> <?php echo $row['id_merk']; ?></td>
                                                <td> <?php echo $row['nama_merk']; ?></td>
                                                <td> <?php echo $row['model_sepatu']; ?></td>
                                                <td>
                                                    <a href="update_merk.php?id_merk=<?= $row['id_merk']; ?>" class="btn btn-sm btn-success" onclick="return confirm('Anda yakin ingin mengubah data ini?');">Edit</a>
                                                    <a href="delete_merk.php?id_merk=<?= $row['id_merk']; ?>" class="btn btn-sm btn-danger" onclick="return confirm('Anda yakin ingin menghapus data ini?');">Hapus</a>
                                                </td>
                                            </tr>
                                        <?php
                                        }
                                        ?>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; by Vinn</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
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

</body>

</html>