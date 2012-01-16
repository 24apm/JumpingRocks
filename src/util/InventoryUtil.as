package util
{
	import config.LookupTable;
	
	import ui.Scrollable;

	public class InventoryUtil
	{
		public function InventoryUtil()
		{
		}
		public static function removeChickenById(id:uint):void
		{
			var s:Scrollable
			for each(s in LookupTable.inventoryChicken)
			{
				if(s.id == id)
				{
					LookupTable.inventoryChicken.splice(id, 1);
					break;
				}
			}
		}
		public static function removeEggById(id:uint):void
		{
			var s:Scrollable
			for each(s in LookupTable.inventoryEgg)
			{
				if(s.id == id)
				{
					LookupTable.inventoryEgg.splice(id, 1);
					break;
				}
			}
		}
	}
}