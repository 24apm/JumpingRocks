<?php
	include_once("BaseModel.php");
	
	class UserModel extends BaseModel
	{
	
		public function getCurrentUser($param = null)
		{
			if(isset($_SESSION['currentUserId']))
			{
				//print_r("SESSION: currentUserId");
				$_REQUEST["id"] = $_SESSION["currentUserId"];
			}
			else
			{
				echo "bad request in getuser.php: no session";
				die();
			}
			$currentUser = $this->getUser($param);
			if($currentUser == null)
			{

				// not found
				$me = $_SESSION['me'];
				$id 			=	$me['id'];
				$first_name 	= 	$me['first_name'];
				$last_name 		=	$me['last_name'];
				$gender		 	= 	$me['gender'];
				$email		 	= 	$me['email'];

				$currentTime = round(microtime(true)*1000);
				$inventory = array();
				$inventory["chicken"] = array();
				$inventory["chicken_count"] = "0";
				$inventory["egg"] = array();
				$inventory["egg_count"] = "0";
				$inventory = json_encode($inventory);
				
				$query = "INSERT INTO user (id, first_name, last_name, gender, email, score, last_login, login_count, inventory) 
									VALUES ($id, '$first_name', '$last_name', '$gender', '$email',  0, $currentTime, login_count = login_count + 1, '$inventory')";
				$result = mysql_query($query);
				if($result)
				{
					$currentUser = $me;
				}
				else
				{
					$user = null;
				}
			}
			else
			{
				// update last login
				$currentTime = round(microtime(true)*1000);
				$userId 	= $currentUser['id'];

				//$query="UPDATE user SET last_login = FROM_UNIXTIME($currentTime), login_count = login_count + 1 WHERE id=$userId";
				$query="UPDATE user SET last_login = $currentTime, login_count = login_count + 1 WHERE id=$userId";
				
				$result = mysql_query($query);

			}
			return $currentUser;
		}
		public function updateUser($paramArray = null)
		{	
			$result;
			if($paramArray == null && count($paramArray) > 0)
			{
				$keys = array();
				$values = array();
				foreach($paramArray as $key => $value)
				{
					$keys[] = $key;
					$values[] = $value;
				}
				$keys = implode($keys);
				$values = implode($values);
				$query = "INSERT INTO user ($keys) 
										VALUES ($values)";
				$result = mysql_query($query);
			}
			else
			{
				$result = false;
			}
			return $result;
		}
		public function getUser($param = null)
		{
			// set in facebookUser.php

			if(isset($_REQUEST["id"]))
			{	
				//print_r("SESSION: id");
				$id = $_REQUEST["id"];
			}
			else
			{
				//print_r("SESSION: else");
				echo "bad request in getuser.php: " . $id;
				die();
			}
			if($id == "" || $id <= 0)
			{
				echo "bad request in getuser.php: bad id: " . $id;
				die();
			}
			
			if($param == null)
			{
				$query="SELECT id, first_name, last_name, gender, email, score, last_login, login_count, inventory FROM user WHERE id = $id";
			}
			else
			{
				$query="SELECT $param FROM user WHERE id = $id";
			}
				
			$result=mysql_query($query) or die(mysql_error());
			// user doesn't exist yet
			$user;
			
			// found
			if($row = mysql_fetch_array($result))
			{
				$user = $row;
			}
			else
			{
				$user = null;
			}

				
			return $user;
		}
	}
?>