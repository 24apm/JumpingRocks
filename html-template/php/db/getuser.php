<?php
	
	//print_r("session_id " . session_id() . "<br/>");
	//print_r("SESSION: ". $_SESSION['currentUserId']);
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
	include("dbinfo.inc.php");
	mysql_connect($dbpath,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");
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
		$user = "";
	}
	mysql_close();
	echo json_encode($user);
?>