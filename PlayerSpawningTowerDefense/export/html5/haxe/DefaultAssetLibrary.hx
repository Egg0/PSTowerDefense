package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Future;
import lime.app.Preloader;
import lime.app.Promise;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.net.HTTPRequest;
import lime.system.CFFI;
import lime.text.Font;
import lime.utils.Bytes;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if (openfl && !flash)
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_lcd_solid_ttf);
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_visitor1_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_visitor2_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_lcd_solid_ttf);
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_visitor1_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_visitor2_ttf);
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		
		
		#end
		
		#if flash
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/debug_curvy.oel", __ASSET__assets_data_debug_curvy_oel);
		type.set ("assets/data/debug_curvy.oel", AssetType.TEXT);
		className.set ("assets/data/debug_vertical.oel", __ASSET__assets_data_debug_vertical_oel);
		type.set ("assets/data/debug_vertical.oel", AssetType.TEXT);
		className.set ("assets/data/towerdefense.oep", __ASSET__assets_data_towerdefense_oep);
		type.set ("assets/data/towerdefense.oep", AssetType.TEXT);
		className.set ("assets/data/tutorial-001.oel", __ASSET__assets_data_tutorial_001_oel);
		type.set ("assets/data/tutorial-001.oel", AssetType.TEXT);
		className.set ("assets/data/tutorial-002.oel", __ASSET__assets_data_tutorial_002_oel);
		type.set ("assets/data/tutorial-002.oel", AssetType.TEXT);
		className.set ("assets/data/tutorial-003.oel", __ASSET__assets_data_tutorial_003_oel);
		type.set ("assets/data/tutorial-003.oel", AssetType.TEXT);
		className.set ("assets/data/tutorial-004.oel", __ASSET__assets_data_tutorial_004_oel);
		type.set ("assets/data/tutorial-004.oel", AssetType.TEXT);
		className.set ("assets/data/tutorial-005.oel", __ASSET__assets_data_tutorial_005_oel);
		type.set ("assets/data/tutorial-005.oel", AssetType.TEXT);
		className.set ("assets/data/tutorial-006.oel", __ASSET__assets_data_tutorial_006_oel);
		type.set ("assets/data/tutorial-006.oel", AssetType.TEXT);
		className.set ("assets/data/tutorial-007.oel", __ASSET__assets_data_tutorial_007_oel);
		type.set ("assets/data/tutorial-007.oel", AssetType.TEXT);
		className.set ("assets/data/tutorial-008.oel", __ASSET__assets_data_tutorial_008_oel);
		type.set ("assets/data/tutorial-008.oel", AssetType.TEXT);
		className.set ("assets/fonts/LCD_Solid.ttf", __ASSET__assets_fonts_lcd_solid_ttf);
		type.set ("assets/fonts/LCD_Solid.ttf", AssetType.FONT);
		className.set ("assets/fonts/VISITOR.FON", __ASSET__assets_fonts_visitor_fon);
		type.set ("assets/fonts/VISITOR.FON", AssetType.BINARY);
		className.set ("assets/fonts/visitor.txt", __ASSET__assets_fonts_visitor_txt);
		type.set ("assets/fonts/visitor.txt", AssetType.TEXT);
		className.set ("assets/fonts/visitor1.ttf", __ASSET__assets_fonts_visitor1_ttf);
		type.set ("assets/fonts/visitor1.ttf", AssetType.FONT);
		className.set ("assets/fonts/visitor2.ttf", __ASSET__assets_fonts_visitor2_ttf);
		type.set ("assets/fonts/visitor2.ttf", AssetType.FONT);
		className.set ("assets/images/bow.png", __ASSET__assets_images_bow_png);
		type.set ("assets/images/bow.png", AssetType.IMAGE);
		className.set ("assets/images/bullet.png", __ASSET__assets_images_bullet_png);
		type.set ("assets/images/bullet.png", AssetType.IMAGE);
		className.set ("assets/images/checker.png", __ASSET__assets_images_checker_png);
		type.set ("assets/images/checker.png", AssetType.IMAGE);
		className.set ("assets/images/enemy.png", __ASSET__assets_images_enemy_png);
		type.set ("assets/images/enemy.png", AssetType.IMAGE);
		className.set ("assets/images/enemy0.png", __ASSET__assets_images_enemy0_png);
		type.set ("assets/images/enemy0.png", AssetType.IMAGE);
		className.set ("assets/images/enemy1.png", __ASSET__assets_images_enemy1_png);
		type.set ("assets/images/enemy1.png", AssetType.IMAGE);
		className.set ("assets/images/enemy2.png", __ASSET__assets_images_enemy2_png);
		type.set ("assets/images/enemy2.png", AssetType.IMAGE);
		className.set ("assets/images/grass-tileset.png", __ASSET__assets_images_grass_tileset_png);
		type.set ("assets/images/grass-tileset.png", AssetType.IMAGE);
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		className.set ("assets/images/keys-tooltip.png", __ASSET__assets_images_keys_tooltip_png);
		type.set ("assets/images/keys-tooltip.png", AssetType.IMAGE);
		className.set ("assets/images/laser.png", __ASSET__assets_images_laser_png);
		type.set ("assets/images/laser.png", AssetType.IMAGE);
		className.set ("assets/images/mouse-tooltip-purchase.png", __ASSET__assets_images_mouse_tooltip_purchase_png);
		type.set ("assets/images/mouse-tooltip-purchase.png", AssetType.IMAGE);
		className.set ("assets/images/mouse-tooltip-shield.png", __ASSET__assets_images_mouse_tooltip_shield_png);
		type.set ("assets/images/mouse-tooltip-shield.png", AssetType.IMAGE);
		className.set ("assets/images/mouse-tooltip-tower.png", __ASSET__assets_images_mouse_tooltip_tower_png);
		type.set ("assets/images/mouse-tooltip-tower.png", AssetType.IMAGE);
		className.set ("assets/images/mouse-tooltip.png", __ASSET__assets_images_mouse_tooltip_png);
		type.set ("assets/images/mouse-tooltip.png", AssetType.IMAGE);
		className.set ("assets/images/mouse.png", __ASSET__assets_images_mouse_png);
		type.set ("assets/images/mouse.png", AssetType.IMAGE);
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		className.set ("assets/images/shield-eqp.png", __ASSET__assets_images_shield_eqp_png);
		type.set ("assets/images/shield-eqp.png", AssetType.IMAGE);
		className.set ("assets/images/shield.png", __ASSET__assets_images_shield_png);
		type.set ("assets/images/shield.png", AssetType.IMAGE);
		className.set ("assets/images/sword-eqp.png", __ASSET__assets_images_sword_eqp_png);
		type.set ("assets/images/sword-eqp.png", AssetType.IMAGE);
		className.set ("assets/images/sword.png", __ASSET__assets_images_sword_png);
		type.set ("assets/images/sword.png", AssetType.IMAGE);
		className.set ("assets/images/tent.png", __ASSET__assets_images_tent_png);
		type.set ("assets/images/tent.png", AssetType.IMAGE);
		className.set ("assets/images/tower_0.png", __ASSET__assets_images_tower_0_png);
		type.set ("assets/images/tower_0.png", AssetType.IMAGE);
		className.set ("assets/images/tower_0_btn.pdn", __ASSET__assets_images_tower_0_btn_pdn);
		type.set ("assets/images/tower_0_btn.pdn", AssetType.TEXT);
		className.set ("assets/images/tower_0_btn.png", __ASSET__assets_images_tower_0_btn_png);
		type.set ("assets/images/tower_0_btn.png", AssetType.IMAGE);
		className.set ("assets/images/tower_1.png", __ASSET__assets_images_tower_1_png);
		type.set ("assets/images/tower_1.png", AssetType.IMAGE);
		className.set ("assets/images/tower_1_btn.png", __ASSET__assets_images_tower_1_btn_png);
		type.set ("assets/images/tower_1_btn.png", AssetType.IMAGE);
		className.set ("assets/images/tower_icon_-1.png", __ASSET__assets_images_tower_icon__1_png);
		type.set ("assets/images/tower_icon_-1.png", AssetType.IMAGE);
		className.set ("assets/images/tower_icon_0.png", __ASSET__assets_images_tower_icon_0_png);
		type.set ("assets/images/tower_icon_0.png", AssetType.IMAGE);
		className.set ("assets/images/tower_icon_1.png", __ASSET__assets_images_tower_icon_1_png);
		type.set ("assets/images/tower_icon_1.png", AssetType.IMAGE);
		className.set ("assets/images/tower_select_outline.png", __ASSET__assets_images_tower_select_outline_png);
		type.set ("assets/images/tower_select_outline.png", AssetType.IMAGE);
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		className.set ("fonts/LCD_Solid.ttf", __ASSET__fonts_lcd_solid_ttf);
		type.set ("fonts/LCD_Solid.ttf", AssetType.FONT);
		className.set ("fonts/VISITOR.FON", __ASSET__fonts_visitor_fon);
		type.set ("fonts/VISITOR.FON", AssetType.BINARY);
		className.set ("fonts/visitor.txt", __ASSET__fonts_visitor_txt);
		type.set ("fonts/visitor.txt", AssetType.TEXT);
		className.set ("fonts/visitor1.ttf", __ASSET__fonts_visitor1_ttf);
		type.set ("fonts/visitor1.ttf", AssetType.FONT);
		className.set ("fonts/visitor2.ttf", __ASSET__fonts_visitor2_ttf);
		type.set ("fonts/visitor2.ttf", AssetType.FONT);
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/debug_curvy.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/debug_vertical.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/towerdefense.oep";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial-001.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial-002.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial-003.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial-004.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial-005.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial-006.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial-007.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial-008.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/fonts/LCD_Solid.ttf";
		className.set (id, __ASSET__assets_fonts_lcd_solid_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/VISITOR.FON";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "assets/fonts/visitor.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/fonts/visitor1.ttf";
		className.set (id, __ASSET__assets_fonts_visitor1_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/visitor2.ttf";
		className.set (id, __ASSET__assets_fonts_visitor2_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/images/bow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/checker.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemy.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemy0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemy1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemy2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/grass-tileset.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/images-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/keys-tooltip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/laser.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mouse-tooltip-purchase.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mouse-tooltip-shield.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mouse-tooltip-tower.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mouse-tooltip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mouse.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shield-eqp.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shield.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/sword-eqp.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/sword.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tent.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tower_0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tower_0_btn.pdn";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/tower_0_btn.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tower_1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tower_1_btn.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tower_icon_-1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tower_icon_0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tower_icon_1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tower_select_outline.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "fonts/LCD_Solid.ttf";
		className.set (id, __ASSET__fonts_lcd_solid_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/VISITOR.FON";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "fonts/visitor.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "fonts/visitor1.ttf";
		className.set (id, __ASSET__fonts_visitor1_ttf);
		
		type.set (id, AssetType.FONT);
		id = "fonts/visitor2.ttf";
		className.set (id, __ASSET__fonts_visitor2_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/sounds/beep.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/sounds/flixel.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/fonts/nokiafc22.ttf";
		className.set (id, __ASSET__flixel_fonts_nokiafc22_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/fonts/monsterrat.ttf";
		className.set (id, __ASSET__flixel_fonts_monsterrat_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/images/ui/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/images/logo/default.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		
		
		var assetsPrefix = null;
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			assetsPrefix = ApplicationMain.config.assetsPrefix;
		}
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/debug_curvy.oel", __ASSET__assets_data_debug_curvy_oel);
		type.set ("assets/data/debug_curvy.oel", AssetType.TEXT);
		
		className.set ("assets/data/debug_vertical.oel", __ASSET__assets_data_debug_vertical_oel);
		type.set ("assets/data/debug_vertical.oel", AssetType.TEXT);
		
		className.set ("assets/data/towerdefense.oep", __ASSET__assets_data_towerdefense_oep);
		type.set ("assets/data/towerdefense.oep", AssetType.TEXT);
		
		className.set ("assets/data/tutorial-001.oel", __ASSET__assets_data_tutorial_001_oel);
		type.set ("assets/data/tutorial-001.oel", AssetType.TEXT);
		
		className.set ("assets/data/tutorial-002.oel", __ASSET__assets_data_tutorial_002_oel);
		type.set ("assets/data/tutorial-002.oel", AssetType.TEXT);
		
		className.set ("assets/data/tutorial-003.oel", __ASSET__assets_data_tutorial_003_oel);
		type.set ("assets/data/tutorial-003.oel", AssetType.TEXT);
		
		className.set ("assets/data/tutorial-004.oel", __ASSET__assets_data_tutorial_004_oel);
		type.set ("assets/data/tutorial-004.oel", AssetType.TEXT);
		
		className.set ("assets/data/tutorial-005.oel", __ASSET__assets_data_tutorial_005_oel);
		type.set ("assets/data/tutorial-005.oel", AssetType.TEXT);
		
		className.set ("assets/data/tutorial-006.oel", __ASSET__assets_data_tutorial_006_oel);
		type.set ("assets/data/tutorial-006.oel", AssetType.TEXT);
		
		className.set ("assets/data/tutorial-007.oel", __ASSET__assets_data_tutorial_007_oel);
		type.set ("assets/data/tutorial-007.oel", AssetType.TEXT);
		
		className.set ("assets/data/tutorial-008.oel", __ASSET__assets_data_tutorial_008_oel);
		type.set ("assets/data/tutorial-008.oel", AssetType.TEXT);
		
		className.set ("assets/fonts/LCD_Solid.ttf", __ASSET__assets_fonts_lcd_solid_ttf);
		type.set ("assets/fonts/LCD_Solid.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/VISITOR.FON", __ASSET__assets_fonts_visitor_fon);
		type.set ("assets/fonts/VISITOR.FON", AssetType.BINARY);
		
		className.set ("assets/fonts/visitor.txt", __ASSET__assets_fonts_visitor_txt);
		type.set ("assets/fonts/visitor.txt", AssetType.TEXT);
		
		className.set ("assets/fonts/visitor1.ttf", __ASSET__assets_fonts_visitor1_ttf);
		type.set ("assets/fonts/visitor1.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/visitor2.ttf", __ASSET__assets_fonts_visitor2_ttf);
		type.set ("assets/fonts/visitor2.ttf", AssetType.FONT);
		
		className.set ("assets/images/bow.png", __ASSET__assets_images_bow_png);
		type.set ("assets/images/bow.png", AssetType.IMAGE);
		
		className.set ("assets/images/bullet.png", __ASSET__assets_images_bullet_png);
		type.set ("assets/images/bullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/checker.png", __ASSET__assets_images_checker_png);
		type.set ("assets/images/checker.png", AssetType.IMAGE);
		
		className.set ("assets/images/enemy.png", __ASSET__assets_images_enemy_png);
		type.set ("assets/images/enemy.png", AssetType.IMAGE);
		
		className.set ("assets/images/enemy0.png", __ASSET__assets_images_enemy0_png);
		type.set ("assets/images/enemy0.png", AssetType.IMAGE);
		
		className.set ("assets/images/enemy1.png", __ASSET__assets_images_enemy1_png);
		type.set ("assets/images/enemy1.png", AssetType.IMAGE);
		
		className.set ("assets/images/enemy2.png", __ASSET__assets_images_enemy2_png);
		type.set ("assets/images/enemy2.png", AssetType.IMAGE);
		
		className.set ("assets/images/grass-tileset.png", __ASSET__assets_images_grass_tileset_png);
		type.set ("assets/images/grass-tileset.png", AssetType.IMAGE);
		
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/keys-tooltip.png", __ASSET__assets_images_keys_tooltip_png);
		type.set ("assets/images/keys-tooltip.png", AssetType.IMAGE);
		
		className.set ("assets/images/laser.png", __ASSET__assets_images_laser_png);
		type.set ("assets/images/laser.png", AssetType.IMAGE);
		
		className.set ("assets/images/mouse-tooltip-purchase.png", __ASSET__assets_images_mouse_tooltip_purchase_png);
		type.set ("assets/images/mouse-tooltip-purchase.png", AssetType.IMAGE);
		
		className.set ("assets/images/mouse-tooltip-shield.png", __ASSET__assets_images_mouse_tooltip_shield_png);
		type.set ("assets/images/mouse-tooltip-shield.png", AssetType.IMAGE);
		
		className.set ("assets/images/mouse-tooltip-tower.png", __ASSET__assets_images_mouse_tooltip_tower_png);
		type.set ("assets/images/mouse-tooltip-tower.png", AssetType.IMAGE);
		
		className.set ("assets/images/mouse-tooltip.png", __ASSET__assets_images_mouse_tooltip_png);
		type.set ("assets/images/mouse-tooltip.png", AssetType.IMAGE);
		
		className.set ("assets/images/mouse.png", __ASSET__assets_images_mouse_png);
		type.set ("assets/images/mouse.png", AssetType.IMAGE);
		
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		
		className.set ("assets/images/shield-eqp.png", __ASSET__assets_images_shield_eqp_png);
		type.set ("assets/images/shield-eqp.png", AssetType.IMAGE);
		
		className.set ("assets/images/shield.png", __ASSET__assets_images_shield_png);
		type.set ("assets/images/shield.png", AssetType.IMAGE);
		
		className.set ("assets/images/sword-eqp.png", __ASSET__assets_images_sword_eqp_png);
		type.set ("assets/images/sword-eqp.png", AssetType.IMAGE);
		
		className.set ("assets/images/sword.png", __ASSET__assets_images_sword_png);
		type.set ("assets/images/sword.png", AssetType.IMAGE);
		
		className.set ("assets/images/tent.png", __ASSET__assets_images_tent_png);
		type.set ("assets/images/tent.png", AssetType.IMAGE);
		
		className.set ("assets/images/tower_0.png", __ASSET__assets_images_tower_0_png);
		type.set ("assets/images/tower_0.png", AssetType.IMAGE);
		
		className.set ("assets/images/tower_0_btn.pdn", __ASSET__assets_images_tower_0_btn_pdn);
		type.set ("assets/images/tower_0_btn.pdn", AssetType.TEXT);
		
		className.set ("assets/images/tower_0_btn.png", __ASSET__assets_images_tower_0_btn_png);
		type.set ("assets/images/tower_0_btn.png", AssetType.IMAGE);
		
		className.set ("assets/images/tower_1.png", __ASSET__assets_images_tower_1_png);
		type.set ("assets/images/tower_1.png", AssetType.IMAGE);
		
		className.set ("assets/images/tower_1_btn.png", __ASSET__assets_images_tower_1_btn_png);
		type.set ("assets/images/tower_1_btn.png", AssetType.IMAGE);
		
		className.set ("assets/images/tower_icon_-1.png", __ASSET__assets_images_tower_icon__1_png);
		type.set ("assets/images/tower_icon_-1.png", AssetType.IMAGE);
		
		className.set ("assets/images/tower_icon_0.png", __ASSET__assets_images_tower_icon_0_png);
		type.set ("assets/images/tower_icon_0.png", AssetType.IMAGE);
		
		className.set ("assets/images/tower_icon_1.png", __ASSET__assets_images_tower_icon_1_png);
		type.set ("assets/images/tower_icon_1.png", AssetType.IMAGE);
		
		className.set ("assets/images/tower_select_outline.png", __ASSET__assets_images_tower_select_outline_png);
		type.set ("assets/images/tower_select_outline.png", AssetType.IMAGE);
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
		className.set ("fonts/LCD_Solid.ttf", __ASSET__fonts_lcd_solid_ttf);
		type.set ("fonts/LCD_Solid.ttf", AssetType.FONT);
		
		className.set ("fonts/VISITOR.FON", __ASSET__fonts_visitor_fon);
		type.set ("fonts/VISITOR.FON", AssetType.BINARY);
		
		className.set ("fonts/visitor.txt", __ASSET__fonts_visitor_txt);
		type.set ("fonts/visitor.txt", AssetType.TEXT);
		
		className.set ("fonts/visitor1.ttf", __ASSET__fonts_visitor1_ttf);
		type.set ("fonts/visitor1.ttf", AssetType.FONT);
		
		className.set ("fonts/visitor2.ttf", __ASSET__fonts_visitor2_ttf);
		type.set ("fonts/visitor2.ttf", AssetType.FONT);
		
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						onChange.dispatch ();
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == TEXT && assetType == BINARY) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), Bytes));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):Bytes {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return Bytes.ofData (cast (Type.createInstance (className.get (id), []), flash.utils.ByteArray));
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return Bytes.ofData (bitmapData.getPixels (bitmapData.rect));
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), Bytes);
		
		#elseif html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Bytes);
		else return Bytes.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes.getString (0, bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.getString (0, bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String):Future<AudioBuffer> {
		
		var promise = new Promise<AudioBuffer> ();
		
		#if (flash)
		
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				promise.complete (audioBuffer);
				
			});
			soundLoader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			soundLoader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getAudioBuffer (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<AudioBuffer> (function () return getAudioBuffer (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadBytes (id:String):Future<Bytes> {
		
		var promise = new Promise<Bytes> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = Bytes.ofData (event.currentTarget.data);
				promise.complete (bytes);
				
			});
			loader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			promise.completeWith (request.load (path.get (id) + "?" + Assets.cache.version));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Bytes> (function () return getBytes (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadImage (id:String):Future<Image> {
		
		var promise = new Promise<Image> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				promise.complete (Image.fromBitmapData (bitmapData));
				
			});
			loader.contentLoaderInfo.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var image = new js.html.Image ();
			image.onload = function (_):Void {
				
				promise.complete (Image.fromImageElement (image));
				
			}
			image.onerror = promise.error;
			image.src = path.get (id) + "?" + Assets.cache.version;
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Image> (function () return getImage (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = Bytes.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = Bytes.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = Bytes.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = Bytes.readFile ("../Resources/manifest");
			#elseif (ios || tvos)
			var bytes = Bytes.readFile ("assets/manifest");
			#else
			var bytes = Bytes.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				if (bytes.length > 0) {
					
					var data = bytes.getString (0, bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if (ios || tvos)
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadText (id:String):Future<String> {
		
		var promise = new Promise<String> ();
		
		#if html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			var future = request.load (path.get (id) + "?" + Assets.cache.version);
			future.onProgress (function (progress) promise.progress (progress));
			future.onError (function (msg) promise.error (msg));
			future.onComplete (function (bytes) promise.complete (bytes.getString (0, bytes.length)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.getString (0, bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_debug_curvy_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_debug_vertical_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_towerdefense_oep extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_001_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_002_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_003_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_004_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_005_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_006_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_007_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_008_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_lcd_solid_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_visitor_fon extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_visitor_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_visitor1_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_visitor2_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_bow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_checker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemy0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemy1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemy2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_grass_tileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_keys_tooltip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_laser_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mouse_tooltip_purchase_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mouse_tooltip_shield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mouse_tooltip_tower_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mouse_tooltip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mouse_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shield_eqp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sword_eqp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sword_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tent_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_0_btn_pdn extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_0_btn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_1_btn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_icon__1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_icon_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_icon_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tower_select_outline_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__fonts_lcd_solid_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__fonts_visitor_fon extends null { }
@:keep @:bind #if display private #end class __ASSET__fonts_visitor_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__fonts_visitor1_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__fonts_visitor2_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5













@:keep #if display private #end class __ASSET__assets_fonts_lcd_solid_ttf extends lime.text.Font { public function new () { super (); name = "LCD Solid"; } } 


@:keep #if display private #end class __ASSET__assets_fonts_visitor1_ttf extends lime.text.Font { public function new () { super (); name = "Visitor TT1 BRK"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_visitor2_ttf extends lime.text.Font { public function new () { super (); name = "Visitor TT2 BRK"; } } 

































@:keep #if display private #end class __ASSET__fonts_lcd_solid_ttf extends lime.text.Font { public function new () { super (); name = "LCD Solid"; } } 


@:keep #if display private #end class __ASSET__fonts_visitor1_ttf extends lime.text.Font { public function new () { super (); name = "Visitor TT1 BRK"; } } 
@:keep #if display private #end class __ASSET__fonts_visitor2_ttf extends lime.text.Font { public function new () { super (); name = "Visitor TT2 BRK"; } } 


@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 




#else



#if (windows || mac || linux || cpp)


@:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends lime.utils.Bytes {}
@:file("assets/data/debug_curvy.oel") #if display private #end class __ASSET__assets_data_debug_curvy_oel extends lime.utils.Bytes {}
@:file("assets/data/debug_vertical.oel") #if display private #end class __ASSET__assets_data_debug_vertical_oel extends lime.utils.Bytes {}
@:file("assets/data/towerdefense.oep") #if display private #end class __ASSET__assets_data_towerdefense_oep extends lime.utils.Bytes {}
@:file("assets/data/tutorial-001.oel") #if display private #end class __ASSET__assets_data_tutorial_001_oel extends lime.utils.Bytes {}
@:file("assets/data/tutorial-002.oel") #if display private #end class __ASSET__assets_data_tutorial_002_oel extends lime.utils.Bytes {}
@:file("assets/data/tutorial-003.oel") #if display private #end class __ASSET__assets_data_tutorial_003_oel extends lime.utils.Bytes {}
@:file("assets/data/tutorial-004.oel") #if display private #end class __ASSET__assets_data_tutorial_004_oel extends lime.utils.Bytes {}
@:file("assets/data/tutorial-005.oel") #if display private #end class __ASSET__assets_data_tutorial_005_oel extends lime.utils.Bytes {}
@:file("assets/data/tutorial-006.oel") #if display private #end class __ASSET__assets_data_tutorial_006_oel extends lime.utils.Bytes {}
@:file("assets/data/tutorial-007.oel") #if display private #end class __ASSET__assets_data_tutorial_007_oel extends lime.utils.Bytes {}
@:file("assets/data/tutorial-008.oel") #if display private #end class __ASSET__assets_data_tutorial_008_oel extends lime.utils.Bytes {}
@:font("assets/fonts/LCD_Solid.ttf") #if display private #end class __ASSET__assets_fonts_lcd_solid_ttf extends lime.text.Font {}
@:file("assets/fonts/VISITOR.FON") #if display private #end class __ASSET__assets_fonts_visitor_fon extends lime.utils.Bytes {}
@:file("assets/fonts/visitor.txt") #if display private #end class __ASSET__assets_fonts_visitor_txt extends lime.utils.Bytes {}
@:font("assets/fonts/visitor1.ttf") #if display private #end class __ASSET__assets_fonts_visitor1_ttf extends lime.text.Font {}
@:font("assets/fonts/visitor2.ttf") #if display private #end class __ASSET__assets_fonts_visitor2_ttf extends lime.text.Font {}
@:image("assets/images/bow.png") #if display private #end class __ASSET__assets_images_bow_png extends lime.graphics.Image {}
@:image("assets/images/bullet.png") #if display private #end class __ASSET__assets_images_bullet_png extends lime.graphics.Image {}
@:image("assets/images/checker.png") #if display private #end class __ASSET__assets_images_checker_png extends lime.graphics.Image {}
@:image("assets/images/enemy.png") #if display private #end class __ASSET__assets_images_enemy_png extends lime.graphics.Image {}
@:image("assets/images/enemy0.png") #if display private #end class __ASSET__assets_images_enemy0_png extends lime.graphics.Image {}
@:image("assets/images/enemy1.png") #if display private #end class __ASSET__assets_images_enemy1_png extends lime.graphics.Image {}
@:image("assets/images/enemy2.png") #if display private #end class __ASSET__assets_images_enemy2_png extends lime.graphics.Image {}
@:image("assets/images/grass-tileset.png") #if display private #end class __ASSET__assets_images_grass_tileset_png extends lime.graphics.Image {}
@:file("assets/images/images-go-here.txt") #if display private #end class __ASSET__assets_images_images_go_here_txt extends lime.utils.Bytes {}
@:image("assets/images/keys-tooltip.png") #if display private #end class __ASSET__assets_images_keys_tooltip_png extends lime.graphics.Image {}
@:image("assets/images/laser.png") #if display private #end class __ASSET__assets_images_laser_png extends lime.graphics.Image {}
@:image("assets/images/mouse-tooltip-purchase.png") #if display private #end class __ASSET__assets_images_mouse_tooltip_purchase_png extends lime.graphics.Image {}
@:image("assets/images/mouse-tooltip-shield.png") #if display private #end class __ASSET__assets_images_mouse_tooltip_shield_png extends lime.graphics.Image {}
@:image("assets/images/mouse-tooltip-tower.png") #if display private #end class __ASSET__assets_images_mouse_tooltip_tower_png extends lime.graphics.Image {}
@:image("assets/images/mouse-tooltip.png") #if display private #end class __ASSET__assets_images_mouse_tooltip_png extends lime.graphics.Image {}
@:image("assets/images/mouse.png") #if display private #end class __ASSET__assets_images_mouse_png extends lime.graphics.Image {}
@:image("assets/images/player.png") #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:image("assets/images/shield-eqp.png") #if display private #end class __ASSET__assets_images_shield_eqp_png extends lime.graphics.Image {}
@:image("assets/images/shield.png") #if display private #end class __ASSET__assets_images_shield_png extends lime.graphics.Image {}
@:image("assets/images/sword-eqp.png") #if display private #end class __ASSET__assets_images_sword_eqp_png extends lime.graphics.Image {}
@:image("assets/images/sword.png") #if display private #end class __ASSET__assets_images_sword_png extends lime.graphics.Image {}
@:image("assets/images/tent.png") #if display private #end class __ASSET__assets_images_tent_png extends lime.graphics.Image {}
@:image("assets/images/tower_0.png") #if display private #end class __ASSET__assets_images_tower_0_png extends lime.graphics.Image {}
@:file("assets/images/tower_0_btn.pdn") #if display private #end class __ASSET__assets_images_tower_0_btn_pdn extends lime.utils.Bytes {}
@:image("assets/images/tower_0_btn.png") #if display private #end class __ASSET__assets_images_tower_0_btn_png extends lime.graphics.Image {}
@:image("assets/images/tower_1.png") #if display private #end class __ASSET__assets_images_tower_1_png extends lime.graphics.Image {}
@:image("assets/images/tower_1_btn.png") #if display private #end class __ASSET__assets_images_tower_1_btn_png extends lime.graphics.Image {}
@:image("assets/images/tower_icon_-1.png") #if display private #end class __ASSET__assets_images_tower_icon__1_png extends lime.graphics.Image {}
@:image("assets/images/tower_icon_0.png") #if display private #end class __ASSET__assets_images_tower_icon_0_png extends lime.graphics.Image {}
@:image("assets/images/tower_icon_1.png") #if display private #end class __ASSET__assets_images_tower_icon_1_png extends lime.graphics.Image {}
@:image("assets/images/tower_select_outline.png") #if display private #end class __ASSET__assets_images_tower_select_outline_png extends lime.graphics.Image {}
@:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends lime.utils.Bytes {}
@:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.Bytes {}
@:font("assets/fonts/LCD_Solid.ttf") #if display private #end class __ASSET__fonts_lcd_solid_ttf extends lime.text.Font {}
@:file("assets/fonts/VISITOR.FON") #if display private #end class __ASSET__fonts_visitor_fon extends lime.utils.Bytes {}
@:file("assets/fonts/visitor.txt") #if display private #end class __ASSET__fonts_visitor_txt extends lime.utils.Bytes {}
@:font("assets/fonts/visitor1.ttf") #if display private #end class __ASSET__fonts_visitor1_ttf extends lime.text.Font {}
@:font("assets/fonts/visitor2.ttf") #if display private #end class __ASSET__fonts_visitor2_ttf extends lime.text.Font {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends lime.utils.Bytes {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends lime.utils.Bytes {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__assets_fonts_lcd_solid_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_fonts_lcd_solid_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__assets_fonts_visitor1_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_fonts_visitor1_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__assets_fonts_visitor2_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_fonts_visitor2_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__fonts_lcd_solid_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__fonts_lcd_solid_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__fonts_visitor1_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__fonts_visitor1_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__fonts_visitor2_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__fonts_visitor2_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end