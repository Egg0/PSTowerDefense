package levels;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
class Tutor6 extends PlayState {

    // Single path, no equipment
    override public function create():Void {
        _map = new FlxOgmoLoader("assets/data/tutorial-006.oel");

        _player = new Player();
        _player.setEquipR("shield");

        _tent = new Tent(0, 0, startingTentHP);
        _tent2 = new Tent(0, 0, startingTent2HP);
        super.create();

        level_hud.setEquipLeft();
        level_hud.setEquipRight();
        level_hud.setWaveString("T6");
    }

    override function setPreLevelHUD():Void {
        super.setPreLevelHUD();
        hint = new OpenFlxText(30, FlxG.height - 40, 0, "Multiple enemy types! Try an upgrade!", 12);
        add(hint);
        hint.scrollFactor.set(0, 0);
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
        var l:Tutor7 = new Tutor7();
        l.tentHealth = _tent.getHealth();
        l.tent2Health = _tent2.getHealth();
        switchLevel(l, this);
    }

    override function clickReplay():Void {
        var l:Tutor6 = new Tutor6();
        restartLevel(l, this);
    }
}
