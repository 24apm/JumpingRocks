package javaScriptInterface
{
	import flash.external.ExternalInterface;

	public class JavaScriptInterface
	{
		
		public function JavaScriptInterface()
		{
		}
		public static function getNeighbor():Object
		{
			var obj:Object = ExternalInterface.call("getFriend");
			trace("obj" + obj);
			return obj;
		}
	}
}