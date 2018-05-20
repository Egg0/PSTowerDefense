package ;

import flixel.FlxSprite;

class Sword extends FlxSprite {
    private var done:Bool;
    public function new(?X:Float, ?Y:Float, dir:String) {
        // Animation: Sword
        super(X, Y);
        
        loadGraphic(AssetPaths.sword__png, true, 41, 41);
        setSize(36, 36);
        animation.add("u", [0, 1, 2, 3, 4], 20, false);
        animation.add("r", [2, 3, 4, 5, 6], 20, false);
        animation.add("d", [4, 5, 6, 7, 0], 20, false);
        animation.add("l", [6, 7, 0, 1, 2], 20, false);

        animation.play(dir);
        animation.finishCallback = clearSword;
    }

    private function clearSword(_anim_name: String) {
        done = true;
    }

    public function isDone():Bool {
        return done;
    }

}
