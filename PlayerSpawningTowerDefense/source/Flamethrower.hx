package;

import flixel.group.FlxGroup;

class Flamethrower extends ManualTower
{
    public function new(X:Float, Y:Float, Cost:Int)
	{
		super(X, Y, "assets/images/tower.png"); // TODO: Sprite
		
        setSize(32, 32);
		atkCd = 0;
        range = 96;
		/*_indicator = new FlxSprite(getMidpoint().x - 1, getMidpoint().y - 1);
		_indicator.makeGraphic(2, 2);
		Reg.PS.towerIndicators.add(_indicator);
		
		_initialCost = Cost;*/
	}

    override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
    
    /**
	 * Shoots a trail of flame!
	 */
	public override function shoot(bullets:FlxTypedGroup<Bullet>):Void
	{
		super.shoot(bullets);
	}
}
}