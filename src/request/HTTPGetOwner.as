package request
{
	import com.adobe.serialization.json.JSON;
	
	import config.LookupTable;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class HTTPGetOwner extends HTTPLite
	{
		public var id:String;
		public var score:uint;
		
		public static const GET_USER:String = "getCurrentUser";
		public function HTTPGetOwner()
		{
			super(GET_USER);
			var variables:URLVariables = new URLVariables();
			variables.id = LookupTable.currentUserId;   
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
			if(obj.hasOwnProperty("id"))
				id = obj["id"];
			
			if(obj.hasOwnProperty("score"))
				score = obj["score"];
			
			
			super.onComplete(e);
		}  
	}
}