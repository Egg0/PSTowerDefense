package ;


import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;

class Shield extends FlxSprite {
    private var _speed:Float;

    public function new(?X:Float, ?Y:Float, dir:String, speed:Float) {
        super(X, Y);
        drag.x = drag.y = 1600;
        _speed = speed;
        loadGraphic(AssetPaths.shield__png, true, 16, 16);

        animation.add("u", [0], 1, false);
        animation.add("d", [1], 1, false);
        animation.add("l", [2], 1, false);
        animation.add("r", [3], 1, false);

        animation.play(dir);
        animation.stop();
    }

    // Use Player's movement function without rotation
    private function movement():Void {
        var _up = FlxG.keys.anyPressed([UP, W]);
        var _down = FlxG.keys.anyPressed([DOWN, S]);
        var _left = FlxG.keys.anyPressed([LEFT, A]);
        var _right = FlxG.keys.anyPressed([RIGHT, D]);

        if (_up && _down)
            _up = _down = false;
        if (_left && _right)
            _left = _right = false;

        if (_up || _down || _left || _right) {
            var mA:Float = 0.0;
            if (_left) {
                mA = 180;
                if (_up) {
                    mA = -mA + 45;
                } else if (_down) {
                    mA -= 45;
                }
            } else if (_right) {
                mA = 0;
                if (_up) {
                    mA -= 45;
                } else if (_down) {
                    mA += 45;
                }
            } else if (_up) {
                mA = -90;
            }
            else if (_down) {
                mA = 90;
            } else {
                velocity.set(0, 0);
                return;
            }

            velocity.set(_speed, 0);
            velocity.rotate(FlxPoint.weak(0, 0), mA);
        }
    }
    override public function update(elapsed:Float):Void {
        movement();
        super.update(elapsed);
    }
}
