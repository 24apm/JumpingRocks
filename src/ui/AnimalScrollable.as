package ui
{
	import data.ItemData;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import util.Util;

	public class AnimalScrollable extends Scrollable
	{

		private var _itemData:ItemData;
		private var _timer:Timer;
		private var _timeLeft:Number;
		public function get itemData():ItemData
		{
			return _itemData;
		}
		public function AnimalScrollable(element:UIElement, size:Point, itemData:ItemData)
		{
			_itemData = itemData;

			super(element, size, getCurrentStats());
			
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTick);
			_timer.start();
		}
		private function getCurrentStats():String
		{
			var timeLeft:String;
			_timeLeft = Math.round((_itemData.readyIn - Util.getTimeStamp())/1000);
			
			if(_timeLeft > 0)
			{
				
				timeLeft = _timeLeft.toString();
				
			}
			else
			{
				timeLeft = "READY";
				if(_timer)
					_timer.stop();
			}
			return timeLeft;
			
		}
		private function onTick(e:TimerEvent):void
		{
			_label.text = getCurrentStats();
		}
	}
}