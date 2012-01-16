package views.chickenEgg
{
	import config.AssetTranslationTable;
	import config.LookupTable;
	import config.ScrollerArrowsConfig;
	import config.ScrollerConfig;
	
	import event.ItemEvent;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import request.HTTPHatchEgg;
	import request.HTTPLayEgg;
	
	import style.Style;
	
	import ui.AnimalScrollable;
	import ui.Scrollable;
	import ui.Scroller;
	import ui.ScrollerArrows;
	import ui.UILoaderButton;
	
	import util.InventoryUtil;
	
	import view.BasicView;
	import view.ViewManager;
	
	public class EggView extends BasicView
	{
		private var _scroller:Scroller;
		private var _title:UILabel;
		
		private var _book:UILoaderButton;
		private var _nextPage:UILoaderButton;
			
		public function EggView(bgUrl:String=null)
		{
			super(bgUrl);
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			this._bgImg = new UILoader(AssetTranslationTable.BG_CHICKEN);
			addChild(_bgImg);
			
			
			// title
			_title = new UILabel("Egg" , Style.labelStyleHeader);
			addChild(_title);
			_title.x = 50;
			_title.y = 30;
			
			
			// buttons
			_book = new UILoaderButton(AssetTranslationTable.EGG_BOOK, onBookClick);
			addChild(_book);
			_book.x = 600;
			_book.y = 330;
			
			_nextPage = new UILoaderButton(AssetTranslationTable.EGG_BLANK, onBlankClick);
			addChild(_nextPage);
			_nextPage.x = 600;
			_nextPage.y = 460;
			
			// scroller
			var config:ScrollerConfig = new ScrollerConfig(new Point(110,150), new Point(350,470),3,3,7);
			_scroller = new Scroller(LookupTable.inventoryEgg,config);
			
			var scrollerArrows:ScrollerArrows = new ScrollerArrows(_scroller, new ScrollerArrowsConfig(10));
			
			addChild(scrollerArrows);
			_scroller.addEventListener(ItemEvent.ITEM_CLICKED, onItemClick);
			scrollerArrows.x=50;
			scrollerArrows.y=100;
			
			
//			addEgg();
		}
		private function onBookClick():void
		{
			ViewManager.loadView(ChickenView);
		}
		private function onBlankClick():void
		{
			ViewManager.loadView(ChickenView);
		}
		private function addEgg():void
		{
			_scroller.addScrollables(LookupTable.inventoryEgg);
		}
		private function onItemClick(e:ItemEvent):void
		{
			var scrollable:AnimalScrollable = e.target as AnimalScrollable;
			_scroller.removeScrollableById(scrollable.id);
			InventoryUtil.removeEggById(scrollable.id);
			
			switch(scrollable.itemData.type)
			{
				case LookupTable.CHICKEN:
					new HTTPLayEgg(scrollable.itemData.id);				
					break;
				case LookupTable.EGG:
					new HTTPHatchEgg(scrollable.itemData.id);
					break;
				default:
					trace("Not supported: " + scrollable.itemData.type);
					break;	
			}
		}		
	}
}