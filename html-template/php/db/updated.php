<?
include("dbinfo.inc.php");
mysql_connect(localhost,$username,$password);

$query="UPDATE user SET id='$id', score='$score'";
@mysql_select_db($database) or die( "Unable to select database");
mysql_query($query);
echo "Record Updated";
mysql_close();
?>