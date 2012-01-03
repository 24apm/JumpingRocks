package data
{
	public class ArmyUnitData
	{
		public var hp:int;
		public function ArmyUnitData(_hp:int)
		{
			hp = _hp;
		}
		
		public static function testArmyUnitData():ArmyUnitData
		{
			return new ArmyUnitData(10);
		}
	}
}