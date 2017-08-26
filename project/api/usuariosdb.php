<?php
require_once "database.php";
class UsuarioDb extends Database {

  public function create($login, $senha){
  //  $senha = md5($senha);
    $sql = "insert into usuarios (login, senha)".
            " values ('{$login}', '{$senha}');";
    return $this->connection->exec($sql);
  }

   public function readByLoginSenha($login, $senha){
   // $senha = md5($senha);
    $sql = "select * from usuarios WHERE login = '{$login}' and senha = '{$senha}'";
    echo $sql;

    $result = $this->connection->query($sql);

    if($result === false)
      return false;
    else
      return $result->fetch();
  }

}
