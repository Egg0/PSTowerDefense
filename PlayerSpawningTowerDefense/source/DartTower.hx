package;

class DartTower extends Tower
{
	
	/**
	 * Create a new tower at X and Y with default range, fire rate, and damage; create this tower's indicator.
	 */
	public function new(X:Float, Y:Float)
	{
		super(X, Y, "", 1);
		
//        setSize(32, 32);
//        targetedEnemy = null;
//		atkCd = 0;
        pierces = true;
		/*_indicator = new FlxSprite(getMidpoint().x - 1, getMidpoint().y - 1);
		_indicator.makeGraphic(2, 2);
		Reg.PS.towerIndicators.add(_indicator);
		
		_initialCost = Cost;*/
	}
	
	/**
	 * The tower's update function just checks if there's an enemy nearby; if so, the indicator "charges"
	 * by slowly increasing its alpha; once the shootCounter has reached the required level, a bullet is
	 * shot.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
