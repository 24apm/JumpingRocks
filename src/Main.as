package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.geom.Matrix3D;
	import flash.ui.Keyboard;
	
	import javaScriptInterface.JavaScriptInterface;
	
	import views.MapView;
	import views.ViewManager;
	
	[SWF(backgroundColor="0x000000" ,width="760" ,height="630")] 
	public class Main extends Sprite
	{
		private var _map:MapView;
		
		public static var gameLayer:Sprite;
		public static var uiLayer:Sprite;
		public static var charLayer:Sprite;
		
		public function Main()
		{	

			trace("Main loaded!");
			gameLayer = new Sprite();
			addChild(gameLayer);

			uiLayer = new Sprite();
			addChild(uiLayer);
			
			charLayer = new Sprite();
			addChild(charLayer);
			
			addChild(new GameInit());
			
			var obj:Object = JavaScriptInterface.getNeighbor();
		var label:UILabel = new UILabel("HIIIIIIIIIIIIIIIIIII " +String(obj));
			uiLayer.addChild(label);
			label.x = 200;
	}
	
	}
}