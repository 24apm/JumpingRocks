package
{
	import com.greensock.TweenLite;
	
	import config.AssetTranslationTable;
	import config.LookupTable;
	import config.Setting;
	
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
	import flash.utils.Timer;
	
	import javaScriptInterface.JavaScriptInterface;
	
	import org.osmf.events.TimeEvent;
	
	import request.HTTPGetOwner;
	import request.HTTPUpdatePoint;
	import request.PlatformUtil;
	
	import specialObjects.Character;
	import specialObjects.FireAnimation;
	import specialObjects.Rock;
	import specialObjects.UIBlackSmith;
	
	import ui.StatusBar;
	import ui.UIInventory;
	
	import util.Layer;
	import util.Util;
	
	import views.ArmyBattleView;
	import views.SwampView;
	import views.ViewManager;
	
	
	public class GameInit extends UIElement
	{
		public static var character:Character;
		private var _loadFriendTimer:Timer;
		private var _fireAni:FireAnimation;
		
		
		public function GameInit()
		{
			super();
			
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			addChild(new Layer);
			
			//initChar();
			
			//initGameUI();
			initUser();
			initNeighbors();
			
		}
		private function initGame():void
		{
			ViewManager.loadView(Setting.STARTING_VIEW);
//			Layer.uiLayer.addChild(new GameUI());
		}
		private function initChar():void
		{
			character = new Character(AssetTranslationTable.CAT);
			Layer.charLayer.addChild(character);
			stage.addEventListener(MouseEvent.CLICK, moveCharacter);
		}

		private function setNeighbors(params:Object):void
		{
			stopFriendTimer();
			if(params != null)
			{
				
				for each(var neighborData:Object in params)
				{
					LookupTable.neighborsList.push(new NeighborData(neighborData));
				}
				initGame();
				if(AppVars.showFriends)
					showNeighbors();
			}
			
		}
		private function showNeighbors():void
		{
			for each(var neighbor:NeighborData in LookupTable.neighborsList)
			{
				var img:Rock = new Rock(neighbor.pic_square);
				Layer.gameLayer.addChild(img);
				img.x = Util.rand(0, stage.stageWidth);
				img.y = Util.rand(0, stage.stageHeight);
			}
		}
		private function startFriendTimer():void
		{
			var loops:int = 7;
			if(AppVars.debug)
			{
				loops = 1;
			}
			_loadFriendTimer = new Timer(1000,loops);
			_loadFriendTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_loadFriendTimer.start();
			
		}
		private function onTimerComplete(e:Event):void
		{
			stopFriendTimer();
			initGame();
		}
		private function stopFriendTimer():void
		{
			if(_loadFriendTimer)
			{
				_loadFriendTimer.stop();
				_loadFriendTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
				_loadFriendTimer = null;
			}
		}
		private function initNeighbors():void
		{
			startFriendTimer();
			PlatformUtil.call("getFriendsData", setNeighbors);
		}
		private function initUser():void
		{
			LookupTable.currentUserId = String(PlatformUtil.getMyData());
			var currentUserId:String = LookupTable.currentUserId;
		}

		public static function addLabel(text:String, point:Point):void
		{
			var label:UILabel = new UILabel(text);
			Layer.uiLayer.addChild(label);
			label.x = point.x;
			label.y = point.y;
			
		}
		public static function moveCharacter(e:MouseEvent):void
		{
			TweenLite.to(character, 10, {x:e.stageX, y:e.stageY, ease:100});
		
		}
	
	}
}