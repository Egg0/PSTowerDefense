package;

import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import levels.Tutor1;
import levels.Tutor4;
import levels.Tutor8;

class MenuState extends FlxState
{
    private var _btnPlay:FlxButton;
    private var status:String;

    public function new(status:String = null)
    {
        super();

        this.status = status;
    }


    override public function create():Void
    {
        _btnPlay = new FlxButton(0, 0, "Play", clickPlay);
        _btnPlay.screenCenter();
        add(_btnPlay);
        var text = new OpenFlxText(0, 0, 0, "Tower Defense Immersion: Demo 2", 16);
        add(text);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    private function clickPlay():Void
    {
        FlxG.switchState(new Tutor1());
    }
}
