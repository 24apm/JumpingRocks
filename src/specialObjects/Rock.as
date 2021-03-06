package specialObjects
{
	import com.greensock.TweenLite;
	
	import data.DirectionData;
	
	import event.ItemEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import config.AssetTranslationTable;

	public class Rock extends UIDirectionalElement
	{
		

		private var _url:String;
		private var _loader:UILoader;
		private var _lastParentLayer:DisplayObjectContainer;

		public function Rock(url:String = null, direction:DirectionData = null)
		{
			super(direction);
			if(url == null) url = AssetTranslationTable.ROCK;
			_url = url;
		}

		protected override function init(e:Event = null):void
		{
			super.init(e);
			_loader = new UILoader(_url);
			addChild(_loader);
			addEventListener(MouseEvent.ROLL_OVER, rOver);
			addEventListener(MouseEvent.ROLL_OUT, rOut);
		//addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
//			addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
			

		}
		
		private function rOver(e:MouseEvent):void
		{
			this.alpha = 0.8
		}
		private function rOut(e:MouseEvent):void
		{
			this.alpha = 1;
		}



//		private function onStartDrag(e:MouseEvent):void
//		{
//			this.startDrag();
//			_lastParentLayer = this.parent;
//			Main.uiLayer.addChild(this);
//		}
//		private function onStopDrag(e:MouseEvent):void
//		{
//			this.stopDrag();
//			if(_lastParentLayer)
//				_lastParentLayer.addChild(this);
//		}
		public override function destruct():void
		{
			removeEventListener(MouseEvent.ROLL_OVER, rOver);
			removeEventListener(MouseEvent.ROLL_OUT, rOut);
//			removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
//			removeEventListener(MouseEvent.MOUSE_UP, onStopDrag);
			if(_loader)
			{
				_loader.destruct();
				_loader = null;
			}
			super.destruct();
		}
	}
}