package 
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import config.LookupTable;
	
	public class NeighborRequest
	{
		public function NeighborRequest()
		{
			var httprequest:URLRequest = new URLRequest (AppVars.serverUrl + "php/requestHandler.php");
			httprequest.method = URLRequestMethod.POST;
			
			var variables:URLVariables = new URLVariables();
			
			variables.firstName = "FirstName";
			variables.lastName = "LastName";            
			httprequest.data = variables;
			
			var loader:URLLoader = new URLLoader (httprequest);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.load(httprequest);
		}
		
		public function onComplete (event:Event):void{
			LookupTable.neighborsList = new Vector.<NeighborData>;
		}  
	}
	
}