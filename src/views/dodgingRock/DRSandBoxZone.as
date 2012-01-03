package views.dodgingRock
{
	import config.AssetTranslationTable;

	public class DRSandBoxZone extends UIElement
	{
		private var _background:UILoader;
		public function DRSandBoxZone()
		{
			super();

		}
		private function initBG():void
		{
			_background = new UILoader(AssetTranslationTable.MAP);
			addChild(_background);
		}
	}
}