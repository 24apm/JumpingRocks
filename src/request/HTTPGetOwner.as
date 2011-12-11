package request
{
	import com.adobe.serialization.json.JSON;
	
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
		
		public static const GET_USER:String = "getuser.php";
		public function HTTPGetOwner()
		{
			super(GET_USER);
			var variables:URLVariables = new URLVariables();
			variables.id = LookupTable.currentUserId;   
			send(variables);
		}
		protected override function onComplete (e:Event):void{
			//GameInit.addLabel("HTTPGet onComplete " + e.currentTarget.data , new Point(0,120));
			var obj:Object = JSON.decode(e.currentTarget.data);
			if(obj["id"])
				id = obj["id"];
			
			if(obj["score"])
				score = obj["score"];
			
			GameInit.statusBar.setScore(score);
		}  
	}
}