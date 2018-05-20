package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/debug_curvy.oel", "assets/data/debug_curvy.oel");
			type.set ("assets/data/debug_curvy.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/debug_vertical.oel", "assets/data/debug_vertical.oel");
			type.set ("assets/data/debug_vertical.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/towerdefense.oep", "assets/data/towerdefense.oep");
			type.set ("assets/data/towerdefense.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tutorial-001.oel", "assets/data/tutorial-001.oel");
			type.set ("assets/data/tutorial-001.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tutorial-002.oel", "assets/data/tutorial-002.oel");
			type.set ("assets/data/tutorial-002.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tutorial-003.oel", "assets/data/tutorial-003.oel");
			type.set ("assets/data/tutorial-003.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tutorial-004.oel", "assets/data/tutorial-004.oel");
			type.set ("assets/data/tutorial-004.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tutorial-005.oel", "assets/data/tutorial-005.oel");
			type.set ("assets/data/tutorial-005.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tutorial-006.oel", "assets/data/tutorial-006.oel");
			type.set ("assets/data/tutorial-006.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tutorial-007.oel", "assets/data/tutorial-007.oel");
			type.set ("assets/data/tutorial-007.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tutorial-008.oel", "assets/data/tutorial-008.oel");
			type.set ("assets/data/tutorial-008.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/fonts/LCD_Solid.ttf", "assets/fonts/LCD_Solid.ttf");
			type.set ("assets/fonts/LCD_Solid.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/fonts/VISITOR.FON", "assets/fonts/VISITOR.FON");
			type.set ("assets/fonts/VISITOR.FON", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/fonts/visitor.txt", "assets/fonts/visitor.txt");
			type.set ("assets/fonts/visitor.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/fonts/visitor1.ttf", "assets/fonts/visitor1.ttf");
			type.set ("assets/fonts/visitor1.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/fonts/visitor2.ttf", "assets/fonts/visitor2.ttf");
			type.set ("assets/fonts/visitor2.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/images/bow.png", "assets/images/bow.png");
			type.set ("assets/images/bow.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/bullet.png", "assets/images/bullet.png");
			type.set ("assets/images/bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/checker.png", "assets/images/checker.png");
			type.set ("assets/images/checker.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy.png", "assets/images/enemy.png");
			type.set ("assets/images/enemy.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy0.png", "assets/images/enemy0.png");
			type.set ("assets/images/enemy0.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy1.png", "assets/images/enemy1.png");
			type.set ("assets/images/enemy1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/enemy2.png", "assets/images/enemy2.png");
			type.set ("assets/images/enemy2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/grass-tileset.png", "assets/images/grass-tileset.png");
			type.set ("assets/images/grass-tileset.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/keys-tooltip.png", "assets/images/keys-tooltip.png");
			type.set ("assets/images/keys-tooltip.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/laser.png", "assets/images/laser.png");
			type.set ("assets/images/laser.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/mouse-tooltip-purchase.png", "assets/images/mouse-tooltip-purchase.png");
			type.set ("assets/images/mouse-tooltip-purchase.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/mouse-tooltip-shield.png", "assets/images/mouse-tooltip-shield.png");
			type.set ("assets/images/mouse-tooltip-shield.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/mouse-tooltip-tower.png", "assets/images/mouse-tooltip-tower.png");
			type.set ("assets/images/mouse-tooltip-tower.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/mouse-tooltip.png", "assets/images/mouse-tooltip.png");
			type.set ("assets/images/mouse-tooltip.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/mouse.png", "assets/images/mouse.png");
			type.set ("assets/images/mouse.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player.png", "assets/images/player.png");
			type.set ("assets/images/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/shield-eqp.png", "assets/images/shield-eqp.png");
			type.set ("assets/images/shield-eqp.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/shield.png", "assets/images/shield.png");
			type.set ("assets/images/shield.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/sword-eqp.png", "assets/images/sword-eqp.png");
			type.set ("assets/images/sword-eqp.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/sword.png", "assets/images/sword.png");
			type.set ("assets/images/sword.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tent.png", "assets/images/tent.png");
			type.set ("assets/images/tent.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tower_0.png", "assets/images/tower_0.png");
			type.set ("assets/images/tower_0.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tower_0_btn.pdn", "assets/images/tower_0_btn.pdn");
			type.set ("assets/images/tower_0_btn.pdn", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/tower_0_btn.png", "assets/images/tower_0_btn.png");
			type.set ("assets/images/tower_0_btn.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tower_1.png", "assets/images/tower_1.png");
			type.set ("assets/images/tower_1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tower_1_btn.png", "assets/images/tower_1_btn.png");
			type.set ("assets/images/tower_1_btn.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tower_icon_-1.png", "assets/images/tower_icon_-1.png");
			type.set ("assets/images/tower_icon_-1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tower_icon_0.png", "assets/images/tower_icon_0.png");
			type.set ("assets/images/tower_icon_0.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tower_icon_1.png", "assets/images/tower_icon_1.png");
			type.set ("assets/images/tower_icon_1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tower_select_outline.png", "assets/images/tower_select_outline.png");
			type.set ("assets/images/tower_select_outline.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
