<?php
//http://thecity.sfsu.edu/phpmyadmin/
?>
<?php include "dbconnect.php"; ?>
<?php
//execute the SQL query and return records
$result = mysql_query("SELECT * FROM Shop");
//fetch tha data from the database
while ($row = mysql_fetch_array($result)) {
   echo "ID:".$row{'Item_ID'}." Name:".$row{'Description'}." $".$row{'Price'}."<br>";
}
?>