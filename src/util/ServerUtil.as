package util
{
	import config.AssetTranslationTable;
	import config.LookupTable;
	
	import data.InventoryData;
	import data.ItemData;
	
	import flash.geom.Point;
	
	import ui.AnimalScrollable;
	import ui.Scrollable;

	public class ServerUtil
	{
		private var _inventory:InventoryData;
		public function ServerUtil(inventory:InventoryData)
		{
			_inventory = inventory;
			initChicken();
			initEgg();
		}


		private function initEgg():void
		{
			for each(var eggData:ItemData in _inventory.eggData)
			{

				var scrollable:AnimalScrollable = new AnimalScrollable(new UILoader(AssetTranslationTable.EGG_BLANK), new Point(110,150), eggData);
				LookupTable.inventoryEgg.push(scrollable);
			}
		}
		private function initChicken():void
		{
			for each(var chickenData:ItemData in _inventory.chickenData)
			{

			
				var scrollable:AnimalScrollable = new AnimalScrollable(new UILoader(AssetTranslationTable.CHICKEN_BLANK), new Point(110,150), chickenData);
				LookupTable.inventoryChicken.push(scrollable);
			}
		}		
	}
}