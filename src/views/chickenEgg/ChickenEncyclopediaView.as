package views.chickenEgg
{
	import config.AssetTranslationTable;
	import config.LookupTable;
	import config.ScrollerArrowsConfig;
	import config.ScrollerConfig;
	
	import event.ItemEvent;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import flashx.textLayout.formats.TextAlign;
	
	import style.Style;
	
	import ui.Scrollable;
	import ui.Scroller;
	import ui.ScrollerArrows;
	
	import view.BasicView;
	
	public class ChickenEncyclopediaView extends BasicView
	{
		private var _scroller:Scroller;
		private var _title:UILabel;
		public function ChickenEncyclopediaView(bgUrl:String=null)
		{
			super(bgUrl);
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			this._bgImg = new UILoader(AssetTranslationTable.BG_CHICKEN);
			addChild(_bgImg);
			
			
			// title
			_title = new UILabel("Chickapedia" , Style.labelStyleHeader);
			addChild(_title);
			_title.autoSize = TextAlign.LEFT;
			_title.x = 50;
			_title.y = 30;
			
			// scroller
			
			var element:UIElement;
			var types:Vector.<String> = LookupTable.chickEncyclopdia;
			var loader:UILoader
			var scrollables:Vector.<Scrollable> = new Vector.<Scrollable>();
			
			for(var i:int = 0; i < LookupTable.chickEncyclopdiaLevel; i++)	
			{
				element = new UIElement();
				loader = new UILoader(LookupTable.chickEncyclopdia[i]);
				element.addChild(loader);
				scrollables.push(new Scrollable(element, new Point(150,135)));
			}
			
			
			var config:ScrollerConfig = new ScrollerConfig(new Point(150,135), new Point(500,450),3,3,7);
			_scroller = new Scroller(scrollables,config);
			
			addChild(_scroller);
			_scroller.x=50;
			_scroller.y=100;
			
		}
	}
}