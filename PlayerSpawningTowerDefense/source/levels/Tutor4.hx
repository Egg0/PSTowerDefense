package levels;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
class Tutor4 extends PlayState {
    public var _sprPurchase:FlxSprite;
    public var _txtPurchase:FlxText;
    public var _sprMouse:FlxSprite;
    public var _txtMouse:FlxText;

    // Single path, no equipment
    override public function create():Void {
        _map = new FlxOgmoLoader("assets/data/tutorial-004.oel");

        _player = new Player();
        _player.setEquipR("none");

        _tent = new Tent(0, 0, startingTentHP);
        _tent2 = new Tent(0, 0, startingTent2HP);
        super.create();

        level_hud.setEquipLeft();
        level_hud.setWaveString("T4");
    }

    override function setPreLevelHUD():Void {
        super.setPreLevelHUD();
        _sprPurchase = new FlxSprite(FlxG.width / 3, 64, "assets/images/mouse-tooltip-purchase.png");
        add(_sprPurchase);
        _sprPurchase.scrollFactor.set(0, 0);

        _txtPurchase = new OpenFlxText(FlxG.width / 3, 196, "Purchase Tower", 12);
//        _txtPurchase.color = 0xd3d3d3;
        add(_txtPurchase);
        _txtPurchase.scrollFactor.set(0, 0);

        hint = new OpenFlxText(30, FlxG.height - 40, 0, "Towers will automatically shoot nearby enemies!", 12);
        add(hint);
        hint.scrollFactor.set(0, 0);
    }

    override function purchaseBasicTower():Void {
        _sprPurchase.destroy();
        _txtPurchase.destroy();

        _sprMouse = new FlxSprite(FlxG.width / 3, 64, "assets/images/mouse-tooltip-tower.png");
        add(_sprMouse);
        _sprMouse.scrollFactor.set(0, 0);

        _txtMouse = new OpenFlxText(FlxG.width / 3, 196, "Place Tower", 12);
//        _txtMouse.color = 0xd3d3d3;
        add(_txtMouse);
        _txtMouse.scrollFactor.set(0, 0);
        super.purchaseBasicTower();
    }

    override private function setPlayButton():Void {
        _sprMouse.kill();
        _txtMouse.kill();
        super.setPlayButton();
    }

    override function checkSuccess():Void {
        if (_numEnemies == 0) {
            super.checkSuccess();
            _done = true;
            var _btnPlay:FlxButton = new FlxButton(0, 0, "Next Level", clickNextLevel);
            _btnPlay.screenCenter();
            add(_btnPlay);
        }
    }

    private function clickNextLevel():Void {
        var l:Tutor5 = new Tutor5();
        l.tentHealth = _tent.getHealth();
        l.tent2Health = _tent2.getHealth();
        switchLevel(l, this);
    }

    override function clickReplay():Void {
        var l:Tutor4 = new Tutor4();
        restartLevel(l, this);
    }
}
