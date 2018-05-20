package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

class LaserTower extends FlxSprite
{
	public var atkCd:Int;
    public var CD:Int = 90;
    public function new(X:Float, Y:Float, path:String)
	{
		super(X, Y, "assets/images/tower.png"); // TODO: Sprite
		
        setSize(32, 32);
		atkCd = 0;
	}

    public override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (atkCd > 0)
            atkCd--;
	}

    public function shoot(lasers:FlxTypedGroup<Laser>):Void
	{
		if (atkCd != 0)
			return;
		var laser = lasers.recycle(Laser.new);
		var laser2 = lasers.recycle(Laser.new);
		var midpoint = getMidpoint();
		laser.init(midpoint.x, midpoint.y, true);
		laser2.init(midpoint.x, midpoint.y, false);
		midpoint.put();
		lasers.add(laser);
		lasers.add(laser2);
		
		atkCd += CD;
	}
}