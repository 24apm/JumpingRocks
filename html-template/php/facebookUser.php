<?php
require 'facebook-php-sdk-dafef11/src/facebook.php';
include_once("config.php");
class FacebookUser
{
	private $facebook;
	public function __construct()
	{
		print_r("FacebookUser");
		$this->facebook = new Facebook(array(
			'appId'  => APP_ID,
			'secret' => APP_SECRET,
		));

		//See if there is a user from a cookie
		$user = $this->facebook->getUser();
		if(!isset($_SESSION) || $_SESSION['currentUserId'] != $user)
		{
			$_SESSION['currentUserId'] = $user;
			print_r("SESSION set currentUserId <br/>");
		}
		else
		{
			print_r("SESSION already set currentUserId <br/>");
		}

		print_r($user);
		if ($user) {
			$user = $this->getMe();
		}
		// Login or logout url will be needed depending on current user state.
		$perm = array("scope"=>"email,read_stream,publish_stream");
		if ($user) {
			$logoutUrl = $this->facebook->getLogoutUrl($perm);
		} else {
			$loginUrl = $this->facebook->getLoginUrl($perm);
		}
		if ($user) 
		{
			$_SESSION['neighborIdsJSON'] = json_encode($this->getUserIds());
			$_SESSION['neighborDataJSON'] = json_encode($this->getUserData());
		} 	
		else 
		{ 
			echo "Login using OAuth 2.0 handled by the PHP SDK:";
		}
	}
	public function getMe()
	{
		$me;
		if(isset($_SESSION['me']))
		{
			$me = $_SESSION['me'];
		}
		else
		{
			try 
			{
				// Proceed knowing you have a logged in user who's authenticated.
				print_r("<br /> inside fbsession get /me <br />");
				
				$me = $this->facebook->api('/me');
				$_SESSION['me'] = $me;
			} 
			catch (FacebookApiException $e) {
				print_r("FacebookGetMe error: " . $e);
				$me = null;
			}
			
		}
		print_r($me);
		return $me;
	}
	public function getUserData()
	{
		$neighborData = array();

		if(isset($_SESSION['$neighborData']))
		{
			$neighborData = $_SESSION['$neighborData'];
		}
		else
		{
			$neighborsDataQueryResult = $this->facebook->api( array(
			'method' => 'fql.query',
			'query' => ' SELECT uid, first_name, last_name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())',
			));
			
			foreach($neighborsDataQueryResult as $aNeighborData)
			{
				$neighborData[$aNeighborData[uid]] = $aNeighborData;
			}
			$_SESSION['neighborData'] = $neighborData;
		}
		return $neighborData;
	}
	public function getUserIds()
	{
		$neighborIds = array();
		if(isset($_SESSION['$neighborIds']))
		{
			$neighborIds = $_SESSION['neighborIds'];
		}
		else
		{
			$neighborsIdsQueryResult = $this->facebook->api( array(
			'method' => 'fql.query',
			'query' => ' SELECT uid FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())',
			));
			
			foreach($neighborsIdsQueryResult as $aNeighborId)
			{
				$neighborIds[$aNeighborId[uid]] = $aNeighborId;
			}
			$_SESSION['$neighborIds'] = $neighborIds;
		}
		return $neighborIds;
	}
	
}
