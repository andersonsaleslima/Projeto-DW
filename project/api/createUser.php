<?php
  require_once "usuariosdb.php";

  $login = $_POST['login'];
  $senha = $_POST['password'];
  $userdb = new UsuarioDB();
  $result = $userdb->create($login, $senha);

  if($result !== false){
    $_SESSION["user_id"] = $login;
    header("Location: ../home/home.html");
  } else {
    header("Location: ../home/add_admin/add_admin.html");
  }

?>