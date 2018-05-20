package;

class PlayerStats {
    public var damage:Float;
	public var upgrades:Int = 1;
	public var BASE_UPGRADE_COST:Int = 8;

    private var _damage:Float;
    private var _upgrades:Int;

    public function new() {
        damage = 50;
    }

    public function upgradeDamage():Int {
        damage = damage * 1.2;
        upgrades++;
        return (upgrades-1) * BASE_UPGRADE_COST;
    }

    public function getUpgradeCost():Int {
        return upgrades * BASE_UPGRADE_COST;
    }

    public function setStartLevel():Void {
        _upgrades = upgrades;
        _damage = damage;
    }
    
    public function resetLevel():Void {
        upgrades = _upgrades;
        damage = _damage;
    }
}