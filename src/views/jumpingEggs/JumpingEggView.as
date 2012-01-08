package views.jumpingEggs
{
	import config.AssetTranslationTable;
	import config.LookupTable;
	import config.UILoaderConfig;
	
	import flash.debugger.enterDebugger;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import request.PlatformUtil;
	
	import specialObjects.Character;
	import specialObjects.FireAnimation;
	import specialObjects.JumpingEgg;
	
	import util.Layer;
	import util.Util;
	
	import views.BasicView;

	public class JumpingEggView extends BasicView
	{
		
		

		private var _jumpingEggVec:Vector.<JumpingEgg>;
		
		public function JumpingEggView(ViewClasses:Vector.<Class>=null, bgUrl:String=null)
		{
			super(ViewClasses, bgUrl);
		}
		protected override function init(e:Event = null):void
		{
			super.init(e);
			
			// Get random friend
			if(AppVars.showFriends)
				friendJumpingEgg();
			else
				animatedJumpingEgg();
			
			//generateEggs();
			//
		}
		private function friendJumpingEgg():void
		{
			var friend:NeighborData = LookupTable.neighborsList[Util.randInt(0,LookupTable.neighborsList.length-1)];
			var jumpingEgg:JumpingEgg = new JumpingEgg(friend.pic_square, friend);
			addChild(jumpingEgg);
			jumpingEgg.x = stage.stageWidth * 0.5;
			jumpingEgg.y = stage.stageHeight * 0.5;
		}
		private function animatedJumpingEgg():void
		{
			var jumpingEgg:JumpingEgg = new JumpingEgg(AssetTranslationTable.ANI_FIREBOY);
			addChild(jumpingEgg);
			jumpingEgg.x = stage.stageWidth * 0.5;
			jumpingEgg.y = stage.stageHeight * 0.5;
		}
		private function onEnterFrame(e:Event):void
		{
			var jumpingEgg:JumpingEgg ;
			for each(jumpingEgg in _jumpingEggVec)
			{	var rateX:Number;
				var rateY:Number; 

				
				if(mouseX > jumpingEgg.x)
					rateX  = mouseX/jumpingEgg.x;
				else
					rateX = jumpingEgg.x / mouseX;
				
				if(mouseY > jumpingEgg.y)
					rateY  = mouseY/jumpingEgg.y;
				else
					rateY = jumpingEgg.y / mouseY;
				
				if(rateX > 5) rateX = 5;
				if(rateY > 5) rateY = 5;
				
				if(mouseX > jumpingEgg.x)
					jumpingEgg.x += rateX ;
				else
					jumpingEgg.x -= rateX ;
				
				if(mouseY > jumpingEgg.y)
					jumpingEgg.y += rateY;
				else
					jumpingEgg.y -= rateY;
			}
		}
		private function generateEggs():void
		{
			_jumpingEggVec = new Vector.<JumpingEgg>();
			var jumpingEgg:JumpingEgg ;
			var padding:Number = 100;
			for(var i:int = 0; i < 50; i++)
			{
				jumpingEgg = new JumpingEgg(AssetTranslationTable.ANI_FIREBOY);
				_jumpingEggVec.push(jumpingEgg);
				addChild(jumpingEgg);
				
			}
			position();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function position():void
		{
			var jumpingEgg:JumpingEgg;
			var jumpingEggWidth:Number = 60;
			var jumpingEggHeight:Number = 100;
			var jumpHori:int = 10;
			var jumpVert:int = 5;
			for(var i:int = 0; i < jumpVert; i++)
			{

				for(var j:int = 0; j < jumpHori; j++)
				{
					jumpingEgg = _jumpingEggVec[i*jumpHori + j];
					jumpingEgg.x = j*jumpingEggWidth + jumpingEggWidth;
					jumpingEgg.y = i*jumpingEggHeight + jumpingEggHeight;
					
				}
			}
		}
	}
}