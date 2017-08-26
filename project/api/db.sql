create database msmanager;
use msmanager;
create table usuarios(
  id int not null auto_increment,
  login varchar(30) not null,
  senha varchar(40) not null,
  PRIMARY KEY (id),
  UNIQUE KEY login (login)
);
