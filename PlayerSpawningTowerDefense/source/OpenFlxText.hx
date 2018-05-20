package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
class OpenFlxText extends FlxText {
    /*public function new(?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        this.setFormat(GLOBAL_FONT);
    }*/

    public function new(?X:Float=0, ?Y:Float=0, ?FieldWidth:Float, Text:String, Size:Int) {
        super(X, Y, FieldWidth, Text, Size, true);
        this.setFormat(Fonts.DEFAULT_FONT, Size, FlxColor.WHITE, null, null, null, true);
        this.borderSize = 0;
        this.antialiasing = false;
    }
}