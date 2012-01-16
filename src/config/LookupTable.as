package config 
{
	import ui.Scrollable;
	
	import views.chickenEgg.ChickenView;

	public class LookupTable
	{
		public function LookupTable()
		{
		}
		public static function init():void
		{
			neighborsList = new Vector.<NeighborData>();
			currentUserId = '';
			
			chickEncyclopdia = new Vector.<String>();
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_WHITE);
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_YELLOW);
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_ORANGE);
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_GREEN);
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_BLUE);
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_PURPLE);
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_RED);
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_BROWN);
			chickEncyclopdia.push(AssetTranslationTable.CHICKEN_BLACK);
			
		}
		public static var neighborsList:Vector.<NeighborData>;
		public static var currentUserId:String;
		
		
		public static var inventoryChicken:Vector.<Scrollable> = new Vector.<Scrollable>();
		public static var inventoryEgg:Vector.<Scrollable>  = new Vector.<Scrollable>();
			
		public static const CHICKEN:String = "chicken";
		public static const EGG:String 		= "egg";
		public static var chickEncyclopdia:Vector.<String>;
		
		//TODO hardcoded level cap to show in encyclopdia
		public static var chickEncyclopdiaLevel:int = 9;

	}
}