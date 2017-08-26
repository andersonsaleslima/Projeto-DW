<?php
class Database {
  protected $connection;
  function __construct(){
    try {
      $this->connection = new PDO("mysql:dbname=msmanager;host=localhost", "root", "abc123");
    } catch (PDOException $e) {
      echo 'Connection failed: ' . $e->getMessage();
    }
  }
}
