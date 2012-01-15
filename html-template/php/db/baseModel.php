<?php
class BaseModel
{
	public function __construct() 
	{
  		// set the default timezone to use. Available since PHP 5.1
		date_default_timezone_set('UTC');
		//BaseModel::connectDB();
	}
	public static function connectDB()
	{
		include_once("dbinfo.inc.php");
		mysql_connect($dbpath,$username,$password);
		@mysql_select_db($database) or die( "Unable to select database");
	}
	public static function closeDB()
	{
		mysql_close();
	}
	public function __destruct()
	{
		//BaseModel::closeDB();
	}
}
?>