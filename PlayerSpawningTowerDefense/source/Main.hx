package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var LOGGER:CapstoneLogger;
	public function new()
	{
		super();
		#if js
		untyped {
			document.oncontextmenu = document.body.oncontextmenu = function() {return false;}
		}
		#end

		var gameId:Int = 1805;
		var gameKey:String = "896adc9a6a0b3b87e01fa1bc31474ba5";
		var gameName:String = "pstower";
		var categoryId:Int = 2; // 1 = debug, 2 = friends, 3 = public
		var useDev:Bool = true;
		Main.LOGGER = new CapstoneLogger(gameId, gameName, gameKey, categoryId, useDev);

		// Retrieve user
		var userId:String = Main.LOGGER.getSavedUserId();
		if (userId == null) {
			userId = Main.LOGGER.generateUuid();
			Main.LOGGER.setSavedUserId(userId);
		}
		Main.LOGGER.startNewSession(userId, this.onSessionReady);
	}

	private function onSessionReady(sessionRecieved:Bool):Void {
		addChild(new FlxGame(480, 360, MenuState, true));
	}
}
