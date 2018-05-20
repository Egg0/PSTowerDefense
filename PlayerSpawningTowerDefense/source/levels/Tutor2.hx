package levels;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxG;
class Tutor2 extends PlayState {

    // Single path, no equipment
    override public function create():Void {
        _map = new FlxOgmoLoader("assets/data/tutorial-002.oel");

        _player = new Player();
        _player.setEquipR("none");

        _tent = new Tent(0, 0, startingTentHP);
        _tent2 = new Tent(0, 0, startingTent2HP);

        //var text = new flixel.text.FlxText(0, 20, 0, "R-click: Shield", 20);
        //add(text);
        super.create();

        level_hud.setEquipLeft();
        level_hud.setWaveString("T2");
    }

    override function setPreLevelHUD():Void {
        super.setPreLevelHUD();
        hint = new OpenFlxText(30, FlxG.height - 40, 0, "Red enemies stop in their tracks and attack you when nearby!", 12);
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
        var l:Tutor3 = new Tutor3();
        l.tentHealth = _tent.getHealth();
        l.tent2Health = _tent2.getHealth();
        switchLevel(l, this);
    }

    override function clickReplay():Void {
        var l:Tutor2 = new Tutor2();
        restartLevel(l, this);
    }
}
