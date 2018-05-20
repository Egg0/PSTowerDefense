package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Tower extends FlxSprite
{
	public var isFiring:Bool;
    public var atkCd:Int;
    public var CD:Int = 90;
    public var damage:Int = 50;
    public var targetedEnemy:Enemy;
    public var range:Int = 64;
    public static var BASE_RANGE:Int = 64;
	public var upgrades:Int = 1;
	public var BASE_UPGRADE_COST:Int = 8;
	public var pierces:Bool = false;
	public var type:Int;
	public var rangeLvl:Int = 1;
	public var damageLvl:Int = 1;
	public var frequencyLvl:Int = 1;
	
	/**
	 * Create a new tower at X and Y with default range, fire rate, and damage; create this tower's indicator.
	 */
	public function new(X:Float, Y:Float, path:String, type:Int)
	{
		super(X, Y, "assets/images/tower_" + type + ".png");
		
        setSize(32, 32);
        targetedEnemy = null;
		atkCd = 0;
		this.type = type;
		/*_indicator = new FlxSprite(getMidpoint().x - 1, getMidpoint().y - 1);
		_indicator.makeGraphic(2, 2);
		Reg.PS.towerIndicators.add(_indicator);
		
		_initialCost = Cost;*/
	}
	
	/**
	 * The tower's update function just checks if there's an enemy nearby; if so, the indicator "charges"
	 * by slowly increasing its alpha; once the shootCounter has reached the required level, a bullet is
	 * shot.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (atkCd > 0)
            atkCd--;
	}
	
	
	
	/**
	 * Shoots a bullet!
	 */
	public function shoot(bullets:FlxTypedGroup<Bullet>):Void
	{
		if (targetedEnemy == null || atkCd != 0)
			return;
		var bullet = bullets.recycle(Bullet.new);
		var midpoint = getMidpoint();
		bullet.init(midpoint.x, midpoint.y, targetedEnemy, pierces ? Std.int(damage / 10.0) : damage, pierces);
		midpoint.put();
		bullets.add(bullet);
		
		atkCd += CD;
	}
	
	/**
	 * Goes through the entire enemy group and returns the first non-null enemy within range of this tower.
	 * 
	 * @return	The first enemy that is not null, in range, and alive. Returns null if none found.
	 */
	public function setNearestEnemy(enemies:FlxTypedGroup<Enemy>, enemies2:FlxTypedGroup<Enemy>):Void
	{
		targetedEnemy = null;
		var distance:Float = 9999;
		for (enemy in enemies)
		{
			if (enemy != null && enemy.alive && !enemy.isSneaky)
			{
				distance = getPosition().distanceTo(enemy.getPosition());
				if (distance <= range)
				{
					targetedEnemy = enemy;
					return;
				}
			}
		}
		
		for (enemy in enemies2)
		{
			if (enemy != null && enemy.alive && !enemy.isSneaky)
			{
				distance = getPosition().distanceTo(enemy.getPosition());
				if (distance <= range)
				{
					targetedEnemy = enemy;
					return;
				}
			}
		}
	}

	public function upgradeRange():Void {
		range += 16;
		//TODO: Also increase circle size for this tower
		upgrades++;
		rangeLvl++;
	}

    public function upgradeDamage():Void {
		damage += 20;
		upgrades++;
		damageLvl++;
	}

	public function upgradeFrequency():Void {
		CD = Std.int(CD * 0.8);
		upgrades++;
		frequencyLvl++;
	}

	public function getUpgradeCost():Int {
		return BASE_UPGRADE_COST * upgrades;
	}
}
