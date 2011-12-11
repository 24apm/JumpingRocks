<?
	if(isset($_SESSION['currentUserId']))
	{
		$id = $_REQUEST["currentUserId"];
	}
	else if(isset($_REQUEST["id"]))
	{	
		$id = $_REQUEST["id"];
	}

	include("dbinfo.inc.php");
	mysql_connect($dbpath,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");
	$query="SELECT id, score FROM user WHERE id = $id";
	$result=mysql_query($query);
	// user doesn't exist yet
	$user;
	
	// found
	//print_r("<br />query result2: $result <br />");
	
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