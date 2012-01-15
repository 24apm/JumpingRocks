package
{
	import com.demonsters.debugger.MonsterDebugger;
	
	import config.LookupTable;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.system.Security;
	
	import request.PlatformUtil;


	// by querying the LoaderInfo object, set the value of paramObj to the 
	// to the value of the variable named myVariable passed from FlashVArs in the HTML
	
	

		
	[SWF(backgroundColor="0x000000" ,width="760" ,height="630")] 
	public class Main extends Sprite
	{

		
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
				AppVars.debug = true;
			}
			PlatformUtil.init();
			LookupTable.init();

			trace("Main loaded!");
			addChild(new GameInit());
			
		}
		
	}
}