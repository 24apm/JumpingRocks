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
		private var _statusBar:StatusBar;
		public function GameInit()
		{
			super();

		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			character = new Character(AssetTranslationTable.CAT);
			Main.charLayer.addChild(character);
			
			ViewManager.loadView(MapView);

			
			Main.gameLayer.addEventListener(ItemEvent.ITEM_CLICKED, itemClicked);
			

			_statusBar = new StatusBar();
			addChild(_statusBar);
			
		}
		private function itemClicked(e:ItemEvent):void
		{
			if(e.item is Rock)
			{
				character.x = e.item.x;
				character.y = e.item.y - character.height + e.item.height * 0.5;
				_statusBar.addScore(10);
				e.item.destruct();
			}
		}
	}
}