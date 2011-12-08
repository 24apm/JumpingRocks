console.log("FACEBOOK JS LOADED");
  window.fbAsyncInit = function() {
  	console.log("FB.init");
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
   if (response.authResponse) {
     	console.log('Welcome!  Fetching your information.... ');
 		initFriend();
   } else {
     console.log('User cancelled login or did not fully authorize.');
   }
 }, {scope: 'email'});
  };
	console.log("FB.Canvas.setAutoResize");
FB.Canvas.setAutoResize();
  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     d.getElementsByTagName('head')[0].appendChild(js);
   }(document));
   


function getMe()
{
FB.api('/me', function(response) {
console.log(response);
  alert(response.name);
});

}
function getTest()
{
	return "TEST";
}

function getFriend()
{
		console.log("getFriend");
		console.log(appVars.neighborData);
	return appVars.neighborData;
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