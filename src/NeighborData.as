package 
{

	public class NeighborData
	{
		public var name:String;
		public var id:String;
		public var image:String;
		public function NeighborData(data:Object)
		{

			if(data["first_name"])
				name = data["first_name"];
			
			if(data["id"])
			{
				id = data["id"];
				image = "https://graph.facebook.com/" + id + "/picture";
			}
		}
	}
}