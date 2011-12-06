package views
{
	import flash.events.Event;

	public class LandView extends BasicView
	{
		private var _bg:UILoader;
		private var _char:Character;
		private var _rocks:Vector.<Rock>;
		public function LandView()
		{
			var classes:Vector.<Class> = new Vector.<Class>();
			classes.push(MapView, MapView, MapView, MapView);
			super(classes);
		}
		protected override function init(e:Event = null):void
		{
			super.init(e);
			_bg = new UILoader(AssetTranslationTable.BG_LAND);
			_bgLayer.addChild(_bg);
			
			initRocks();
		}
		private function initRocks():void
		{
			_rocks = new Vector.<Rock>();
			var rock:Rock;
			for (var i:int = 0; i < 20; i++)
			{
				rock = new Rock(AssetTranslationTable.ROCK);
				_rocks.push(rock);
				_obstacleLayer.addChild(rock);
				rock.x = Util.rand(0, stage.stageWidth);
				rock.y = Util.rand(0, stage.stageHeight);
			}
			
		}
	}
}