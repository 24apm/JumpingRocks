<?php
require 'facebook-php-sdk-dafef11/src/facebook.php';
include_once("config.php");
$facebook = new Facebook(array(
  'appId'  => APP_ID,
  'secret' => APP_SECRET,
));

 //See if there is a user from a cookie
$user = $facebook->getUser();
if(!isset($_SESSION) || $_SESSION['currentUserId'] != $user)
{
	
	$_SESSION['currentUserId'] = $user;
	print_r("SESSION set currentUserId <br/>");
}
else
{
	print_r("SESSION already set currentUserId <br/>");
}

//print_r("outside fbsession get /me <br/>");
//print_r("SESSION: " . $_SESSION . "<br/>");
print_r($user);
if ($user) {
  try {
    // Proceed knowing you have a logged in user who's authenticated.
	print_r("<br /> inside fbsession get /me <br />");
    $user_profile = $facebook->api('/me');
	//$_SESSION['currentUserId'] = $user_profile;
	print_r( $user_profile);
  } catch (FacebookApiException $e) {
   // echo '<pre>'.htmlspecialchars(print_r("FacebookApiError: ".$e, true)).'</pre>';
    $user = null;
  }
}
// Login or logout url will be needed depending on current user state.
$perm = array("scope"=>"email,read_stream,publish_stream");
if ($user) {
  $logoutUrl = $facebook->getLogoutUrl($perm);
} else {
  $loginUrl = $facebook->getLoginUrl($perm);
}
?>

<div xmlns:fb="http://www.facebook.com/2008/fbml">
    <?php if ($user) {

	$neighborsIdsQueryResult = $facebook->api( array(
        'method' => 'fql.query',
        'query' => ' SELECT uid FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())',
    ));
	$neighborIds = array();
	foreach($neighborsIdsQueryResult as $aNeighborId)
	{
		$neighborIds[$aNeighborId[uid]] = $aNeighborId;
	}
	$_SESSION['neighborIds'] = json_encode($neighborIds);
	
	
	$neighborsDataQueryResult = $facebook->api( array(
        'method' => 'fql.query',
        'query' => ' SELECT uid, first_name, last_name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())',
    ));
	$neighborData = array();
	
	foreach($neighborsDataQueryResult as $aNeighborData)
	{
		$neighborData[$aNeighborData[uid]] = $aNeighborData;
	}
	$_SESSION['neighborData'] = json_encode($neighborData );
	
	 ?>
      <a href="<?php echo $logoutUrl; ?>">Logout</a>
    <?php
	} 	
	else 
	{ ?>
      <div>
        Login using OAuth 2.0 handled by the PHP SDK:
        <a href="<?php echo $loginUrl; ?>">Login with Facebook</a>
      </div>
	<?php } ?>
</div>