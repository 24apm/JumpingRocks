function publish()
{
	console.log("publish");
	FB.ui({ method: 'feed', 
    message: 'Facebook for Websites is super-cool'});
}

function request(p)
{
	console.log("request");
	console.log(p);
     FB.ui(
	 { method: 'apprequests', 
	to:p,
     message: 'Here is a new Requests dialog...'},
	 
	 requestCallback);
	 
}
function requestCallback(response)
{
	console.log("request");
	console.log(response);
}
