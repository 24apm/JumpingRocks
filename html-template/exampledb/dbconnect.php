<?php 
//http://thecity.sfsu.edu/phpmyadmin/
?>
<?php
$username = "team6";
$password = "csc667";
$hostname = "thecity.sfsu.edu";

//connection to the database
//
//http://www.webcheatsheet.com/php/connect_mysql_database.php
$dbhandle = mysql_connect($hostname, $username, $password)
        or die("Unable to connect to MySQL");
echo "Connected to MySQL<br>";
?>
<?php include "dbselect.php"; ?>
