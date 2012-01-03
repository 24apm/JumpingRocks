package views
{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	import config.AssetTranslationTable;
	import specialObjects.FireAnimation;

	public class NinjaTimeView extends BasicView
	{
	//	private static const TICKS:int = 3000;
		private var _target:UILoader;
		private var _timer:Timer;
		private var _timerLabel:UILabel;
		
		private var _onStartTimer:Timer;
		
		public function NinjaTimeView()
		{
			super(null, AssetTranslationTable.BG_LAND);
		}
		
		protected override function init(e:Event = null):void
		{
			super.init(e);
			
		
			stage.removeEventListener(MouseEvent.CLICK, GameInit.moveCharacter);
			
			_target = new UILoader(AssetTranslationTable.ROCK);
			_obstacleLayer.addChild(_target);
			_target.x = 200;
			_target.y = 200;
			_target.addEventListener(MouseEvent.CLICK, onBeforeTimer);
			
			_onStartTimer = new Timer(3000);
			_onStartTimer.addEventListener(TimerEvent.TIMER, onBattleStart);
			_onStartTimer.start();
			
			
			_timer = new Timer(1);
			_timer.addEventListener(TimerEvent.TIMER, onTick);
			
			_timerLabel = new UILabel((_timer.currentCount).toString());
			Main.uiLayer.addChild(_timerLabel);
			_timerLabel.x = 400;
				
		}
		
		private function onBattleStart(e:TimerEvent):void
		{
			_target.removeEventListener(MouseEvent.CLICK, onBeforeTimer);
			
			_onStartTimer.removeEventListener(TimerEvent.TIMER, onBattleStart);
			_onStartTimer.stop();
			_onStartTimer = null;
			
			
			var sword:UILoader = new UILoader(AssetTranslationTable.SWORD_BOARD_SWORD);
			_obstacleLayer.addChild(sword);
			_target.addEventListener(MouseEvent.CLICK, onTargetClick);
			
			_timer.start();
		}
		private function onBeforeTimer(e:MouseEvent):void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTick);
			_timer = null;
			
			_onStartTimer.stop();
			_onStartTimer.removeEventListener(TimerEvent.TIMER, onBattleStart);
			_onStartTimer = null;
			
			_target.removeEventListener(MouseEvent.CLICK, onBeforeTimer);
			_timerLabel.text = "YOU LOSE";
			
		}
		private function onTargetClick(e:MouseEvent):void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTick);
			_timer = null;
			TweenLite.to(GameInit.character, 0.5, {x:_target.x, y:_target.y});
			var _fireAnimation:FireAnimation = new FireAnimation(AssetTranslationTable.ANI_FIRE);
			_fireAnimation.x = _target.x;
			_fireAnimation.y = _target.y;
			_obstacleLayer.addChild(_fireAnimation);
			_target.destruct();
			
		}
		private function onTick(e:TimerEvent):void
		{
			_timerLabel.text = ( _timer.currentCount).toString();
		}
	}
}