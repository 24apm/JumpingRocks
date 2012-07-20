package request
{
	
	import flash.events.Event;
	import flash.net.URLVariables;

	public class HTTPLayEgg extends HTTPLite
	{
		public static const VIEW:String = "layEgg";
		public function HTTPLayEgg(chickenId:String)
		{
			super(VIEW);
			var variables:URLVariables = new URLVariables();
			variables.chicken = chickenId;   
			send(variables);
		}
		protected override function onComplete(e:Event):void
		{
			
			var obj:Object = {};
			try
			{
				obj = JSON.parse(e.currentTarget.data);
			}
			catch(e:Error)
			{
				trace("Error: No session or error in parsing");
			}
			super.onComplete(e);
		}
	}
}