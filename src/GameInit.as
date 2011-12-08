package
{
	import com.greensock.TweenLite;
	
	import event.ItemEvent;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import views.MapView;
	import views.ViewManager;

	public class GameInit extends UIElement
	{
		public static var character:Character;
		private var _inventory:UIInventory;
		private var _statusBar:StatusBar;
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
			
			_statusBar = new StatusBar();
			addChild(_statusBar);
			
			
			Main.gameLayer.addEventListener(ItemEvent.ITEM_CLICKED, itemClicked);
		
			stage.addEventListener(MouseEvent.CLICK, moveCharacter);
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
				_statusBar.addScore(10);
				if(_inventory.addItem(e.item) == null)
				{
					trace("your inventory is full!!");
				}
				_fireAni = new FireAnimation(AssetTranslationTable.ANI_FIRE);
				_fireAni.x = character.x;
				_fireAni.y = character.y;
				Main.gameLayer.addChild(_fireAni);
				
			}

		}
	}
}