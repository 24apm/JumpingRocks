package   
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import views.ViewManager;
	

	public class Warp extends UIElement
	{
		private var _ViewClass:Class;
		private var warp:Shape;
		public function Warp(ViewClass:Class)
		{
			super();
			_ViewClass = ViewClass;
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			warp = new Shape();
			addChild(warp);
			warp.graphics.beginFill(0x0);
			warp.graphics.drawRect(0,0,50,50);
			warp.graphics.endFill();
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		public override function destruct():void
		{
			super.destruct();
			if (warp)
			{
				warp.graphics.clear();
				removeChild(warp);
				warp = null;
			}
		}
		private function onClick(e:MouseEvent):void
		{
			ViewManager.loadView(_ViewClass);
		}
	}
}