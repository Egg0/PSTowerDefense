package;
 
import openfl.text.Font;
import openfl.Assets;
 
class Fonts {
    public static var DEFAULT_FONT(default, null):String;
    public static function init():Void {
    #if js
        DEFAULT_FONT = Assets.getFont("fonts/LCD_Solid.ttf").fontName;
    #else
        Font.registerFont(DefaultFont);
        DEFAULT_FONT = (new DefaultFont()).fontName;
    #end
    }
}

@:font("assets/fonts/LCD_Solid.ttf")
class DefaultFont extends Font {
    
}