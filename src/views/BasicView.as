package views 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class BasicView extends UIElement
	{
		protected var _bgLayer:Sprite;
		protected var _obstacleLayer:Sprite;
		protected var _warpLayer:Sprite;
		protected var _warps:Vector.<Warp>;
		
		protected var _ViewClasses:Vector.<Class>;
		public function BasicView(ViewClasses:Vector.<Class>)
		{
			super();
			_ViewClasses = ViewClasses;
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
			
			_obstacleLayer = new Sprite();
			addChild(_obstacleLayer);
			
			_warpLayer = new Sprite();
			addChild(_warpLayer);
			
			_warps = new Vector.<Warp>();
			for each(var ViewClass:Class in _ViewClasses)
			{	var warp:Warp = new Warp(ViewClass);
				_warpLayer.addChild(warp);
				_warps.push(warp);
			}
			//Top
			_warps[0].x = (stage.stageWidth - _warps[0].width)* 0.5; 
			_warps[0].y = 0;
			
			// Right
			_warps[1].x = (stage.stageWidth - _warps[1].width); 
			_warps[1].y = (stage.stageHeight - _warps[1].height)* 0.5; 
			
			// Down
			_warps[2].x = (stage.stageWidth - _warps[2].width) * 0.5;
			_warps[2].y = (stage.stageHeight - _warps[2].height); 
				
			// Left
			_warps[3].x = 0; 
			_warps[3].y = (stage.stageHeight - _warps[3].height) * 0.5;
		}

		public override function destruct():void
		{

			super.destruct();
		}
	}
}