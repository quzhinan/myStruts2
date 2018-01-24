use mysql;
grant all privileges on *.* to root@127.0.0.1 identified by 'password';
update user set Host='%' where Host='127.0.0.1';
update user set password=password('password') where user='root' and host='%';
delete from user where host<> '%';
flush privileges;
