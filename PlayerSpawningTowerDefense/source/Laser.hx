package;

import flixel.FlxSprite;

class Laser extends FlxSprite 
{

    public var life:Int;
	
	public function new() 
	{
		super();
		#if flash
		blend = BlendMode.INVERT;
		#end
	}
	
	/**
	 * Initialize this bullet by giving it a position, target, and damage amount. Usually used to create a new bullet as it is fired by a tower.
	 * 
	 * @param	X			The desired X position.
	 * @param	Y			The desired Y position.
	 * @param	Target		The desired target, an Enemy.
	 * @param	Damage		The amount of damage this bullet can do, usually determined by the upgrade level of the tower.
	 */
	public function init(X:Float, Y:Float, isHorizontal:Bool):Void
	{
		life = 40;
		loadGraphic("assets/images/laser.png");
        if (isHorizontal) {
            reset(X - PlayState.TILE_SIZE / 8 - 1024, Y - PlayState.TILE_SIZE / 8);
            setGraphicSize(2048, 8);
        }
        else {
            reset(X - PlayState.TILE_SIZE / 8, Y - PlayState.TILE_SIZE / 8 - 1024);
            setGraphicSize(8, 2048);
        }
        updateHitbox();
	}
	
	override public function update(elapsed:Float):Void
	{
		// This bullet missed its target and flew off-screen; no reason to keep it around.
		
		// Move toward the target that was assigned in init().
		
		life--;
        if (life < 0) 
            kill();
		
		super.update(elapsed);
	}
}