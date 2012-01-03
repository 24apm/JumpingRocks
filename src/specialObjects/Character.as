package specialObjects
{
	import config.UILoaderConfig;
	
	import flash.events.Event;

	public class Character extends UIDirectionalElement
	{
		private var _url:String;
		private var _character:UILoader;
		private var _loaderConfig:UILoaderConfig;
		
		public function Character(url:String, loaderConfig:UILoaderConfig = null)
		{
			super();
			_url = url;
			_loaderConfig = loaderConfig;
		}
		protected override function init(e:Event = null):void
		{
			super.init(e);
			_character = new UILoader(_url, _loaderConfig);
			addChild(_character);
			
		}
		public override function stunned():void
		{
			1+1;
			super.stunned();
		}
		public override function destruct():void
		{ 
			if(_character)
			{
				_character.destruct();
				_character = null;
			}
			super.destruct();
		}
	}
}