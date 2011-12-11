function publish()
{
	FB.ui({ method: 'feed', 
    message: 'Facebook for Websites is super-cool'});
}

function request()
{
     FB.ui({ method: 'apprequests', 
     message: 'Here is a new Requests dialog...'});
}
