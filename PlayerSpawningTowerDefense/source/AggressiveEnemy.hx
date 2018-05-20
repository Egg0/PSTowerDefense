package;

import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;

class AggressiveEnemy extends Enemy
{
    public function new(X:Float=0, Y:Float=0, health:Float, speed:Float)
    {
        super(X, Y, health, speed);
        isAggressive = true;
        type = 1; // Aggressive enemy type
        // Animation Stuff: Enemy PLACEHOLDER
        loadGraphic(AssetPaths.enemy__png, true, 32, 32);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        animation.add("d", [9, 10], 4, true);
        animation.add("lr", [11, 12], 4, true);
        animation.add("u", [13, 14], 4, true);
        animation.add("atk_d", [15, 9], 2, true);
        animation.add("atk_lr", [16, 12], 2, true);
        animation.add("atk_u", [17, 13], 2, true);
    }
    
    override public function update(elapsed:Float):Void
    {
        //chase();
        //draw();
        if (this.atkCd > 0)
            this.atkCd--;
        aggroLogic();
        super.update(elapsed);
    }

    

    private function aggroLogic():Void {
        if (playerInRange) {
            // Stop in place
            this.path.active = false;
            // Fire at player.
            this.isFiring = true;
        }
        else {
            this.path.active = true;
            this.isFiring = false;
        }
    }

    /**
	 * Start this enemy on a path, as represented by an array of FlxPoints. Updates position to the first node
	 * and then uses FlxPath.start() to set this enemy on the path. Speed is determined by wave number, unless
	 * in the menu, in which case it's arbitrary.
	 */
	public override function followPath(Path:Array<FlxPoint>, ?OnComplete:FlxPath->Void):Void
	{
		if (Path == null)
			throw("No valid path was passed to the enemy! Does the tilemap provide a valid path from start to finish?");
		
		Path[0].x = x;
		Path[0].y = y;
		
		path = new FlxPath().start(Path, speed, FlxPath.FORWARD, false);
		path.onComplete = OnComplete;
	}

    override public function draw():Void
    {
        if ((velocity.x != 0 || velocity.y != 0 ) && touching == FlxObject.NONE)
        {
            if (Math.abs(velocity.x) > Math.abs(velocity.y))
            {
                if (velocity.x < 0)
                    facing = FlxObject.LEFT;
                else
                    facing = FlxObject.RIGHT;
            }
            else
            {
                if (velocity.y < 0)
                    facing = FlxObject.UP;
                else
                    facing = FlxObject.DOWN;
            }
            switch (facing)
            {
                case FlxObject.LEFT, FlxObject.RIGHT:
                    animation.play("lr");
                case FlxObject.UP:
                    animation.play("u");
                case FlxObject.DOWN:
                    animation.play("d");
            }
        }
        super.draw();
    }
}