package views.dodgingRock
{
	import com.greensock.TweenLite;
	
	import data.DirectionData;
	
	import event.ItemEvent;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import javaScriptInterface.JavaScriptInterface;
	
	import org.osmf.events.TimeEvent;
	
	import request.HTTPGetOwner;
	import request.HTTPUpdatePoint;
	
	import specialObjects.UIBlackSmith;
	
	import util.Util;
	
	import views.BasicView;
	import views.SwampView;
	import views.ViewManager;
	import config.AssetTranslationTable;
	import specialObjects.Rock;

	public class DodgingRockView extends BasicView
	{
		private static const MAX_SPEED:int = 3;
		
		private var _enemyDic:Dictionary;
		private var _timer:Timer;
		private var _boxZone:DRSandBoxZone;
		private var _blacksmithAni:UIBlackSmith;
		
		private var _enemyKey:uint = 0;
		public function DodgingRockView()
		{
			super(null, AssetTranslationTable.BG_LAND);
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			
			_enemyDic = new Dictionary();
			
			_boxZone = new DRSandBoxZone();
			addChild(_boxZone);
			_boxZone.width = 300;
			_boxZone.height = 300;
			_boxZone.x = (this.width - _boxZone.width ) * 0.5;
			_boxZone.y = (this.height - _boxZone.height ) * 0.5;
			
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start()
			addEventListener(Event.ENTER_FRAME, onFrame);
			Main.gameLayer.addEventListener(ItemEvent.ITEM_CLICKED, itemClicked);
			
		}
		private function onFrame(e:Event):void
		{
			for (var enemyKey:String in _enemyDic)
			{
				// if rock still moving
				if(_enemyDic[enemyKey].status != UIDirectionalElement.STUNNED)
				{
					_enemyDic[enemyKey].x += _enemyDic[enemyKey].directionalObj.xDirection;
					_enemyDic[enemyKey].y += _enemyDic[enemyKey].directionalObj.yDirection;
					if(_enemyDic[enemyKey].hitTestObject(GameInit.character))
					{
						destroyRock(enemyKey);
						hitHandler();
					}
					else if(_enemyDic[enemyKey].x < 0 || _enemyDic[enemyKey].x > stage.stageWidth || _enemyDic[enemyKey].y < 0 || _enemyDic[enemyKey].y >stage.stageHeight)
					{
						destroyRock(enemyKey);
					}
	
				}
			}
		}
		private function destroyRock(enemyKey:String):void
		{
			_enemyDic[enemyKey].destruct();
			_enemyDic[enemyKey] = null;
			delete(_enemyDic[enemyKey]);
			
		}
		private function itemClicked(e:ItemEvent):void
		{
			if(e.item is Rock)
			{
				var upgradestatus:String = UIBlackSmith.DOWNGRADE;
				if(Math.random() > 0.5)
				{
					upgradestatus = UIBlackSmith.UPGRADE;
				}
				_blacksmithAni = new UIBlackSmith(upgradestatus);
				_blacksmithAni.x = e.item.x;
				_blacksmithAni.y = e.item.y;
				Main.gameLayer.addChild(_blacksmithAni);
				
				//character.x = e.item.x;
				//character.y = e.item.y - character.height + e.item.height * 0.5;
				GameInit.statusBar.addScore(10);
				//				if(_inventory.addItem(e.item) == null)
				//				{
				//					trace("your inventory is full!!");
				//				}
				//				_fireAni = new FireAnimation(AssetTranslationTable.ANI_FIRE);
				//				_fireAni.x = character.x;
				//				_fireAni.y = character.y;
				//				Main.gameLayer.addChild(_fireAni);
				
				new HTTPUpdatePoint(10);
				destroyRock(e.item.name);
				//JavaScriptInterface.request();
			}
		}
		private function hitHandler():void
		{
			GameInit.character.stunned();
			
		}
		private function onTimer(e:TimerEvent):void
		{
			var startingX:Number;
			var startingY:Number;
			var randSide:int = Util.randInt(0,3);
			switch(randSide)
			{
				case Util.LEFT:
					startingX = 0;
					startingY = Util.rand(0,stage.stageHeight)
					break;
				case Util.UP:
					startingX = Util.rand(0,stage.stageWidth);
					startingY = 0;
					break;
				case Util.RIGHT:
					startingX = stage.stageWidth;
					startingY = Util.rand(0,stage.stageHeight)
					break;
				case Util.DOWN:
					startingX = Util.rand(0,stage.stageWidth);
					startingY = stage.stageHeight;
					break;
				default:
					break;
			}
			var targetX:Number = stage.stageWidth * 0.5;
			var targetY:Number = stage.stageWidth * 0.5;
			
			var slopeY:Number = targetY - startingY;
			var slopeX:Number = targetX - startingX;
			
			var smallestDenominator:Number = Math.abs(slopeY) < Math.abs(slopeX) ? Math.abs(slopeY) : Math.abs(slopeX);
			var directionX:Number = slopeX/smallestDenominator;
			var directionY:Number = slopeY/smallestDenominator;
			
			if(directionX > MAX_SPEED)
				directionX = MAX_SPEED;
			if(directionX < -MAX_SPEED)
				directionX = -MAX_SPEED;
			
			if(directionY > MAX_SPEED)
				directionY = MAX_SPEED;
			if(directionY < -MAX_SPEED)
				directionY = -MAX_SPEED;
			
			
			var direction:DirectionData = new DirectionData(directionX, directionY);
			
			var url:String = null;
			if(Math.random() > 0.66)
			{
				url = AssetTranslationTable.SWORD_BOARD_SWORD;
			}
			else if(Math.random() > 0.33)
			{
				url = AssetTranslationTable.ANI_FIRE;
			}
			var rock:Rock = new Rock(url, direction);
			rock.name = _enemyKey.toString();
			_enemyDic[_enemyKey++] = rock;
			rock.x = startingX;
			rock.y = startingY;
			addChild(rock);
			
		}

		
	}
}