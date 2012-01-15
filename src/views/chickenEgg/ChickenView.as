package views.chickenEgg
{
	import config.AssetTranslationTable;
	import config.ScrollerArrowsConfig;
	import config.ScrollerConfig;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import ui.Scrollable;
	import ui.Scroller;
	import ui.ScrollerArrows;
	
	import view.BasicView;
	
	public class ChickenView extends BasicView
	{
		private var _scroller:Scroller;
		
		public function ChickenView(ViewClasses:Vector.<Class>=null, bgUrl:String=null)
		{
			super(bgUrl);
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			this._bgImg = new UILoader(AssetTranslationTable.BG_CHICKEN);
			addChild(_bgImg);
		   
			var vec:Vector.<Scrollable> = new Vector.<Scrollable>();
			for(var i:Number=0;i<99;i++){
				var scrollable:Scrollable = new Scrollable(new UILoader(AssetTranslationTable.CHICKEN_WHITE), i.toString());
				vec.push(scrollable);
			}
			
			var config:ScrollerConfig = new ScrollerConfig(new Point(110,150), new Point(350,470),3,3,7);
			
			_scroller = new Scroller(vec,config);
			
			var scrollerArrows:ScrollerArrows = new ScrollerArrows(_scroller, new ScrollerArrowsConfig(10));
			
			addChild(scrollerArrows);
			scrollerArrows.x=30;
			scrollerArrows.y=30;
			
		}
	}
}