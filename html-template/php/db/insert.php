<?
include("dbinfo.inc.php");
mysql_connect(localhost,$username,$password);
@mysql_select_db($database) or die( "Unable to select database"); 

$query = "INSERT INTO user VALUES ($id, $score)";
mysql_query($query);

mysql_close();
?> 