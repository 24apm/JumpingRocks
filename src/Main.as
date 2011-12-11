package
{
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Matrix3D;
	import flash.system.Security;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import javaScriptInterface.JavaScriptInterface;
	
	import request.HTTPGetOwner;
	
	import views.MapView;
	import views.ViewManager;

	// by querying the LoaderInfo object, set the value of paramObj to the 
	// to the value of the variable named myVariable passed from FlashVArs in the HTML
	
	

		
	[SWF(backgroundColor="0x000000" ,width="760" ,height="630")] 
	public class Main extends Sprite
	{
		
		private var _map:MapView;
		
		public static var gameLayer:Sprite;
		public static var uiLayer:Sprite;
		public static var charLayer:Sprite;
		
		public function Main()
		{	
			Security.allowDomain("*");
			
			// Start the MonsterDebugger

			
			AppVars.serverUrl = LoaderInfo(this.root.loaderInfo).parameters.serverUrl;
			AppVars.showFriends = LoaderInfo(this.root.loaderInfo).parameters.showFriends;
			
			if(AppVars.serverUrl == null)
			{
				MonsterDebugger.initialize(this);
				MonsterDebugger.trace(this, "Hello World!");
				AppVars.serverUrl =  "http://thecity.sfsu.edu/~hello608/flash/jumping_rocks/sandbox/";
			}
			
			

			trace("Main loaded!");
			gameLayer = new Sprite();
			addChild(gameLayer);
			
			uiLayer = new Sprite();
			addChild(uiLayer);
			
			charLayer = new Sprite();
			addChild(charLayer);
			
			
			
			addChild(new GameInit());
			
			
		}
		
	}
}