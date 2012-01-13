<?php
	include_once("BaseModel.php");
	
	class UserModel extends BaseModel
	{
	
		public function getCurrentUser()
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
			$this->connectDB();
			$currentUser = $this->_getUser();
			print_r($currentUser);
			if($currentUser == null)
			{

				// not found
				$me = $_SESSION['me'];
				$id 			=	$me['id'];
				$first_name 	= 	$me['first_name'];
				$last_name 		=	$me['last_name'];
				$gender		 	= 	$me['gender'];
				$email		 	= 	$me['email'];
				$currentTime = time();
				
				$query = "INSERT INTO user (id, first_name, last_name, gender, email, score, last_login, login_count) 
									VALUES ($id, '$first_name', '$last_name', '$gender', '$email',  0, FROM_UNIXTIME($currentTime), login_count = login_count + 1)";
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
				$currentTime = time();
				$userId 	= $currentUser['id'];

				$query="UPDATE user SET last_login = FROM_UNIXTIME($currentTime), login_count = login_count + 1 WHERE id=$userId";
				$result = mysql_query($query);

			}
			$this->closeDB();
			return $currentUser;
		}
		public function getUser()
		{
			$this->connectDB();
			$user = _getUser();
			$this->closeDB();
			return $user;
		}
		private function _getUser()
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
			
			$query="SELECT id, score FROM user WHERE id = $id";
			//print_r($query . "<br/>");
			
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