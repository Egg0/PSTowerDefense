package;

import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.ui.FlxBar;

class Enemy extends FlxSprite
{
    public var speed:Float;
    public var playerInRange:Bool;
    public var isAggressive:Bool;
    public var isSneaky:Bool;
    public var type:Int;

    public var swordHit:Bool;
    public var isFiring:Bool;
    public var atkCd:Int;
    private var CD:Int = 30;

    public var healthBar:FlxBar;

    public function new(X:Float=0, Y:Float=0, health:Float, speed:Float)
    {
        super(X, Y);
        this.health = health;
        this.speed = speed;
        this.healthBar = new FlxBar(X, Y, LEFT_TO_RIGHT, 32, 2, this, "health", 0, health);
        healthBar.fixedPosition = false;
        healthBar.createFilledBar(FlxColor.RED, FlxColor.GREEN);
        healthBar.trackParent(0, 32);
        healthBar.killOnEmpty = true;

        drag.x = drag.y = 1600;
        isFiring = false;
        atkCd = 0;
        playerInRange = false;
        setSize(16, 30);
        isAggressive = false;
        isSneaky = false;
        type = 0; // Default enemy type

        // Animation Stuff: Enemy PLACEHOLDER
        loadGraphic(AssetPaths.enemy__png, true, 32, 32);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        animation.add("d", [0, 1], 4, true);
        animation.add("lr", [2, 3], 4, true);
        animation.add("u", [4, 5], 4, true);
        animation.add("atk_d", [6], 2, true);
        animation.add("atk_lr", [7], 2, true);
        animation.add("atk_u", [8], 2, true);
    }
    
    override public function update(elapsed:Float):Void
    {
        //chase();
        //draw();
        super.update(elapsed);
    }

    public function canFire():Bool {
        return this.atkCd == 0 && playerInRange && isAggressive;
    }

    public function fire():Void {
        this.atkCd += CD;
        switch (facing){
            case FlxObject.LEFT, FlxObject.RIGHT:
                animation.play("atk_lr");
            case FlxObject.UP:
                animation.play("atk_u");
            case FlxObject.DOWN:
                animation.play("atk_d");
        }
    }

    /**
	 * Start this enemy on a path, as represented by an array of FlxPoints. Updates position to the first node
	 * and then uses FlxPath.start() to set this enemy on the path. Speed is determined by wave number, unless
	 * in the menu, in which case it's arbitrary.
	 */
	public function followPath(Path:Array<FlxPoint>, ?OnComplete:FlxPath->Void):Void
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

    /**
        Will return true if this is a killing hit
    **/
    public function hurtEnemy(damage:Float, isSword:Bool):Bool {
        if (swordHit && isSword)
            return false;
        hurt(damage);
        if (isSword)
            swordHit = true;
        if (this.health <= 0) {
            this.kill();
            return true;
        }
        return false;
    }
}