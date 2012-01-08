package specialObjects
{
	import config.AssetTranslationTable;
	import config.UILoaderConfig;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import request.HTTPLite;
	import request.HTTPUpdatePoint;
	import request.PlatformUtil;
	
	import specialObjects.Character;
	import specialObjects.FireAnimation;
	
	import util.Layer;

	public class JumpingEgg extends UIElement
	{
		private var _egg:UILoader;
		private var _character:Character;
		private var _loaderConfig:UILoaderConfig;
		private var _fireAni:FireAnimation;
		private var _characterUrl:String;
		
		private var _friendData:NeighborData;
		
		public function JumpingEgg(characterUrl:String, friendData:NeighborData = null)
		{
			super();
			_characterUrl = characterUrl;
			
			_friendData = friendData;
		}

		protected override function init(e:Event=null):void
		{
			super.init(e);
			_loaderConfig = new UILoaderConfig(UILoaderConfig.CENTER);
			_egg = new UILoader(AssetTranslationTable.ANI_EGG, _loaderConfig);
			_egg.addEventListener(Event.COMPLETE, onEggLoaded);
			
			addChild(_egg);
//			_egg.x = stage.stageWidth * 0.5;
//			_egg.y = stage.stageHeight * 0.5;
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
			_character = new Character(_characterUrl, _loaderConfig);
			addChildAt(_character, getChildIndex(_egg));
			
			_fireAni = new FireAnimation(AssetTranslationTable.ANI_FIRE, _loaderConfig);
			addChild(_fireAni);
			
			_character.x = _fireAni.x = _egg.x;
			_character.y = _fireAni.y = _egg.y;
			_character.y -= 20;
			_character.addEventListener(MouseEvent.CLICK, onCharClick);
		
		
			var http:HTTPUpdatePoint = new HTTPUpdatePoint (10);
			http.addEventListener(HTTPLite.HTTP_EVENT, setStatusBar);
			function setStatusBar():void
			{
				GameUI.statusBar.setScore(http.score);
			}
		}
		private function onCharClick(e:MouseEvent):void
		{
			if(_friendData)
				PlatformUtil.request(_friendData.uid);
			else
				PlatformUtil.request();
		}
	}
}