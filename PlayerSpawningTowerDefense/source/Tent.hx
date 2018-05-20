package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;

class Tent extends FlxSprite {
    public var set:Bool = false;
    public var healthBar:FlxBar;
    public var MAX_HEALTH:Float = 1000.0;

    public function new(?X:Float, ?Y:Float, hp:Float) {
        // Animation: Sword
        super(X, Y);
        this.health = hp;
        loadGraphic(AssetPaths.tent__png, true, 64, 64);
    }

    public function setup(X:Float, Y:Float) {
        this.x = X;
        this.y = Y;
        this.healthBar = new FlxBar(X, Y+64, LEFT_TO_RIGHT, 64, 4, this, "health", 0, health, true);
        healthBar.setRange(0, MAX_HEALTH);
        healthBar.createFilledBar(FlxColor.RED, FlxColor.GREEN, true, FlxColor.BLACK);
        healthBar.killOnEmpty = true;
    }

    public function getHealth():Float {
        return this.health;
    }

}
