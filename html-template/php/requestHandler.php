<?php
	session_start();
	include_once("db/baseModel.php");
	
	if(!isset($_REQUEST["requestType"]))
	{
		echo "Error: no requestType";
		die();
	}
	$baseModel = new BaseModel();
	$queryResult;
	
	switch($_REQUEST["requestType"])
	{
		case "getuser":
			$queryResult = $baseModel->getUser();
			break;
		case "updatepoint";
			$queryResult = $baseModel->updatePoint();
			break;
		default:
			$queryResult = "Error: no requestType";
			break;
	}

	echo(json_encode($queryResult));

?>