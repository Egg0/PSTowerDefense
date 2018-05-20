package;

import flixel.FlxObject;

class SneakyEnemy extends Enemy
{

    public function new(X:Float=0, Y:Float=0, health:Float, speed:Float)
    {
        super(X, Y, health, speed);
        isSneaky = true;
        type = 2; // Sneaky enemy type
        // Animation Stuff: Enemy PLACEHOLDER
        loadGraphic(AssetPaths.enemy__png, true, 32, 32);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        animation.add("d", [18, 19], 4, true);
        animation.add("lr", [20, 21], 4, true);
        animation.add("u", [22, 23], 4, true);
        animation.add("atk_d", [24, 18], 2, true);
        animation.add("atk_lr", [25, 21], 2, true);
        animation.add("atk_u", [17, 22], 2, true);
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}