package
{
	import config.AssetTranslationTable;
	import config.LookupTable;
	import config.ScrollerArrowsConfig;
	import config.ScrollerConfig;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import request.HTTPGetOwner;
	import request.HTTPLite;
	
	import style.RectangleStyle;
	
	import ui.Minimap;
	import ui.Scrollable;
	import ui.Scroller;
	import ui.ScrollerArrows;
	import ui.StatusBar;
	import ui.UIInventory;
	
	import util.DrawShape;
	import util.Util;

	public class GameUI extends UIElement
	{
		public static var statusBar:StatusBar;
		private var _inventory:UIInventory;
		private var _minimap:Minimap;
		
		private var _scrollerArrows:ScrollerArrows;
		
		public function GameUI()
		{
			super();
		}
		protected override function init(e:Event = null):void
		{
			super.init(e);
			initMap();
			initUI();
			initScroller();
		}
		private function initMap():void
		{
			_minimap = new Minimap();
			addChild(_minimap);
			_minimap.x = 200;
			
		}
		private function initUI():void
		{
			_inventory = new UIInventory();
			addChild(_inventory);
			_inventory.x = stage.stageWidth - _inventory.width;
			_inventory.y = (stage.stageHeight - _inventory.height) * 0.5;
			_inventory.visible = false;
			
			statusBar = new StatusBar();
			addChild(statusBar);
			
//			var http:HTTPGetOwner = new HTTPGetOwner ();
//			http.addEventListener(HTTPLite.HTTP_EVENT, setStatusBar);
//			function setStatusBar():void
//			{
//				GameUI.statusBar.setScore(http.score);
//			}
		}
		private function generateNeighborScrollables():Vector.<Scrollable>
		{
			var vector:Vector.<Scrollable> = new Vector.<Scrollable>();
			var element:UIElement;
			var label:UILabel;
			var scrollable:Scrollable;
			var neighborPic:UILoader;
			var neighborNeighbor:Vector.<NeighborData> = LookupTable.neighborsList;
			for (var i:uint = 0; i < neighborNeighbor.length; i++)
			{
				element = new UIElement;
				label = new UILabel(i.toString());
				element.addChild(label);
				neighborPic = new UILoader(neighborNeighbor[i].pic_square)
				element.addChild(neighborPic);
				neighborPic.x = 10;
				neighborPic.y = 10;
				DrawShape.drawRect(element.graphics, new Rectangle(0,0,60,100), new RectangleStyle(0x00FF00,1));
				scrollable = new Scrollable(element);
				vector.push(scrollable);
			}
			
			return vector;
		}
		private function generateScrollables():Vector.<Scrollable>
		{
			var vector:Vector.<Scrollable> = new Vector.<Scrollable>();
			var element:UIElement;
			var label:UILabel;
			var scrollable:Scrollable;
			var armyGuy:UILoader;
			var army:Array = 
				[AssetTranslationTable.ARMY_BLUE,
				AssetTranslationTable.ARMY_GREEN,
				AssetTranslationTable.ARMY_RED,
				AssetTranslationTable.ARMY_YELLOW];
			for (var i:uint = 0; i < 100; i++)
			{
				element = new UIElement;
				label = new UILabel(i.toString());
				element.addChild(label);
				armyGuy = new UILoader(army[Util.randInt(0,3)])
				element.addChild(armyGuy);
				armyGuy.x = 20;
				armyGuy.y = 20;
				DrawShape.drawRect(element.graphics, new Rectangle(0,0,60,100), new RectangleStyle(0x00FF00,1));
				scrollable = new Scrollable(element);
				vector.push(scrollable);
			}
			
			return vector;
		}
		private function initScroller():void
		{
			
	
			var scrollables:Vector.<Scrollable>;
			if(AppVars.showFriends)
			{
				scrollables = generateNeighborScrollables();
			}
			else
			{
				scrollables = generateScrollables();
			}
			var scroller:Scroller = new Scroller(scrollables, new ScrollerConfig(new Point(60,100), new Point(600,120), 7, 1, 20));
			var arrowsConfig:ScrollerArrowsConfig = new ScrollerArrowsConfig(10);
			
			_scrollerArrows = new ScrollerArrows(scroller, arrowsConfig);
			addChild(_scrollerArrows);
			
			_scrollerArrows.y = 500;
			_scrollerArrows.x = 50;
		}
	}
}