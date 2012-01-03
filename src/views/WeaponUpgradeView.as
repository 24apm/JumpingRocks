package views
{
	import flash.events.Event;
	
	import specialObjects.UIWeapon;

	public class WeaponUpgradeView extends BasicView
	{
		private var _weapon:UIWeapon;
		public function WeaponUpgradeView()
		{
			var classes:Vector.<Class> = new Vector.<Class>();
			classes.push(SwampView);
			super(classes);
		}
		protected override function init(e:Event = null):void
		{
			super.init(e);
			_weapon = new UIWeapon();
			addChild(_weapon);
			_weapon.x = 100;
			_weapon.y = 100;
			
			// Left
			_warps[0].x = 0; 
			_warps[0].y = (stage.stageHeight - _warps[0].height) * 0.5;
		}
	}
}