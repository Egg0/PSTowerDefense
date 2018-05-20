package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
    var _sprBack:FlxSprite;
    var _txtEquip:FlxText;
    var _sprMouse:FlxSprite;
    var _txtEquipL:FlxText;
    var _rectEquipL:FlxSprite;
    var _sprEquipL:FlxSprite;
    var _txtEquipR:FlxText;
    var _rectEquipR:FlxSprite;
    var _sprEquipR:FlxSprite;

    var _txtEnemies:FlxText;
    var _sprEtypeA:FlxSprite;
    var _txtEtypeA:FlxText;
    var _sprEtypeB:FlxSprite;
    var _txtEtypeB:FlxText;
    var _sprEtypeC:FlxSprite;
    var _txtEtypeC:FlxText;

    var enemy0Count:Int = -1;
    var enemy1Count:Int = -1;
    var enemy2Count:Int = -1;

    var typeToIndex:Map<Int, Int> = new Map<Int, Int>();

    var _txtWave:FlxText;
    var _currWave:Int = -1;
    var leftPos:Int;
    var rightPos:Int;

//    var _txtMoney:FlxText;
//    var _sprMoney:FlxSprite;

    public function new() {
        super();
        _sprBack = new FlxSprite().makeGraphic(FlxG.width, 45, FlxColor.BLACK);
        _sprBack.drawRect(0, 44, FlxG.width, 1, FlxColor.WHITE);

        _txtEquip = new OpenFlxText(8, 0, 0, "Equipped:", 10);
        _sprMouse = new FlxSprite(28, 16, AssetPaths.mouse__png);

        leftPos = cast(_txtEquip.fieldWidth, Int) + 18;
        _txtEquipL = new OpenFlxText(leftPos, 32, 0, "Left", 8);
        rightPos = leftPos + cast(_txtEquipL.fieldWidth, Int) + 12;
        _txtEquipR = new OpenFlxText(rightPos, 32, 0, "Right", 8);

        _rectEquipL = new FlxSprite(leftPos, 4).makeGraphic(24, 24, FlxColor.GRAY);
        _rectEquipL.drawRect(0, 0, 24, 1, FlxColor.WHITE);
        _rectEquipL.drawRect(0, 23, 24, 1, FlxColor.WHITE);
        _rectEquipL.drawRect(0, 0, 1, 24, FlxColor.WHITE);
        _rectEquipL.drawRect(23, 0, 1, 24, FlxColor.WHITE);

        _rectEquipR = new FlxSprite(rightPos, 4).makeGraphic(24, 24, FlxColor.GRAY);
        _rectEquipR.drawRect(0, 0, 24, 1, FlxColor.WHITE);
        _rectEquipR.drawRect(0, 23, 24, 1, FlxColor.WHITE);
        _rectEquipR.drawRect(0, 0, 1, 24, FlxColor.WHITE);
        _rectEquipR.drawRect(23, 0, 1, 24, FlxColor.WHITE);

        _txtEnemies = new OpenFlxText(200, 0, 0, "Enemies Remaining:", 8);

//        _txtMoney = new OpenFlxText(0, 2, 0, "0", 8);
//        _txtMoney.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
//        _sprMoney = new FlxSprite(FlxG.width - 12, _txtMoney.y + (_txtMoney.height/2)  - 4, AssetPaths.coin__png);
//        _txtMoney.alignment = RIGHT;
//        _txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
        add(_sprBack);
        add(_txtEquip);
        add(_sprMouse);
        add(_txtEquipL);
        add(_rectEquipL);
        add(_txtEquipR);
        add(_rectEquipR);
        add(_txtEnemies);

        forEach(function(spr:FlxSprite) {
            spr.scrollFactor.set(0, 0);
        });
    }

    public function updateHUD(Health:Int = 0, Money:Int = 0):Void {
//        _txtHealth.text = Std.string(Health) + " / 3";
//        _txtMoney.text = Std.string(Money);
//        _txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
    }

    public function setEquipLeft(equip:String = "sword"):Void {
        _sprEquipL = new FlxSprite(leftPos + 4, 8, "assets/images/" + equip + "-eqp.png");
        add(_sprEquipL);
        _sprEquipL.scrollFactor.set(0, 0);
    }

    public function setEquipRight(equip:String = "shield"):Void {
        _sprEquipR = new FlxSprite(rightPos + 4, 8, "assets/images/" + equip + "-eqp.png");
        add(_sprEquipR);
        _sprEquipR.scrollFactor.set(0, 0);
    }

    public function setEnemyA(type:String = "0", count:Int):Void {
        _sprEtypeA = new FlxSprite(175, 16, "assets/images/enemy" + type + ".png");
        _txtEtypeA = new OpenFlxText(200, 23, 0, "x" + count, 8);
        if (type == "0") {
            enemy0Count = count;
        } else if (type == "1") {
            enemy1Count = count;
        } else {
            enemy2Count = count;
        }
        add(_sprEtypeA);
        _sprEtypeA.scrollFactor.set(0, 0);
        add(_txtEtypeA);
        _txtEtypeA.scrollFactor.set(0, 0);

    }

    public function setEnemyB(type:String = "1", count:Int):Void {
        _sprEtypeB = new FlxSprite(220, 16, "assets/images/enemy" + type + ".png");
        _txtEtypeB = new OpenFlxText(245, 23, 0, "x" + count, 8);
        if (type == "0") {
            enemy0Count = count;
        } else if (type == "1") {
            enemy1Count = count;
        } else {
            enemy2Count = count;
        }
        add(_sprEtypeB);
        _sprEtypeB.scrollFactor.set(0, 0);
        add(_txtEtypeB);
        _txtEtypeB.scrollFactor.set(0, 0);
    }

    public function setEnemyC(type:String = "2", count:Int):Void {
        _sprEtypeC = new FlxSprite(265, 16, "assets/images/enemy" + type + ".png");
        _txtEtypeC = new OpenFlxText(290, 23, 0, "x" + count, 8);
        if (type == "0") {
            enemy0Count = count;
        } else if (type == "1") {
            enemy1Count = count;
        } else if (type == "2") {
            enemy2Count = count;
        }
        add(_sprEtypeC);
        _sprEtypeC.scrollFactor.set(0, 0);
        add(_txtEtypeC);
        _txtEtypeC.scrollFactor.set(0, 0);
    }

    public function decrementEnemy0() {
        enemy0Count--;
        _txtEtypeA.text = "x" + enemy0Count;
    }

    public function decrementEnemy1() {
        enemy1Count--;
        if (enemy0Count == -1) {
            _txtEtypeA.text = "x" + enemy1Count;
        } else {
            _txtEtypeB.text = "x" + enemy1Count;
        }
    }

    public function decrementEnemy2() {
        enemy2Count--;
        if (enemy0Count == -1) {
            _txtEtypeA.text = "x" + enemy2Count;
        } else if (enemy1Count == -1) {
            _txtEtypeB.text = "x" + enemy2Count;
        } else {
            _txtEtypeC.text = "x" + enemy2Count;
        }
    }

    public function setWaveString(wave:String) {
        _txtWave = new OpenFlxText(FlxG.width - 75, 10, 0, "Wave: " + wave, 10);
        add(_txtWave);
        _txtWave.scrollFactor.set(0, 0);
    }

    public function setWave(wave:Int) {
        _txtWave = new OpenFlxText(FlxG.width - 75, 10, 0, "Wave: " + wave, 10);
        _currWave = wave;
        add(_txtWave);
        _txtWave.scrollFactor.set(0, 0);
    }

    public function incrementWave() {
        _currWave++;
        _txtWave.text = "Wave: " + _currWave;
    }
}