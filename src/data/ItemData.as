package data
{
	import com.adobe.protocols.dict.Database;
	
	import util.Util;

	public class ItemData
	{
		public var type:String;
		public var id:String;
		public var readyIn:Number;
		
		public function ItemData(serverData:Object)
		{
			type = serverData["type"];
			id = serverData["id"];
			readyIn = serverData["ready_in"];
			
			var timestampe:Number = Util.getTimeStamp();

		}
	}
}