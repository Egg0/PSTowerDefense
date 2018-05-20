package levels;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
class Tutor9 extends PlayState {

    override public function create():Void {
        _map = new FlxOgmoLoader("assets/data/tutorial-008.oel");

        _player = new Player();
        _player.setEquipR("shield");

        _tent = new Tent(0, 0, startingTentHP);
        _tent2 = new Tent(0, 0, startingTent2HP);
        super.create();

        level_hud.setEquipLeft();
        level_hud.setEquipRight();
        level_hud.setWaveString("T9");
    }

    override function setPreLevelHUD():Void {
        super.setPreLevelHUD();
        hint = new OpenFlxText(30, FlxG.height - 40, 0, "Gray enemies sneak right past towers!", 12);
        add(hint);
        hint.scrollFactor.set(0, 0);
    }

    override function checkSuccess():Void {
        if (_numEnemies == 0) {
            super.checkSuccess();
            _done = true;
            var _btnPlay:FlxButton = new FlxButton(0, 0, "Back to menu", clickNextLevel);
            _btnPlay.screenCenter();
            add(_btnPlay);
        }
    }

    private function clickNextLevel():Void {
        FlxG.switchState(new MenuState());
    }

    override function clickReplay():Void {
        var l:Tutor9 = new Tutor9();
        restartLevel(l, this);
    }
}
