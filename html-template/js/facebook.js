  window.fbAsyncInit = function() {

    FB.init({
      appId      : 249365405125992, // App ID
      channelUrl : '//WWW.YOUR_DOMAIN.COM/channel.html', // Channel File
      status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      oauth      : true, // enable OAuth 2.0
      xfbml      : true  // parse XFBML
    });
	
	 
    // Additional initialization code here
    FB.login(function(response) {
    console.log("LOGIN");
	console.log(response);
   if (response.authResponse) {
     	console.log('Welcome!  Fetching your information.... ');
 		
   } else {
     console.log('User cancelled login or did not fully authorize.');
   }
 }, {scope: 'email'});
		

  };

  // Load the SDK Asynchronously
  
  (function(d){
     var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     d.getElementsByTagName('head')[0].appendChild(js);
   }(document));
   

function platformCallback(token, param)
{
	getElementById("Main").platformCallback(token, param);
}
function getMe()
{
//FB.api('/me', function(response) {
//	console.log("getMe");
console.log(appVars.currentUserId);
return appVars.currentUserId;
//});

}
function getTest()
{
	console.log("TEST");
	return "TEST";
}

function getFriend()
{
		console.log("getFriendss");
		console.log(appVars.neighborIds);
	return appVars.neighborIds;
}
function getFriendsData(token)
{
	console.log("getFriendsData");
	console.log(appVars.neighborsData);
	
	if(appVars.neighborsData.length <= 0)
		return gameInit();
	else
	{
		console.log("platformCallback");
		console.log(appVars.neighborsData);
		platformCallback(token, appVars.neighborsData);
		return appVars.neighborsData;
	}
}
function gameInit()
{
	
		console.log("init neighbor");
		friendCount = appVars.neighborIds.length;
		appVars.neighborsData = [];
	    var friendsData = [];
	    for( i=0; i< friendCount; i++) {
	        FB.api('/'+appVars.neighborIds[i], function(response) 
	        {
	          friendsData.push(response);
			  if(friendsData.length >= friendCount)
			  {
				appVars.neighborsData = friendsData;
				console.log("NOT CACHED getFriendsData");
				console.log(appVars.neighborsData);
				
				  return appVars.neighborsData;
			  }
	        });
	     }
}
function initFriend()
{
	FB.api('/me/friends', function(response) {
	    friendCount = response.data.length;
	    var friendsData = [];
	    for( i=0; i< friendCount; i++) {
	        friendId = response.data[i].id;
	        FB.api('/'+friendId, function(response) 
	        {
	          appVars.neighborData.push(response);
	        });
	     }
	});
}