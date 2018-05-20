package levels;
import flixel.text.FlxText;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
class Tutor5 extends PlayState {

    // Single path, no equipment
    override public function create():Void {
        _map = new FlxOgmoLoader("assets/data/tutorial-005.oel");

        _player = new Player();
        _player.setEquipR("shield");

         _tent = new Tent(0, 0, startingTentHP);
        _tent2 = new Tent(0, 0, startingTent2HP);
        super.create();

        level_hud.setEquipLeft();
        level_hud.setEquipRight();
        level_hud.setWaveString("T5");
    }

    override function setPreLevelHUD():Void {
        super.setPreLevelHUD();
        hint = new OpenFlxText(30, FlxG.height - 40, 0, "Hold R-Click to shield enemy attacks!", 12);
        add(hint);
        hint.scrollFactor.set(0, 0);
    }

    override function clearPreLevelHUD():Void {
        hint.destroy();
        super.clearPreLevelHUD();
    }

    override function setLevelHUD():Void {
        var _sprMouse = new FlxSprite(FlxG.width / 2  - 48, 3 * FlxG.height / 4, "assets/images/mouse-tooltip-shield.png");
        add(_sprMouse);
        _sprMouse.scrollFactor.set(0, 0);
        var hint2:FlxText = new OpenFlxText(256, 192, 0, "Hold shield here!", 8);
        add(hint2);
        super.setLevelHUD();
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
        var l:Tutor6 = new Tutor6();
        l.tentHealth = _tent.getHealth();
        l.tent2Health = _tent2.getHealth();
        switchLevel(l, this);
    }

    override function clickReplay():Void {
        var l:Tutor5 = new Tutor5();
        restartLevel(l, this);
    }
}
