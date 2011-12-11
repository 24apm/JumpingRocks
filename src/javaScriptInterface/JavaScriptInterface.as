package javaScriptInterface
{
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	public class JavaScriptInterface
	{
		
		public function JavaScriptInterface()
		{
		}
		public static function getNeighbor():Object
		{
			var obj:Object;

				obj = ExternalInterface.call("getFriendsData");

			trace("obj" + obj);
			return obj;
		}
		public static function publish():void
		{
			ExternalInterface.call("publish");
		}
		public static function request():void
		{
			ExternalInterface.call("request");
		}
	}
}