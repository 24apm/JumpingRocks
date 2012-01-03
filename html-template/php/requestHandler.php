<?php
	session_start();
	print_r("REQUEST: ". $_REQUEST, true);

	if(!isset($_REQUEST["requestType"]))
	{
		echo "Error: no requestType";
		die();
	}
	switch($_REQUEST["requestType"])
	{
		case "getuser":
			include "db/getuser.php";
			break;
		default:
			echo "Error: no requestType";
			break;
	}
?>