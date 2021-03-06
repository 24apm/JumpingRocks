package views
{
	import config.AssetTranslationTable;
	
	import event.ItemEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import specialObjects.Rock;
	
	import util.Util;
	
	import view.BasicView;
	import view.WarpView;
	
	import views.dodgingRock.DodgingRockView;

	public class SwampView extends WarpView
	{
		private var _rocks:Vector.<Rock>;
		
		
		public function SwampView()
		{
			var classes:Vector.<Class> = new Vector.<Class>();
			classes.push(LandView, WeaponUpgradeView, LandView, DodgingRockView);
			super(classes, AssetTranslationTable.MAP);
		}
		protected override function init(e:Event = null):void
		{
			super.init();
			initBG();
			initRocks();
			
		}
		private function initBG():void
		{
	
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

			super.destruct();
		}
	}
}