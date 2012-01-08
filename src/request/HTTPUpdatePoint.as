package request
{
	
	
	import config.LookupTable;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class HTTPUpdatePoint extends HTTPLite
	{
		import com.adobe.serialization.json.JSON;
		public static const UPDATE_POINT:String = "updatepoint";
		public var score:int;
		
		public function HTTPUpdatePoint(pointsAdded:int)
		{
			super(UPDATE_POINT);
			var variables:URLVariables = new URLVariables();
			variables.id = LookupTable.currentUserId;   
			variables.score = pointsAdded;   
			send(variables);
		}
		protected override function onComplete (e:Event):void{
			//GameInit.addLabel("HTTPGet onComplete " + e.currentTarget.data , new Point(0,120));
			
			var obj:Object = {};
			try
			{
				obj = JSON.decode(e.currentTarget.data);
			}
			catch(e:Error)
			{
				trace("Error in parsing");
			}
			if(obj.hasOwnProperty("score"))
				score = obj["score"];
			super.onComplete(e);
			
		}  
	}
}