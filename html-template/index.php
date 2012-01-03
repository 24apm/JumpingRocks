<?php
	session_start();
?>

<?php include ("php/config.php"); ?>
<?php include ("php/fbsession.php");?>
<?php include ("php/appVars.php");?>
<?php 
	$MainSwf = "Main.swf";
	if(isset($_REQUEST["debug"]))
	{
		$MainSwf = "MainDebug.swf";
	}
	if(isset($_REQUEST["showfriends"]))
	{
		$showFriends = true;
	}
	else 
	{
		$showFriends = false;
	}
	
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0014)about:internet -->

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en" style="overflow: hidden"> 
    <!-- 
    Smart developers always View Source. 
    
    This application was built using Adobe Flex, an open source framework
    for building rich Internet applications that get delivered via the
    Flash Player or to desktops via Adobe AIR. 
    
    Learn more about Flex at http://flex.org 
    // -->
	
    <head>
        <title></title>
        <meta name="google" value="notranslate" />         
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- Include CSS to eliminate any default margins/padding and set the height of the html element and 
             the body element to 100%, because Firefox, or any Gecko based browser, interprets percentage as 
             the percentage of the height of its parent container, which has to be set explicitly.  Fix for
             Firefox 3.6 focus border issues.  Initially, don't display flashContent div so it won't show 
             if JavaScript disabled.
        -->
        <style type="text/css" media="screen"> 
            html, body  { height:1400px; }
            body { margin:0; padding:0; overflow:auto; text-align:center; 
                   background-color: #FFFFFF; }   
            object:focus { outline:none; }
            #flashContent { display:none; }
        </style>

        <!-- Enable Browser History by replacing useBrowserHistory tokens with two hyphens -->
        <!-- BEGIN Browser History required section -->
        <link rel="stylesheet" type="text/css" href="<? echo SERVER_URL; ?>history/history.css" />
        <link rel="stylesheet" type="text/css" href="<? echo SERVER_URL; ?>css/game.css" />
       
	   <script type="text/javascript" src="<? echo SERVER_URL; ?>history/history.js"></script>
        <!-- END Browser History required section -->  
          
		 <script src="//connect.facebook.net/en_US/all.js"></script>

		
        <script type="text/javascript" src="<? echo SERVER_URL; ?>swfobject.js"></script>
        <script type="text/javascript">
		
		
            // For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. 
            var swfVersionStr = "10.2.0";
            // To use express install, set to playerProductInstall.swf, otherwise the empty string. 
            var xiSwfUrlStr = "playerProductInstall.swf";
            var flashvars = {};
			flashvars.serverUrl = "<? echo SERVER_URL; ?>";
			flashvars.showFriends = "<? echo $showFriends; ?>";
			
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000000";
            params.allowscriptaccess = "sameDomain";
            params.allowfullscreen = "true";
            var attributes = {};
            attributes.id = "Main";
            attributes.name = "Main";
            attributes.align = "middle";
			
			console.log("FLASH PARAMS");
			console.log(flashvars);
            swfobject.embedSWF(
                "<? echo $MainSwf ?>", "flashContent", 
                "760", "630", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
            // JavaScript enabled so display the flashContent div in case it is not replaced with a swf object.
            swfobject.createCSS("#flashContent", "display:block;text-align:left;");
        </script>
    </head>

 		<body style="overflow: hidden">
 		<div id="fb-root"></div>
		        <script type="text/javascript" src="<? echo SERVER_URL; ?>js/facebook.js"></script>
		<script type="text/javascript" src="<? echo SERVER_URL; ?>js/platform.js"></script>
<script>
		console.log("FB.Canvas.setSize");
	FB.Canvas.setSize({ width: 760, height: 1400 });
	</script>
       
 		<script type="text/javascript" src="<? echo SERVER_URL; ?>js/payment.js"></script>
 		<p> <a onclick="placeOrder(); return false;">Buy Stuff</a></p>
        <!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
             JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
             when JavaScript is disabled.
        -->
		
        <div id="flashContent">
            <p>
                To view this page ensure that Adobe Flash Player version 
                10.2.0 or greater is installed. 
            </p>
            <script type="text/javascript"> 
                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
            </script> 
        </div>
        
        <noscript>
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%" id="Main">
                <param name="movie" value="Main.swf" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#000000" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="allowFullScreen" value="true" />
                <!--[if !IE]>-->
                <object type="application/x-shockwave-flash" data="Main.swf" width="760" height="630">
                    <param name="quality" value="high" />
                    <param name="bgcolor" value="#000000" />
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="allowFullScreen" value="true" />
                <!--<![endif]-->
                <!--[if gte IE 6]>-->
                    <p> 
                        Either scripts and active content are not permitted to run or Adobe Flash Player version
                        10.2.0 or greater is not installed.
                    </p>
                <!--<![endif]-->
                    <a href="http://www.adobe.com/go/getflashplayer">
                        <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash Player" />
                    </a>
                <!--[if !IE]>-->
                </object>
                <!--<![endif]-->
            </object>
        </noscript>     
   </body>
</html>
