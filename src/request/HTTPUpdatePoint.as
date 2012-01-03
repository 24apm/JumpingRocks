package request
{
	
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import config.LookupTable;

	public class HTTPUpdatePoint extends HTTPLite
	{
		import com.adobe.serialization.json.JSON;
		public static const UPDATE_POINT:String = "updatepoint.php";
		public function HTTPUpdatePoint(pointsAdded:int)
		{
			super(UPDATE_POINT);
			var variables:URLVariables = new URLVariables();
			variables.id = LookupTable.currentUserId;   
			variables.score = pointsAdded;   
			send(variables);
		}
}
	}