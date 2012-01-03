package views
{
	import util.Layer;

	public class ViewManager
	{
		private static var _lastView:BasicView;
		public function ViewManager()
		{
			super.init();
		}
		public static function loadView(ViewClass:Class):void
		{
			if(_lastView != null)
				_lastView.destruct();
			_lastView = new ViewClass() as BasicView;
			Layer.gameLayer.addChild(_lastView);
		}
	}
}