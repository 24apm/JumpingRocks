package views
{
	import event.ItemEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class MapView extends BasicView
	{
		private var _background:UILoader;
		private var _rocks:Vector.<Rock>;
		
		
		public function MapView()
		{
			var classes:Vector.<Class> = new Vector.<Class>();
			classes.push(LandView, LandView, LandView, LandView);
			super(classes);
		}
		protected override function init(e:Event = null):void
		{
			super.init();
			initBG();
			initRocks();
		
		}

		private function initBG():void
		{
			_background = new UILoader(AssetTranslationTable.MAP);
			_bgLayer.addChild(_background);
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

		public override function destruct():void
		{
			if(_background)
			{
				_background.destruct();
				_background = null;
			}
			super.destruct();
		}
	}
}