package
{
	import com.greensock.TweenLite;
	
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
	
	import request.HTTPGetOwner;
	import request.HTTPUpdatePoint;
	
	import views.MapView;
	import views.ViewManager;
	
	
	public class GameInit extends UIElement
	{
		public static var character:Character;
		private var _inventory:UIInventory;
		public static var statusBar:StatusBar;
		private var _fireAni:FireAnimation;
		
		public function GameInit()
		{
			super();
			
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			ViewManager.loadView(MapView);
			
			
			character = new Character(AssetTranslationTable.CAT);
			Main.charLayer.addChild(character);
			
			_inventory = new UIInventory();
			Main.uiLayer.addChild(_inventory);
			_inventory.x = stage.stageWidth - _inventory.width;
			_inventory.y = (stage.stageHeight - _inventory.height) * 0.5;
			
			statusBar = new StatusBar();
			addChild(statusBar);
			
			
			Main.gameLayer.addEventListener(ItemEvent.ITEM_CLICKED, itemClicked);
			
			stage.addEventListener(MouseEvent.CLICK, moveCharacter);
			
			LookupTable.currentUserId = ExternalInterface.call("getMe");
			var currentUserId:String = LookupTable.currentUserId;
			
			LookupTable.neighborsList = new Vector.<NeighborData>();
			
			var timer:Timer = new Timer(1000, 7);
			timer.addEventListener(TimerEvent.TIMER, getData);
			timer.start();
			var obj:Object;
			
			function getData(e:Event):void
			{
				
				obj = JavaScriptInterface.getNeighbor();
				if(obj != null)
				{
					
					
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER_COMPLETE, getData);
					
					var ownerStats:HTTPGetOwner = new HTTPGetOwner ();
					
					for each(var neighborData:Object in obj)
					{
						LookupTable.neighborsList.push(new NeighborData(neighborData));
					}
					if(AppVars.showFriends == true)
					{
						for each(var neighbor:NeighborData in LookupTable.neighborsList)
						{
							//						var labelb:UILabel = new UILabel("neighbor.image " +neighbor.image);
							//						Main.uiLayer.addChild(labelb);
							//						labelb.y = 100;
							//						labelb.x = 300;
							
							var img:Rock = new Rock(neighbor.image);
							Main.gameLayer.addChild(img);
							img.x = Util.rand(0, stage.stageWidth);
							img.y = Util.rand(0, stage.stageHeight);
							
							
						}
					}
				}
			}
			
			
			
			
		}
		public static function addLabel(text:String, point:Point):void
		{
			var label:UILabel = new UILabel(text);
			Main.uiLayer.addChild(label);
			label.x = point.x;
			label.y = point.y;
			
		}
		private function moveCharacter(e:MouseEvent):void
		{
			TweenLite.to(character, 10, {x:e.stageX, y:e.stageY, ease:100});
			
		}
		private function itemClicked(e:ItemEvent):void
		{
			if(e.item is Rock)
			{
				character.x = e.item.x;
				character.y = e.item.y - character.height + e.item.height * 0.5;
				statusBar.addScore(10);
				if(_inventory.addItem(e.item) == null)
				{
					trace("your inventory is full!!");
				}
				_fireAni = new FireAnimation(AssetTranslationTable.ANI_FIRE);
				_fireAni.x = character.x;
				_fireAni.y = character.y;
				Main.gameLayer.addChild(_fireAni);
				new HTTPUpdatePoint(10);
				//JavaScriptInterface.request();
				
			}
			
		}
	}
}