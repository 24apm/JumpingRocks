<?php
	include_once("BaseModel.php");
	class ActionModel extends BaseModel
	{
		private $types;
		public function __construct()
		{
			$this->types = array("chicken", "egg");
		}
		public function updatePoint()
		{
			// set in facebookUser.php
			if(isset($_SESSION['currentUserId']))
			{
				$id = $_SESSION["currentUserId"];
			}
			else if(isset($_REQUEST["id"]))
			{	
				$id = $_REQUEST["id"];
			}
			else
			{
				echo "no id";
				die();
			}
			if(isset($_REQUEST['score']))
			{
				$score = $_REQUEST["score"];
				
			}
			else
			{
				echo "no score";
				die();
			}
			
			// grab data.
			$query="SELECT score FROM user WHERE id=$id";
			$selectResult = mysql_query($query);
			$returnResult = array();
			if($row = mysql_fetch_array($selectResult))
			{
				$score = $score + $row['score'];
				
			}
			
			// update score
			$query="UPDATE user SET id='$id', score='$score' WHERE id=$id";
			$insertResult = mysql_query($query);
			if($insertResult === false)
			{
				$returnResult = "Error UPDATE"; 
			}
			else
			{
				$returnResult['score'] = $score;
			}
			return $returnResult;
		}	
		public function hatchEgg()
		{
			$return = $this->_removeInventory("egg"); 
			if($return !== false)
				$result = $this->_addInventory("chicken");
			return $result;
			
		}
		public function layEgg()
		{
			$return = $this->_resetInventory("chicken"); 
			if($return !== false)
				$result = $this->_addInventory("egg");
			return $result;
		}
		
		private function _resetInventory($type)
		{
			// check if type is valid
			
			if(!in_array($type,$this->types))
			{
				print_r("Error: $type is not a valid type");
				echo("-1");
				die();		
			}
			// check if type is valid
			if(!isset($_REQUEST[$type]))
			{
				print_r("Error: $type has no index, not selected");
				echo("-1");
				die();
			}

			// $_REQUEST["egg"] = 12
			$index = $_REQUEST[$type];
			// update inventory
			include_once("UserModel.php");
			$userModel = new UserModel();
			$currentUser = $userModel->getCurrentUser("id,inventory");
			$inventory = json_decode($currentUser['inventory'],true);
			$time = time();	
				
				/*
			print_r("<pre>");
			print_r($_REQUEST);
			print_r($index);
			print_r($_REQUEST[$index]);
			print_r($inventory);
			print_r($time);
			print_r($type);
			print_r($inventory[$type]);
			print_r($_REQUEST[$index]);
			print_r($inventory[$type][$index]);
			print_r("</pre>");
			*/
			if(!(isset($inventory[$type][$index])))
			{
				print_r("Error: $type [$index] doesn't exist");
				echo("-1");
				die();				
			}
			if($time < $inventory[$type][$index]["ready_in"])
			{
				$ready_in = $inventory[$type][$index]["ready_in"] - $time;
				print_r("Error: $type not ready. Still has $ready_in seconds");
				echo("-1");
				die();				
			}
			// if current time pass the stored time

			$inventory[$type][$index]["ready_in"] = time() + 5*60;
			$inventory = json_encode($inventory);
			$userId = $currentUser['id'];
			$query="UPDATE user SET inventory = '$inventory' WHERE id=$userId";
			$result = mysql_query($query);	

			return $result;			
		}
		private function _removeInventory($type)
		{	
			// check if type is valid
			if(!isset($_REQUEST[$type]))
			{
				print_r("Error: $type has no index, not selected");
				echo("-1");
				die();
			}
			$index = $_REQUEST[$type];
			// update inventory
			include_once("UserModel.php");
			$userModel = new UserModel();
			$currentUser = $userModel->getCurrentUser("id,inventory");
			$inventory = json_decode($currentUser['inventory'],true);
			$time = time();	
				
			if(!(isset($inventory[$type][$index])))
			{
				print_r("Error: $type [$index] doesn't exist");
				echo("-1");
				die();				
			}
			if($time < $inventory[$type][$index]["ready_in"])
			{
				$ready_in = $inventory[$type][$index]["ready_in"] - $time;
				print_r("Error: $type not ready. Still has $ready_in seconds");
				echo("-1");
				die();				
			}
			
			// if current time pass the stored time
	
			unset($inventory[$type][$index]);
			$inventory = json_encode($inventory);
			$userId = $currentUser['id'];
			$query="UPDATE user SET inventory = '$inventory' WHERE id=$userId";
			$result = mysql_query($query);	
			return $result;
		}
		
		private function _addInventory($type)
		{
			// check if type is valid
			if(!in_array($type,$this->types))
			{
				print_r("add error: " . $type);
				die();		
			}
			
			// update inventory
			include_once("UserModel.php");
			$userModel = new UserModel();
			$currentUser = $userModel->getCurrentUser("id,inventory");
			
			$inventory = json_decode($currentUser['inventory'],true);
			$time = time();
			$typeKey = $type."_count";
			$inventory[$typeKey] = $inventory[$typeKey] + 1;
			$inventory[$type][$inventory[$typeKey]]["ready_in"] = $time + 5*60;
			$inventory = json_encode($inventory);
			$userId = $currentUser['id'];

			$query="UPDATE user SET inventory = '$inventory' WHERE id=$userId";
			$result = mysql_query($query);	
			return $result;
		}
		public function addChicken()
		{
			$result = $this->_addInventory("chicken");
			return $result;
		}
		public function addEgg()
		{
			$result = $this->_addInventory("egg");
			return $result;
		}
		
	}
?>