package data
{
	public class InventoryData
	{
		public var chickenData:Vector.<ItemData>;
		public var eggData:Vector.<ItemData>;
				
		public function InventoryData(serverData:Object)
		{
			chickenData = new Vector.<ItemData>();
			eggData = new Vector.<ItemData>();
			
			if(serverData.hasOwnProperty("chicken"))
			{
				for (var cKey:Object in serverData["chicken"])
				{
					serverData["chicken"][cKey].id = cKey;
					serverData["chicken"][cKey].type = "chicken";
					chickenData.push(new ItemData(serverData["chicken"][cKey]));
				}
			}
			if(serverData.hasOwnProperty("egg"))
			{
				for (var eKey:Object in serverData["egg"])
				{
					serverData["egg"][eKey].id = eKey;
					serverData["egg"][eKey].type = "egg";
					eggData.push(new ItemData(serverData["egg"][eKey]));
				}
			}

		}
	}
}