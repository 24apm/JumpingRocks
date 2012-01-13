<?php
	include_once("BaseModel.php");
	class ActionModel extends BaseModel
	{
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
				$returnResult = "Error UPDATE"; 
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