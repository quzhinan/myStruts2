-- create database
DROP DATABASE IF EXISTS `ienursing2`;
CREATE DATABASE `ienursing2` default character set utf8;

-- create user
GRANT ALL privileges ON ienursing2.* TO ienursing2@'%' IDENTIFIED BY 'ienursing2';
flush privileges;
