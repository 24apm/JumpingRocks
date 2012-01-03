package specialObjects
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import config.AssetTranslationTable;

	public class UIBlackSmith extends UILoader
	{
		public static var UPGRADE:String = "upgrade";
		public static var DOWNGRADE:String = "downgrade";
		private var _status:String;
		
		public function UIBlackSmith(status:String)
		{
			_status = status;
			super(AssetTranslationTable.BLACKSMITH);
			
		}
		protected override function loadedHandler(e:Event = null):void
		{
			super.loadedHandler(e);
			
			var mc:MovieClip = (_loader.content as MovieClip);
			mc.gotoAndPlay(_status);
			_loader.content.addEventListener(Event.COMPLETE, onFinish);
		}
		private function onFinish(e:Event):void
		{
			_loader.content.removeEventListener(Event.COMPLETE, onFinish);
			destruct();
		}
	}
}