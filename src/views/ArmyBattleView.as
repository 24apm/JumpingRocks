package views
{
	import com.adobe.utils.DictionaryUtil;
	import com.greensock.TweenLite;
	
	import config.AssetTranslationTable;
	
	import data.ArmyUnitData;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import specialObjects.Rock;
	import specialObjects.UIArmyUnit;
	
	import util.Util;
	
	public class ArmyBattleView extends BasicView
	{
		private var _blueVec:Vector.<UIArmyUnit>;
		private var _redVec:Vector.<UIArmyUnit>;
		private var _blueCounts:int = 0;
		private var _redCounts:int = 0;
		public function ArmyBattleView(ViewClasses:Vector.<Class> = null, bgUrl:String=null)
		{
			super(ViewClasses, bgUrl);
		}
		protected override function init(e:Event=null):void
		{
			super.init(e);
			_blueVec = new Vector.<UIArmyUnit>;
			_redVec = new Vector.<UIArmyUnit>;
			var army:UIArmyUnit;
			for (var i:int = 0; i < 10; i++)
			{
				army = new UIArmyUnit(AssetTranslationTable.ARMY_BLUE, ArmyUnitData.testArmyUnitData());
				addChild(army);
				_blueVec.push(army);
				army.x = Util.rand(0, stage.stageWidth);
				army.y = Util.rand(0,stage.stageHeight);
				_blueCounts++;
				
			}
			for (var j:int = 0; j < 10; j++)
			{
				army = new UIArmyUnit(AssetTranslationTable.ARMY_RED, ArmyUnitData.testArmyUnitData());
				addChild(army);
				_redVec.push(army);
				army.x = Util.rand(0, stage.stageWidth);
				army.y = Util.rand(0,stage.stageHeight);	
				_redCounts++;
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener("death", onDeath);
		}
		private function onDeath(e:Event):void
		{
			var army:UIArmyUnit = e.target as UIArmyUnit;
			if(army != null)
			{
				var index:int = _blueVec.indexOf(army);
				_blueVec[index].destruct();
				_blueVec[index] = null;
				_blueVec.splice(index, 1);
				
				
			}
		}
		private function onEnterFrame(e:Event):void
		{
			if(_redVec.length > 0 && _blueVec.length > 0)
			{
				var randomRedIndex:int = Util.rand(0, _redVec.length-1);
				var randomBlueIndex:int = Util.rand(0, _blueVec.length-1);
				var randomRedUnit:UIArmyUnit = _redVec[randomRedIndex];
				var randomBlueUnit:UIArmyUnit = _blueVec[randomBlueIndex];
				
				var rock:Rock = new Rock();
				addChild(rock);
				rock.x = randomRedUnit.x;
				rock.y = randomRedUnit.y;
				
				TweenLite.to(rock, 1, {x:randomBlueUnit.x, y:randomBlueUnit.y, onComplete:onComplete});
				function onComplete():void
				{
					rock.destruct();
					randomBlueUnit.decrementHp();
				}
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			
		}
	}
}