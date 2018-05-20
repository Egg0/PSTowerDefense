package;

import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;

class Player extends FlxSprite {
    public var speed:Float = 200;

    // Directions
    var _up:Bool = false;
    var _down:Bool = false;
    var _left:Bool = false;
    var _right:Bool = false;
    var lastDir = 3; // 0 = up, 1 = down, 2 = left, 3 = right

    // Status
    public var healthBar:FlxBar;
    var _attacking:Bool = false;
    public var shielding:Bool = false;

    // Equipment (Add equipL once we add more weapons)
    var _equipR:String = "shield"; //shield, none

    public function new(?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        drag.x = drag.y = 1600;
        setSize(16, 30);
        health = 1000.0;

        // Animation Stuff: Player
        loadGraphic(AssetPaths.player__png, true, 32, 32);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        animation.add("d", [0, 1, 2, 3], 16, false);
        animation.add("lr", [4, 5, 6, 7], 16, false);
        animation.add("u", [8, 9, 10, 11], 16, false);
        animation.add("atk_d", [12], 4, false);
        animation.add("atk_lr", [13], 4, false);
        animation.add("atk_u", [14], 4, false);

        this.healthBar = new FlxBar(X, Y, LEFT_TO_RIGHT, 32, 4, this, "health", 0, health, true);
        healthBar.fixedPosition = false;
        healthBar.createFilledBar(FlxColor.RED, FlxColor.GREEN, true, FlxColor.BLACK);
        healthBar.trackParent(0, 32);
        healthBar.killOnEmpty = true;
    }

    public function getDir() {
        switch (lastDir) {
            case 0: return "u";
            case 1: return "d";
            case 2: return "l";
            default: return "r";
        }
    }

    public function getEquipR():String {
        return _equipR;
    }

    public function setEquipR(newEquip:String):Void {
        this._equipR = newEquip;
    }

    private function movement(currSpeed:Float, setFacing:Bool):Void {
        _up = FlxG.keys.anyPressed([UP, W]);
        _down = FlxG.keys.anyPressed([DOWN, S]);
        _left = FlxG.keys.anyPressed([LEFT, A]);
        _right = FlxG.keys.anyPressed([RIGHT, D]);

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
                if(setFacing) facing = FlxObject.LEFT;
            } else if (_right) {
                mA = 0;
                if (_up) {
                    mA -= 45;
                } else if (_down) {
                    mA += 45;
                }
                if(setFacing) facing = FlxObject.RIGHT;
            } else if (_up) {
                mA = -90;
                if(setFacing) facing = FlxObject.UP;
            }
            else if (_down) {
                mA = 90;
                if(setFacing) facing = FlxObject.DOWN;
            }

            velocity.set(currSpeed, 0);
            velocity.rotate(FlxPoint.weak(0, 0), mA);

            if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {
                switch (facing) {
                    case FlxObject.LEFT, FlxObject.RIGHT:
                        animation.play("lr");
                    case FlxObject.UP:
                        animation.play("u");
                    case FlxObject.DOWN:
                        animation.play("d");
                }
            }
        // Not pressing any key and not attacking: Stop the animation
        } else if (!_attacking){
            animation.reset();
        }
    }

    private function attack():Void {
        _attacking = true;
        setActionDirection();
        animation.finishCallback = attackOver;
    }


    // Callback function to return to idle once attack is over
    private function attackOver(_anim_name: String) {
        _attacking = false;
        if (_anim_name.substr(0, 3) == "atk")  {
            if (lastDir == 0) {
                animation.play("u");
            } else if (lastDir == 1) {
                animation.play("d");
            } else {
                animation.play("lr");
            }
            animation.reset();
        }
    }

    private function setActionDirection() {
        if (facing == FlxObject.UP) {
            animation.play("atk_u");
            lastDir = 0;
        } else if (facing == FlxObject.DOWN) {
            lastDir = 1;
            animation.play("atk_d");
        } else if (facing == FlxObject.LEFT || facing == FlxObject.RIGHT) {
            if (facing == FlxObject.LEFT) {
                lastDir = 2;
            } else {
                lastDir = 3;
            }
            animation.play("atk_lr");
        }
    }

    override public function update(elapsed:Float):Void {
        // Only do anything if not attacking
        if (!_attacking) {
            // Shield while right click pressed
            if ((FlxG.mouse.pressedRight || FlxG.keys.pressed.PERIOD) && _equipR == "shield") {
                movement(speed / 4, false);
                setActionDirection();
                animation.stop();
            // Otherwise regular movement, or try to attack
            } else {
                movement(speed, true);
                if (FlxG.mouse.justPressed || FlxG.keys.justPressed.COMMA)
                    attack();
            }
        }

        super.update(elapsed);
    }

    public function hit(damage:Float):Bool {
        if (shielding)
            return false;

        hurt(damage);
        if (this.health <= 0)
            return true;

        return false;
    }
}