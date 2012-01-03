package specialObjects
{
	import config.UILoaderConfig;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class FireAnimation extends UILoader
	{
		public function FireAnimation(url:String = null, loaderConfig:UILoaderConfig = null)
		{
			super(url, loaderConfig);
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			
		}
		protected override function loadedHandler(e:Event = null):void
		{
			super.loadedHandler(e);
	
			var mc:MovieClip = (_loader.content as MovieClip);
			mc.gotoAndPlay("begin");
			_loader.content.addEventListener(Event.COMPLETE, onFinish);
		}
		private function onFinish(e:Event):void
		{
			_loader.content.removeEventListener(Event.COMPLETE, onFinish);
			destruct();
		}
	}
}