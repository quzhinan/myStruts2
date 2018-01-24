-- create database
DROP DATABASE IF EXISTS `ienursing`;
CREATE DATABASE `ienursing` default character set utf8;

-- create user
GRANT ALL privileges ON ienursing.* TO ienursing@'%' IDENTIFIED BY 'ienursing';
flush privileges;
