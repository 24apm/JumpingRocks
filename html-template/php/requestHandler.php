<?php
	session_start();
	
	if(!isset($_REQUEST["requestType"]))
	{
		echo "Error: no requestType";
		die();
	}
	
	$queryResult;
	
	switch($_REQUEST["requestType"])
	{
		case "getCurrentUser":
			include_once("db/UserModel.php");
			$userModel = new UserModel();
			$queryResult = $userModel->getCurrentUser();
			break;
		case "getuser":
			include_once("db/UserModel.php");
			$userModel = new UserModel();
			$queryResult = $userModel->getUser();
			break;
		case "updatepoint";
			include_once("db/ActionModel.php");
			$actionModel = new ActionModel();		
			$queryResult = $actionModel->updatePoint();
			break;
		default:
			$queryResult = "Error: no requestType";
			break;
	}

	echo(json_encode($queryResult));

?>