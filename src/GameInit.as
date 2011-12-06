package
{
	import event.ItemEvent;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import views.MapView;
	import views.ViewManager;

	public class GameInit extends UIElement
	{
		public static var character:Character;
		private var _inventory:UIInventory;
		private var _statusBar:StatusBar;
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
				
				
			}

		}
	}
}