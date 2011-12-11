<?
	print_r($_REQUEST);
	if(isset($_REQUEST['currentUserId']))
	{
		$id = $_REQUEST["currentUserId"];
	}
	else if(isset($_REQUEST["id"]))
	{	
		$id = $_REQUEST["id"];
	}
	
	if(isset($_REQUEST['score']))
	{
		$score = $_REQUEST["score"];
		
	}
	include("dbinfo.inc.php");
	mysql_connect($dbpath,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");
	
	// grab data.
	$query="SELECT score FROM user WHERE id=$id";
	$result = mysql_query($query);
	if($row = mysql_fetch_array($result))
	{
		$score = $score + $row['score'];
	}
	
	// update score
	$query="UPDATE user SET id='$id', score='$score' WHERE id=$id";
	print_r("<br />".$query."<br />");
	mysql_query($query);

	mysql_close();
	echo json_encode(1);
?>