package specialObjects
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import config.AssetTranslationTable;

	public class UIWeapon extends UILoader
	{
		private var _blacksmithAni:UIBlackSmith;
		public function UIWeapon()
		{
			super(AssetTranslationTable.SWORD_BOARD_SWORD);
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void
		{
			var upgradestatus:String = UIBlackSmith.DOWNGRADE;
			if(Math.random() > 0.5)
			{
				upgradestatus = UIBlackSmith.UPGRADE;
			}
			_blacksmithAni = new UIBlackSmith(upgradestatus);
			_blacksmithAni.x = this.x;
			_blacksmithAni.y = this.y;
			Main.gameLayer.addChild(_blacksmithAni);
		}
	}
}