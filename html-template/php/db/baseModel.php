<?php
class BaseModel
{
	public function __construct() 
	{
  
	}
	private function connectDB()
	{
		include_once("dbinfo.inc.php");
		mysql_connect($dbpath,$username,$password);
		@mysql_select_db($database) or die( "Unable to select database");
	}
	private function closeDB()
	{
		mysql_close();
	}
	public function getUser()
	{
		// set in facebookUser.php
		if(isset($_SESSION['currentUserId']))
		{
			//print_r("SESSION: currentUserId");
			$id = $_SESSION["currentUserId"];
		}
		else if(isset($_REQUEST["id"]))
		{	
			//print_r("SESSION: id");
			$id = $_REQUEST["id"];
		}
		else
		{
			//print_r("SESSION: else");
			if(!isset($_SESSION))
			{
				
				echo "bad request in getuser.php: no session";
			}
			else
			{
				echo "bad request in getuser.php: " . $id;
			}
			die();
		}
		if($id == "" || $id <= 0)
		{
			echo "bad request in getuser.php: bad id: " . $id;
			die();
		}
		
		$this->connectDB();
		$query="SELECT id, score FROM user WHERE id = $id";
		//print_r($query . "<br/>");
		
		$result=mysql_query($query) or die(mysql_error());
		// user doesn't exist yet
		$user;
		
		// found
		if($row = mysql_fetch_array($result))
		{
			$user['id'] = $row['id'];
			$user['score'] = $row['score'];
		}
		else
		{
			// not found
			
			$query = "INSERT INTO user VALUES ($id, 0)";
			mysql_query($query);
			$user['id'] = $id;
			$user['score'] = 0;
		}
		$this->closeDB();
		return $user;
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
		
		$this->connectDB();
		
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
			$returnResult = "Error insert"; 
		}
		else
		{
			$returnResult['score'] = $score;
		}

		$this->closeDB();
		return $returnResult;
	}
	
}




?>