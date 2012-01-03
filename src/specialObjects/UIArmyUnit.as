package specialObjects
{
	import data.ArmyUnitData;
	
	import flash.events.Event;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class UIArmyUnit extends UIElement
	{
		private var _img:String;
		private var _loader:UILoader;
		
		private var _armyData:ArmyUnitData;
		
		private var _stunnedTimer:Timer;
		
		public function UIArmyUnit(url:String, armyData:ArmyUnitData)
		{
			super();
			_img = url;
			_armyData = armyData;
		}
		protected override function init(e:Event = null):void
		{
			super.init(e);
			_loader = new UILoader(_img);
			addChild(_loader);
			
			_stunnedTimer = new Timer(100, 10);
		}
		public function decrementHp(value:int = 1):void
		{
			if(_armyData.hp > 0)
			{
				_armyData.hp--;
				stunned();
			}
			else
				dispatchEvent(new Event("death", true));
		}
		public override function destruct():void
		{
			if(_loader)
			{
				_loader.destruct();
				_loader = null;
			}
			super.destruct();
		}
		public function stunned():void
		{
			if(!_stunnedTimer.running)
			{
				_stunnedTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onStunComplete);
				_stunnedTimer.addEventListener(TimerEvent.TIMER, onStunTick);
				_stunnedTimer.start();	
			}
		}
		protected function onStunComplete(e:TimerEvent):void
		{
			_stunnedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onStunComplete);
			_stunnedTimer.removeEventListener(TimerEvent.TIMER, onStunTick);
			_stunnedTimer.stop();
			_stunnedTimer.reset();
			
		}
		private function onStunTick(e:TimerEvent):void
		{
			if(this.alpha > 0.9)
				this.alpha = 0.8;
			else
				this.alpha = 1;
		}
	}
}