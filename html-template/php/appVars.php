<?php 
	//	print_r("<pre>");
	//print_r("query results:");
	//print_r($_SESSION['currentUserId']);
//print_r($_SESSION['neighborIds']);
//print_r($_SESSION['neighborData']);
	//print_r("</pre>");
//print_r($_SESSION['neighborIds']);
?>
<script>
var appVars =
{
	neighborIds		: 	JSON.parse('<?php echo $_SESSION['neighborIds'];?>'),
	neighborsData 	: 	JSON.parse('<?php echo $_SESSION['neighborData'];?>'),
	currentUserId 	: 	"<?php echo $_SESSION['currentUserId'];?>",
	serverUrl		: 	"<?php echo SERVER_URL; ?>"
};
console.log("appVars");
console.log(appVars);
</script>