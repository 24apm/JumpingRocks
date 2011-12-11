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
//			var label:UILabel = new UILabel("first_name " +String(data["first_name"]));
//			Main.uiLayer.addChild(label);
//			label.y = 100;
//			label.x = 200;
//			
//			var labelb:UILabel = new UILabel("id " +String(data["id"]));
//			Main.uiLayer.addChild(labelb);
//			labelb.y = 100;
//			labelb.x = 250;
		}
	}
}