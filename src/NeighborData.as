package 
{

	public class NeighborData
	{
		public var name:String;
		public var uid:String;
		public var pic_square:String;
		public function NeighborData(data:Object)
		{

			if(data["first_name"])
				name = data["first_name"];
			
			if(data["uid"])
			{
				uid = data["uid"];
			}
			if(data["pic_square"])
			{
				pic_square = data["pic_square"];
			}
		}
	}
}