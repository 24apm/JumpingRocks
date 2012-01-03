package ui 
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import javaScriptInterface.JavaScriptInterface;
	
	public class UIInventory extends UIElement
	{
		private var _gridMap:UIGridMap;
		
		private var _closeBtn:UIElement;
		public function UIInventory()
		{
			super();
			

		}
		protected override function init(e:Event=null):void
		{
			super.init();
			_gridMap = new UIGridMap(new Point(3,5), new Point(200,300));
			addChild(_gridMap);
			
			_closeBtn = new UIElement();
			_closeBtn.graphics.beginFill(0x0);
			_closeBtn.graphics.drawRect(0,0,25,25);
			_closeBtn.graphics.endFill();
			addChild(_closeBtn);
			_closeBtn.x = this.width - _closeBtn.width;
			_closeBtn.addEventListener(MouseEvent.CLICK, onClick);
			
			_gridMap.y = _closeBtn.height;
		}
		private function onClick(e:MouseEvent):void
		{
			_gridMap.visible = !_gridMap.visible;
			JavaScriptInterface.publish();
		}
		public function addItem(item:UIElement):void
		{
			if(_gridMap.hasSpace)
				 _gridMap.addItem(item);
		}
	}
}