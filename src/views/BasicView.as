package views 
{
	import config.AssetTranslationTable;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import specialObjects.Warp;

	public class BasicView extends UIElement
	{
		protected var _bgLayer:Sprite;
		protected var _obstacleLayer:Sprite;
		protected var _warpLayer:Sprite;
		protected var _warps:Vector.<Warp>;
		protected var _bgImg:UILoader;
		protected var _ViewClasses:Vector.<Class>;
		
		protected var _bgUrl:String;
		public function BasicView(ViewClasses:Vector.<Class> = null, bgUrl:String = null)
		{
			super();
			_ViewClasses = ViewClasses;
			_bgUrl = bgUrl;
			if(_bgUrl == null)
			{
				_bgUrl = AssetTranslationTable.MAP;
			}
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			initLayer();
			
		}
		private function initLayer():void
		{
			_bgLayer = new Sprite();
			addChild(_bgLayer);
			_bgImg = new UILoader(_bgUrl);
			_bgLayer.addChild(_bgImg);
			
			_obstacleLayer = new Sprite();
			addChild(_obstacleLayer);
			
			_warpLayer = new Sprite();
			addChild(_warpLayer);
			
			_warps = new Vector.<Warp>();
			if(_ViewClasses)
			{
				for each(var ViewClass:Class in _ViewClasses)
				{	var warp:Warp = new Warp(ViewClass);
					_warpLayer.addChild(warp);
					_warps.push(warp);
				}
			}
			
		}

		public override function destruct():void
		{
			if(_bgImg)
			{
				_bgImg.destruct();
				_bgImg = null;
			}
			super.destruct();
		}
	}
}