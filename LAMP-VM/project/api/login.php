<?php
  require_once "usuariosdb.php";

  $login = $_POST['login'];
  $senha = $_POST['senha'];
  $userdb = new UsuarioDB();
  $result = $userdb->readByLoginSenha($login, $senha);

   if($result !== false){
     $_SESSION["user_id"] = $login;
    header("Location: ../home/home.html");
  } else {
    header("Location: ../index.html");
  }

?>
