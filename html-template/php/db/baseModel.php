<?php
class BaseModel
{
	public function __construct() 
	{
  		// set the default timezone to use. Available since PHP 5.1
		date_default_timezone_set('UTC');
	}
	protected function connectDB()
	{
		include_once("dbinfo.inc.php");
		mysql_connect($dbpath,$username,$password);
		@mysql_select_db($database) or die( "Unable to select database");
	}
	protected function closeDB()
	{
		mysql_close();
	}
}
?>