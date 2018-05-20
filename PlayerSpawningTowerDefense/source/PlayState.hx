package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flash.display.Sprite;
import flixel.util.FlxAxes;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState {
	// Final variables
	private var TIMER_INTERVAL = 180;
	private var AUTO_TOWER_COST = 50;
	private var DART_TOWER_COST = 100;
	private var startingTentHP:Float;
	private var startingTent2HP:Float;
	private var pstats:PlayerStats;

	private var level_hud:HUD;
	private var shop_hud:Pre_HUD;
	private var hint:FlxText;
	private var level_num:Int;
	private var _player:Player;
	private var _sword:Sword;
	private var _shield:Shield;
	private var _towers:FlxTypedGroup<Tower>;
	private var _laserTowers:FlxTypedGroup<LaserTower>;
	public var lasers:FlxTypedGroup<Laser>;
	public var bullets:FlxTypedGroup<Bullet>;
//	private var playerMoney:Int = 0;
	private var startingMoney:Int = 0;

	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var _mEnemyWalls:FlxTilemap;

	private var _numEnemies:Int = 0;
	private var _enemyCounts:Map<Int, Int> = [0 => 0, 1 => 0, 2 => 0]; // Map enemy id to their count

	private var _timer:Int;
	private var _tent:Tent;
	private var _tent2:Tent;
	
    public var tentHealth:Float = 1000.0;
    public var tent2Health:Float = 1000.0;
	private var _spawner:EnemySpawner;
	private var _spawner2:EnemySpawner;
	private var _done:Bool = false;
	private var _buildingMode:Bool = false;
	private var _preLevelState:Bool = false;

	var grabbedPos:FlxPoint = new FlxPoint( -1, -1); //For camera scrolling
    var initialScroll:FlxPoint = new FlxPoint(0, 0); //Ditto ^
	var _btnPlay:FlxButton;
	var _towersAvailable:Int = 0;

	var playerKills = 0;
	var towerKills = 0;

	/**
	 * Helper Sprite object to draw tower's range graphic
	 */
	private static var RANGE_SPRITE:Sprite = null;


	private var _towerRange:FlxSprite;
	private var _buildHelper:FlxSprite;
	private var guiUnderlay:FlxSprite;

	public static inline var TILE_SIZE:Int = 32;

	override public function create():Void {
		_timer = TIMER_INTERVAL - 1;
		var className = Type.getClassName(Type.getClass(this));
		// This code only functions for 5 letter names in levels
		level_num = Std.parseInt(className.substring(12));
		if (className.substring(7, 12) == "Tutor") {
			level_num = -level_num;
		}
		//trace(levelNum);
		Main.LOGGER.logLevelStart(level_num, Type.getClassName(Type.getClass(this)));

		_mWalls = _map.loadTilemap("assets/images/grass-tileset.png", 32, 32, "walls");
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.NONE);
		_mWalls.setTileProperties(4, FlxObject.NONE);
		_mWalls.setTileProperties(5, FlxObject.NONE);
		_mWalls.setTileProperties(6, FlxObject.NONE);
		_mWalls.setTileProperties(7, FlxObject.NONE);
		_mWalls.setTileProperties(8, FlxObject.ANY);
		_mWalls.setTileProperties(9, FlxObject.LEFT);
		_mWalls.setTileProperties(10, FlxObject.ANY);
		_mWalls.setTileProperties(11, FlxObject.NONE);
		_mWalls.setTileProperties(12, FlxObject.NONE);
		add(_mWalls);

		_mEnemyWalls = _map.loadTilemap("assets/images/grass-tileset.png", 32, 32, "walls");
		_mEnemyWalls.follow();
		_mEnemyWalls.setTileProperties(1, FlxObject.ANY);
		_mEnemyWalls.setTileProperties(2, FlxObject.NONE);
		_mEnemyWalls.setTileProperties(3, FlxObject.NONE);
		_mEnemyWalls.setTileProperties(4, FlxObject.NONE);
		_mEnemyWalls.setTileProperties(5, FlxObject.NONE);
		_mEnemyWalls.setTileProperties(6, FlxObject.NONE);
		_mEnemyWalls.setTileProperties(7, FlxObject.NONE);
		_mEnemyWalls.setTileProperties(8, FlxObject.ANY);
		_mEnemyWalls.setTileProperties(9, FlxObject.NONE);
		_mEnemyWalls.setTileProperties(10, FlxObject.NONE);
		_mEnemyWalls.setTileProperties(11, FlxObject.ANY);
		_mEnemyWalls.setTileProperties(12, FlxObject.NONE);
		add(_mEnemyWalls);

		//guiUnderlay = new FlxSprite(_player.getMidpoint().x - FlxG.width / 2, _player.getMidpoint().y + FlxG.height / 2);
		//guiUnderlay.makeGraphic(FlxG.width, 32, FlxColor.WHITE);

		//add(guiUnderlay);

		// Setup entities
		_spawner = new EnemySpawner(_mEnemyWalls, 200.0);
		_spawner2 = new EnemySpawner(_mEnemyWalls, 200.0);

		_map.loadEntities(placeEntities, "entities");

		
		_towers = new FlxTypedGroup<Tower>();
		_laserTowers = new FlxTypedGroup<LaserTower>();
		bullets = new FlxTypedGroup<Bullet>();
		lasers = new FlxTypedGroup<Laser>();

		add(bullets);
		add(lasers);
		add(_towers);
		add(_laserTowers);
		add(_tent);
		add(_tent.healthBar);
		if (_tent2.set) {
			add(_tent2);
			add(_tent2.healthBar);
		}
 		add(_spawner.spawnedEnemies);
		add(_spawner2.spawnedEnemies);

		// Setup but don't add level hud
		level_hud = new HUD();
		setEnemyHud();

		// Tower building and pre-wave setup, set camera and pre-hud
		_preLevelState = true;
		FlxG.camera.zoom = 0.75;
		setPreLevelHUD();

		_buildHelper = new FlxSprite(TILE_SIZE, TILE_SIZE, "assets/images/checker.png");
		_buildHelper.visible = false;
		_buildHelper.setSize(TILE_SIZE, TILE_SIZE);
		
		_towerRange = new FlxSprite(0, 0);
		_towerRange.visible = false;

		add(_buildHelper);
		add(_towerRange);
		super.create();
	}

	private function placeEntities(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			_player.x = x;
			_player.y = y;
		} else if (entityName == "tent") {
			if (!_tent.set) {
				_tent.setup(x, y);
				if (Std.parseInt(entityData.get("spawner1")) == 1) {
					_spawner.setTentCoords(x, y);
				}
				if (Std.parseInt(entityData.get("spawner2")) == 1){
					_spawner2.setTentCoords(x, y);
				}
				_tent.set = true;
			} else {
				_tent2.setup(x, y);
				if (Std.parseInt(entityData.get("spawner1")) == 1) {
					_spawner.setTentCoords(x, y);
				}
				if (Std.parseInt(entityData.get("spawner2")) == 1){
					_spawner2.setTentCoords(x, y);
				}
				_tent2.set = true;
			}
		} else if (entityName == "spawner") {
			var id:Int = Std.parseInt(entityData.get("idNum"));
			if (id == 1) {
				_spawner.setSpawnCoords(x, y);
				setupSpawner(_spawner, entityData);
			} else if (id == 2) {
				_spawner2.setSpawnCoords(x, y);
				setupSpawner(_spawner2, entityData);
			}
		} else if (entityName == "money") { // Set default money (for debug/tutorial)
			startingMoney = Std.parseInt(entityData.get("money"));
		}
	}

	private function setupSpawner(spawner:EnemySpawner, entityData:Xml):Void {
		// For each wave, insert the enemy type and count
        spawner.setSpeed(Std.parseInt(entityData.get("speed")));
		var waves:Int = Std.parseInt(entityData.get("waves")) + 1;
		for (i in 1...waves) {
			var type:Int = Std.parseInt(entityData.get("type" + i));
			var count:Int = Std.parseInt(entityData.get("count" + i));
			_numEnemies += count;
			_enemyCounts.set(type, _enemyCounts.get(type) + count);
			spawner.addToQueue(type, count);
		}
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (_preLevelState) {
			//Scroll the camera by pressing the middle button
            if (FlxG.mouse.justPressedMiddle){
                grabbedPos = FlxG.mouse.getWorldPosition(FlxG.camera);
                initialScroll = FlxG.camera.scroll;
            }
            if (FlxG.mouse.pressedMiddle){
                var mousePosChange:FlxPoint = FlxG.mouse.getWorldPosition(FlxG.camera).subtractPoint(grabbedPos);
                FlxG.camera.scroll.subtractPoint(mousePosChange);
            }

			// Only build while there are towers available
			if (_buildingMode && _towersAvailable > 0) {
				_buildHelper.x = FlxG.mouse.x - (FlxG.mouse.x % TILE_SIZE);
				_buildHelper.y = FlxG.mouse.y - (FlxG.mouse.y % TILE_SIZE);
				updateRangeSprite(_buildHelper.getMidpoint(), Tower.BASE_RANGE);
				if (FlxG.mouse.justReleased) {
					buildTower(shop_hud.getSelectedTowerType());
				}
			}

			// Selecting an existing tower
			if (!_buildingMode) {
				if (FlxG.mouse.justReleased) {
					var towerPressed:Bool = false;
					for(tower in _towers) {
						if(FlxG.mouse.overlaps(tower)) {
							_buildHelper.x = FlxG.mouse.x - (FlxG.mouse.x % TILE_SIZE);
							_buildHelper.y = FlxG.mouse.y - (FlxG.mouse.y % TILE_SIZE);
							updateRangeSprite(_buildHelper.getMidpoint(), tower.range);
							towerPressed = true;
							shop_hud.setSelectedTowerReference(tower);
						}
					}
					for(button in shop_hud._upgradeButtons) {
						if(FlxG.mouse.overlaps(button)) {
							towerPressed = true;
							if (button.text == "Range Up")
								updateRangeSprite(_buildHelper.getMidpoint(), shop_hud.getTowerRange());
						}
					}
					if(!towerPressed) {
						_towerRange.visible = false;
						shop_hud.deselectTower();
						shop_hud.killButtons();
					}
				}
			}

			// Only allow level to start once all towers placed (ONLY ON TUTORIAL LEVELS)
			if (level_num == -4 || level_num == -5 || level_num == -9) {
				if (_towersAvailable == 0 && _btnPlay == null && shop_hud.money == 0) {
					_buildingMode = false; // May not be necessary
					setPlayButton();
				}
			} else if (level_num == -6) {
				if (_towersAvailable == 0 && _btnPlay == null && shop_hud.money < 25) {
					_buildingMode = false; // May not be necessary
					setPlayButton();
				}
			} else {
				if (level_num < 0 && (_towersAvailable == 0 && _btnPlay == null)) {
					_buildingMode = false; // May not be necessary
					setPlayButton();
				}
			}

			return;
		}


		if (_done) return;

		// Check collisions
		FlxG.collide(_player, _mWalls);
		FlxG.collide(_spawner.spawnedEnemies, _mEnemyWalls);
		FlxG.collide(_spawner2.spawnedEnemies, _mEnemyWalls);

		FlxG.overlap(_spawner.spawnedEnemies, _tent, onEnemyReachedTent);
		FlxG.overlap(_spawner.spawnedEnemies, _tent2, onEnemyReachedTent);
		FlxG.overlap(_spawner.spawnedEnemies, _sword, onSwingHit);
		FlxG.overlap(_spawner2.spawnedEnemies, _tent, onEnemyReachedTent);
		FlxG.overlap(_spawner2.spawnedEnemies, _tent2, onEnemyReachedTent);
		FlxG.overlap(_spawner2.spawnedEnemies, _sword, onSwingHit);

		FlxG.overlap(bullets, _spawner.spawnedEnemies, hitEnemy);
		FlxG.overlap(bullets, _spawner2.spawnedEnemies, hitEnemy);
		FlxG.overlap(lasers, _spawner.spawnedEnemies, laseredEnemy);
		FlxG.overlap(lasers, _spawner2.spawnedEnemies, laseredEnemy);

		_spawner.spawnedEnemies.forEachAlive(checkEnemyVision);
		_spawner2.spawnedEnemies.forEachAlive(checkEnemyVision);
		FlxG.overlap(_player, _laserTowers, onPossibleManualTowerActivation);

		// Attack player
		checkHitOnPlayer(_spawner.spawnedEnemies);
		checkHitOnPlayer(_spawner2.spawnedEnemies);

		for(tower in _towers) {
			tower.setNearestEnemy(_spawner.spawnedEnemies, _spawner2.spawnedEnemies);
			tower.shoot(bullets);
		}

		// Check if player dead
		checkFailure();

		// Check if the sword is done swinging, kill if it is
		if (_sword != null && _sword.isDone()) {
			_sword.destroy();
			_sword = null;
			for(enemy in _spawner.spawnedEnemies) {
				enemy.swordHit = false;
			}
			for(enemy in _spawner2.spawnedEnemies) {
				enemy.swordHit = false;
			}
		}

		// Kill shield if not pressing
		if (_shield != null && (!FlxG.mouse.pressedRight && !FlxG.keys.pressed.PERIOD)) {
			_shield.destroy();
			_shield = null;
			_player.shielding = false;
		}

		// Create a sword that begins swinging (as long as not shielding)
		if ((FlxG.mouse.justPressed || FlxG.keys.justPressed.COMMA) && _sword == null && !(FlxG.mouse.pressedRight && _player.getEquipR() == "shield")) {
			makeSword(_player.getGraphicMidpoint());
		}

		// Create a shield that follows the player
		if (_sword == null && _shield == null && (FlxG.mouse.pressedRight || FlxG.keys.pressed.PERIOD) && _player.getEquipR() == "shield") {
			//Main.LOGGER.logLevelAction(LoggingActions.PLAYER_SHIELDED);
			makeShield(_player.getGraphicMidpoint());
			_player.shielding = true;
		}

		_timer++;
		if (_timer == TIMER_INTERVAL) {
			var e:Enemy = _spawner.spawnEnemy();
			if (e != null) add(e.healthBar);
			var e2:Enemy = _spawner2.spawnEnemy();
			if (e2 != null) add (e2.healthBar);
			_timer = 0;
		}
	}
	private function checkHitOnPlayer(enemies:FlxTypedGroup<Enemy>) {
		for(enemy in enemies) {
			if (enemy.canFire()) { // && !FlxSpriteUtil.isFlickering(_player)
				enemy.fire();
				_player.hit(40.0);
				if (!_player.shielding) FlxSpriteUtil.flicker(_player, 0.3, 0.06);

			}
		}
	}

	// Purchase a regular tower
	private function clickTowerPurchase(type:Int, price:Int):Void {
		// trace("Trying to place with " + shop_hud.money);
		if (shop_hud.money >= price) {
			shop_hud.money -= price;
			shop_hud.setMoney(shop_hud.money);
			_buildingMode = true;
			_towersAvailable++;
			shop_hud.setSelectedTower(type);
		}
	}

	private function purchaseBasicTower() {
		//trace("Purchase basic");
		clickTowerPurchase(0, AUTO_TOWER_COST);
	}

	private function purchaseDartTower() {
		//trace("Purchase dart");
		clickTowerPurchase(1, DART_TOWER_COST);
	}

	/**
	 * Called either when building, or upgrading, a tower.
	 */
	private function updateRangeSprite(Center:FlxPoint, Range:Int):Void
	{
		_towerRange.setPosition(Center.x - Range, Center.y - Range);
		_towerRange.makeGraphic(Range * 2, Range * 2, FlxColor.TRANSPARENT);
		
		// Using and re-using a static sprite like this reduces garbage creation.
		
		RANGE_SPRITE = new Sprite();
		RANGE_SPRITE.graphics.beginFill(0xFFFFFF);
		RANGE_SPRITE.graphics.drawCircle(Range, Range, Range);
		RANGE_SPRITE.graphics.endFill();
		
		_towerRange.pixels.draw(RANGE_SPRITE);
		
		#if flash
		_towerRange.blend = BlendMode.INVERT;
		#else
		_towerRange.alpha = 0.5;
		#end
		
		_towerRange.visible = true;
	}

	private function buildTower(type:Int):Void
	{
		// Can't place towers on GUI
		if (FlxG.mouse.y < 32)
		{
			return;
		}
		
		// Snap to grid
		var xPos:Float = FlxG.mouse.x - (FlxG.mouse.x % TILE_SIZE);
		var yPos:Float = FlxG.mouse.y - (FlxG.mouse.y % TILE_SIZE);
		
		// Can't place towers on other towers
		for (tower in _towers) {
			if (tower.x == xPos && tower.y == yPos) {
				//FlxG.sound.play("deny");
				return;
			}
		}

		for (tower in _laserTowers) {
			if (tower.x == xPos && tower.y == yPos) {
				//FlxG.sound.play("deny");
				return;
			}
		}
		
		// Can't place towers on non-grass
		var tileId:Int = _mWalls.getTile(Std.int(xPos / TILE_SIZE), Std.int(yPos / TILE_SIZE));
		if (level_num == -4 || level_num == -5 || level_num == -9) {
			if (tileId != 11) {
				return;
			}
		} else if (tileId != 1 && tileId != 11) {
			//FlxG.sound.play("deny");
			return;
		}

		// Success, place tower
		_towersAvailable--;
		var tower:Tower = null;
		if (type == 0) {
			tower = new BasicTower(xPos, yPos);
		} else if (type == 1) {
			tower = new DartTower(xPos, yPos);
		} else {
			trace("ERROR: INVALID TOWERTYPE PASSED");
		}

		_towers.add(tower);
		shop_hud.setSelectedTowerReference(tower);
		_buildingMode = false;
		
		// After the first tower is bought, sell mode becomes available.
		/*if (_sellButton.visible == false)
			_sellButton.visible = true;
		
		// If this is the first tower the player has built, they get the tutorial text.
		// This is made invisible after they've bought an upgrade.
		if (_tutText.visible == false && _towers.length == 1)
			_tutText.visible = true;
		
		FlxG.sound.play("build");
		
		money -= towerPrice;
		towerPrice += Std.int(towerPrice * 0.3);
		_towerButton.text = "Buy [T]ower ($" + towerPrice + ")";
		toggleMenus(General);*/
	}

	function checkEnemyVision(e:Enemy):Void
	{
		if (_mWalls.ray(e.getMidpoint(), _player.getMidpoint()) && e.getMidpoint().distanceTo(_player.getMidpoint()) < 50) 
			e.playerInRange = true;
		else
			e.playerInRange = false;
	}

	private function onEnemyReachedTent(enemy:Enemy, tent:FlxSprite):Void {
		tent.hurt(100);
        enemy.healthBar.value = 0;
        enemy.kill();
		//Main.LOGGER.logLevelAction(LoggingActions.TENT_KILLED_ENEMY);
        decrementEnemy(enemy);
        checkSuccess();
		checkFailure();
	}

	private function onSwingHit(enemy:Enemy, sword:FlxSprite):Void {
		var isDead:Bool = enemy.hurtEnemy(pstats.damage, true);
			
		if (isDead) {
			//Main.LOGGER.logLevelAction(LoggingActions.PLAYER_KILLED_ENEMY_SWORD, enemy.type);
			playerKills++; // For logging
			decrementEnemy(enemy);
			shop_hud.money += 5;
            checkSuccess();
        }
	}

	private function hitEnemy(bullet:Bullet, enemy:Enemy):Void {
		var isDead:Bool = enemy.hurtEnemy(bullet.damage, false);
		if (!bullet.pierces || bullet.getPosition().distanceTo(bullet.startPos) > 512)
			bullet.kill();
			
		if (isDead) {
			//Main.LOGGER.logLevelAction(LoggingActions.PLAYER_KILLED_ENEMY_SWORD, enemy.type);
			towerKills++; // For logging
			decrementEnemy(enemy);
			shop_hud.money += 5;
            checkSuccess();
        }
	}

	private function laseredEnemy(laser:Laser, enemy:Enemy):Void {
		var isDead:Bool = enemy.hurtEnemy(100000, false);
			
		if (isDead) {
			//Main.LOGGER.logLevelAction(LoggingActions.PLAYER_KILLED_ENEMY_SWORD, enemy.type);
			towerKills++; // For logging
			decrementEnemy(enemy);
			shop_hud.money += 5;
            checkSuccess();
        }
	}

	private function onPossibleManualTowerActivation(player:Player, lasertower:LaserTower) {
		if (FlxG.keys.justPressed.F) {
			lasertower.shoot(lasers);
		}
	}

	private function decrementEnemy(enemy:Enemy):Void {
		_numEnemies--;
		if (enemy.type == 0) {
			level_hud.decrementEnemy0();
		} else if (enemy.type == 1) {
			level_hud.decrementEnemy1();
		} else if (enemy.type == 2) {
			level_hud.decrementEnemy2();
		}
	}

	private function makeSword(coord:FlxPoint):Void {
		var x = coord.x;
		var y = coord.y;
		var dir = _player.getDir();
		// 0 = up, 1 = down, 2 = left, 3 = right
		if (dir == "u") {
			y -= 12;
		} else if (dir == "d") {
			y += 12;
		} else if (dir == "l") {
			x -= 13;
			y += 4;
		} else if (dir == "r") {
			x += 13;
			y += 4;
		}
		_sword = new Sword(x - 20, y - 20, dir);
		add(_sword);
	}

	private function makeShield(coord:FlxPoint):Void {
		var x = coord.x;
		var y = coord.y;
		var dir = _player.getDir();
		// 0 = up, 1 = down, 2 = left, 3 = right
		if (dir == "u") {
			y -= 5;
			x += 12;
		} else if (dir == "d") {
			x += 11;
			y += 21;
		} else if (dir == "l") {
			x += 2;
			y += 15;
		} else if (dir == "r") {
			x += 22;
			y += 15;
		}
		_shield = new Shield(x - 20, y - 20, dir, _player.speed / 4);
		add(_shield);
	}

    // Transition to next level if no enemies left (to be overriden by levels)
	// If this is reached, they succeeded
    private function checkSuccess():Void {
		Main.LOGGER.logLevelEnd({success: true, playerHealth: _player.health, tentHealth: _tent.getHealth(),
								playerKills: playerKills, towerKills: towerKills});
		_player.healthBar.destroy();
        _player.kill();
		if (_sword != null)_sword.destroy();
		if (_shield != null)_shield.destroy();
    }

	private function checkFailure():Void {
		var failReason:String = null;
		if (_player.health <= 0.0001) {
			failReason = "player";
		} else if (_tent.health <= 0.001 || (_tent2 != null && _tent2.health <= 0.001)) {
			failReason = "tent";
			_tent.kill();
		}

		if (failReason != null) {
			Main.LOGGER.logLevelEnd({success: false, failReason: failReason, enemiesRemaining: _numEnemies});
			_done = true;
			_player.kill();
			_player.healthBar.destroy();
			if (_sword != null)_sword.destroy();
			if (_shield != null)_shield.destroy();
			for (e in _spawner.spawnedEnemies) {
				e.healthBar.value = 0;
			}
			for (e in _spawner2.spawnedEnemies) {
				e.healthBar.value = 0;
			}
			_spawner.spawnedEnemies.kill();
			_spawner2.spawnedEnemies.kill();
			var _btnPlay:FlxButton = new FlxButton(0, 0, "Replay", clickReplay);
			_btnPlay.screenCenter();
			add(_btnPlay);
		}
	}

    // Replay current level (Also to be overridden)
	private function clickReplay():Void {
		trace("replay");
	}

	// Set play button once done putting towers (for tutorial)
	private function setPlayButton():Void {
		_btnPlay = new FlxButton(FlxG.width - 32, FlxG.height - 8, "Start Level", startLevel);
		add(_btnPlay);
	}


	function switchLevel(l:PlayState, c:PlayState):Void {
		l.startingTentHP = c._tent.getHealth();
		l.startingTent2HP = c._tent2.getHealth();
		l.pstats = c.pstats;
		l.pstats.setStartLevel();
		FlxG.switchState(l);
	}

	function restartLevel(l:PlayState, c:PlayState):Void {
		l.startingTentHP = c.startingTentHP;
		l.startingTent2HP = c.startingTent2HP;
		l.pstats = c.pstats;
		l.pstats.resetLevel();
		FlxG.switchState(l);
	}

	function startLevel():Void {
		//ff("Starting level: setting camera zoom");
		clearPreLevelHUD();
		FlxG.camera.zoom = 1;
		setLevelHUD();
		_preLevelState = false;
		_buildingMode = false;
		add(_player);
		add(_player.healthBar);
		_buildHelper.kill();
		_towerRange.kill();
		hint.kill();
		FlxG.camera.follow(_player, TOPDOWN, 1);
		_btnPlay.kill();
	}

	function setPreLevelHUD():Void {
		// Setup Tower Purchase
		shop_hud = new Pre_HUD(level_num);
		shop_hud.setMoney(startingMoney);
		if (shop_hud._btnPurchaseBasicTower != null)
			shop_hud._btnPurchaseBasicTower.onDown.callback = purchaseBasicTower;
		if (shop_hud._btnPurchaseDartTower != null)
			shop_hud._btnPurchaseDartTower.onDown.callback = purchaseDartTower;
		add(shop_hud);
	}

	function clearPreLevelHUD():Void {
		shop_hud.destroy();
	}

	function setLevelHUD():Void {
		add(level_hud);
	}

	private function setEnemyHud() {
		//trace(_enemyCounts);
		var slot1set:Bool = false;
		var slot2set:Bool = false;
		if (_enemyCounts.get(0) > 0) {
			level_hud.setEnemyA("0", _enemyCounts.get(0));
			slot1set = true;
		}
		if (_enemyCounts.get(1) > 0) {
			if (!slot1set) {
				level_hud.setEnemyA("1", _enemyCounts.get(1));
			} else {
				level_hud.setEnemyB("1", _enemyCounts.get(1));
			}
			slot2set = true;
		}
		if (_enemyCounts.get(2) > 0) {
			if (!slot1set) {
				level_hud.setEnemyA("2", _enemyCounts.get(2));
			} else if (!slot2set) {
				level_hud.setEnemyB("2", _enemyCounts.get(2));
			} else {
				level_hud.setEnemyC("2", _enemyCounts.get(2));
			}
		}
	}
}
