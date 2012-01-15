<?php
	session_start();
	
	if(!isset($_REQUEST["requestType"]))
	{
		echo "Error: no requestType";
		die();
	}
	
	$queryResult;
	
	include_once("db/BaseModel.php");
	BaseModel::connectDB();
	switch($_REQUEST["requestType"])
	{
		case "getCurrentUser":
			include_once("db/UserModel.php");
			$model = new UserModel();
			$queryResult = $model->getCurrentUser();
			break;
		case "getuser":
			include_once("db/UserModel.php");
			$model = new UserModel();
			$queryResult = $model->getUser();
			break;
		case "updatepoint";
			include_once("db/ActionModel.php");
			$model = new ActionModel();		
			$queryResult = $model->updatePoint();
			break;
		case "addChicken";
			include_once("db/ActionModel.php");
			$model = new ActionModel();		
			$queryResult = $model->addChicken();
			break;	
		case "addEgg";
			include_once("db/ActionModel.php");
			$model = new ActionModel();		
			$queryResult = $model->addEgg();
			break;
		case "hatchEgg";
			include_once("db/ActionModel.php");
			$model = new ActionModel();		
			$queryResult = $model->hatchEgg();
			break;
		case "layEgg";
			include_once("db/ActionModel.php");
			$model = new ActionModel();		
			$queryResult = $model->layEgg();
			break;
		default:
			$queryResult = "Error: no requestType";
			break;
	}
	BaseModel::closeDB();
	echo(json_encode($queryResult));

?>