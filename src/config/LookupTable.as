package config 
{
	public class LookupTable
	{
		public function LookupTable()
		{
		}
		public static function init():void
		{
			neighborsList = new Vector.<NeighborData>();
			currentUserId = '';
		}
		public static var neighborsList:Vector.<NeighborData>;
		public static var currentUserId:String;
	}
}