package views.jumpingEggs
{
	import config.AssetTranslationTable;
	import config.UILoaderConfig;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import specialObjects.Character;
	import specialObjects.FireAnimation;
	
	import util.Layer;
	
	import views.BasicView;

	public class JumpingEggView extends BasicView
	{
		private var _egg:UILoader;
		private var _character:Character;
		private var _loaderConfig:UILoaderConfig;
		private var _fireAni:FireAnimation;
		
		public function JumpingEggView(ViewClasses:Vector.<Class>=null, bgUrl:String=null)
		{
			super(ViewClasses, bgUrl);
		}
		protected override function init(e:Event = null):void
		{
			super.init(e);
			
			_loaderConfig = new UILoaderConfig(UILoaderConfig.CENTER);
			_egg = new UILoader(AssetTranslationTable.ANI_EGG, _loaderConfig);
			_egg.addEventListener(Event.COMPLETE, onEggLoaded);
		
			addChild(_egg);
			_egg.x = stage.stageWidth * 0.5;
			_egg.y = stage.stageHeight * 0.5;
			
		}
		private function onEggFinish(e:Event):void
		{
			_egg.loader.content.removeEventListener("animationComplete", onEggFinish);
			_egg.destruct();
		}
		private function onEggLoaded(e:Event):void
		{
			_egg.removeEventListener(Event.COMPLETE, onEggLoaded);
			(_egg.loader.content as MovieClip).gotoAndPlay("start");
			_egg.addEventListener(MouseEvent.CLICK, onEggClick);
			_egg.loader.content.addEventListener("animationComplete", onEggFinish);
			
		}
		private function onEggClick(e:MouseEvent):void
		{
			_egg.removeEventListener(MouseEvent.CLICK, onEggClick);
			(_egg.loader.content as MovieClip).gotoAndPlay("crack");
			buildChar();
		}
		private function buildChar():void
		{
			_character = new Character(AssetTranslationTable.CAT, _loaderConfig);
			addChildAt(_character, getChildIndex(_egg));

			_fireAni = new FireAnimation(AssetTranslationTable.ANI_FIRE, _loaderConfig);
			addChild(_fireAni);
			
			_character.x = _fireAni.x = _egg.x;
			_character.y = _fireAni.y = _egg.y;
		}
	}
}