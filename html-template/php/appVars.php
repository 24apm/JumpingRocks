<?php 
	print_r("query results:");
print_r($_SESSION['neighborIds']);
print_r($_SESSION['currentUserId']);
//print_r($_SESSION['neighborIds']);
?>
<script>
var appVars =
{
   neighborIds : <?php echo "['".implode("','",$_SESSION['neighborIds'])."']" ;?>,
   neighborsData : [],
   currentUserId : "<?php echo $_SESSION['currentUserId'];?>",
   serverUrl: "<?php echo SERVER_URL; ?>"
};
console.log("appVars");
console.log(appVars);
</script>