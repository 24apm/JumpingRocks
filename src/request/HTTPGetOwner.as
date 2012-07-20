package request
{
	
	import config.LookupTable;
	
	import data.InventoryData;
	import data.ItemData;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class HTTPGetOwner extends HTTPLite
	{
		public var id:String;
		public var score:uint;
		public var email:String;
		public var firstName:String;
		public var gender:String;
		public var inventory:InventoryData;
		public var lastName:String;
		public var lastLogin:String;
		public var loginCount:String;
		
		public static const GET_USER:String = "getCurrentUser";
		public function HTTPGetOwner()
		{
			super(GET_USER);
			var variables:URLVariables = new URLVariables();
			variables.id = LookupTable.currentUserId;   
			send(variables);
		}
		protected override function onComplete (e:Event):void{
			//GameInit.addLabel("HTTPGet onComplete " + e.currentTarget.data , new Point(0,120));
			
			var obj:Object = {};
			try
			{
				obj = JSON.parse(e.currentTarget.data);
			}
			catch(e:Error)
			{
				trace("Error: No session or error in parsing");
			}
			if(obj.hasOwnProperty("email"))
				email = obj["email"];
			
			if(obj.hasOwnProperty("first_name"))
				firstName = obj["first_name"];
			
			if(obj.hasOwnProperty("gender"))
				gender = obj["gender"];
		
			if(obj.hasOwnProperty("id"))
				id = obj["id"];
			
			if(obj.hasOwnProperty("login_count"))
				loginCount = obj["login_count"];

			
			if(obj.hasOwnProperty("last_login"))
				lastLogin = obj["last_login"];
			
			if(obj.hasOwnProperty("inventory"))
			{
				try
				{
					var inventoryObj:Object = JSON.parse(obj["inventory"]);
					inventory = new InventoryData(inventoryObj);
				}
				catch(e:Error)
				{
					trace("Error: Error in parsing inventory data");
				}			
			}
			
			
		
			
			
			if(obj.hasOwnProperty("last_name"))
				lastName = obj["last_name"];
			


			if(obj.hasOwnProperty("score"))
				score = obj["score"];
			
			super.onComplete(e);
		}  
	}
}