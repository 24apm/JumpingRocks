package request
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.net.URLVariables;

	public class HTTPHatchEgg extends HTTPLite
	{
		public static const VIEW:String = "hatchEgg";
		
		public function HTTPHatchEgg(eggId:String)
		{
			super(VIEW);
			var variables:URLVariables = new URLVariables();
			variables.egg = eggId;   
			send(variables);
		}
		
		protected override function onComplete(e:Event):void
		{
			
			var obj:Object = {};
			try
			{
				obj = JSON.decode(e.currentTarget.data);
			}
			catch(e:Error)
			{
				trace("Error: No session or error in parsing");
			}
			super.onComplete(e);
		}
	}
}