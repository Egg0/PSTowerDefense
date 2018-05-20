package levels;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;

class Tutor1 extends PlayState {

    // Single path, no equipment
    override public function create():Void {
        _map = new FlxOgmoLoader("assets/data/tutorial-001.oel");

        _player = new Player();
        _player.setEquipR("none");

        _tent = new Tent(0, 0, 1000.0);
        _tent2 = new Tent(0, 0, 1000.0);
        super.create();

        level_hud.setEquipLeft();
        level_hud.setWaveString("T1");
        _buildingMode = true;
        pstats = new PlayerStats();
    }

    override function setPreLevelHUD():Void {
        super.setPreLevelHUD();
        hint = new OpenFlxText(30, FlxG.height - 40, 0, "Welcome to tower defense! Click to begin the wave.", 12);
        add(hint);
        hint.scrollFactor.set(0, 0);
    }

    override function setLevelHUD():Void {
        super.setLevelHUD();
        var _sprKeys = new FlxSprite(FlxG.width / 4 - 25, 3 * FlxG.height / 4, "assets/images/keys-tooltip.png");
        add(_sprKeys);
        _sprKeys.scrollFactor.set(0, 0);
        var _sprMouse = new FlxSprite(3 * FlxG.width / 4 - 25, 3 * FlxG.height / 4, "assets/images/mouse-tooltip.png");
        add(_sprMouse);
        _sprMouse.scrollFactor.set(0, 0);
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
        var l:Tutor9 = new Tutor9();
        l.tentHealth = _tent.getHealth();
        l.tent2Health = _tent2.getHealth();
        switchLevel(l, this);
    }

    override function clickReplay():Void {
        var l:Tutor1 = new Tutor1();
        restartLevel(l, this);
    }
}
