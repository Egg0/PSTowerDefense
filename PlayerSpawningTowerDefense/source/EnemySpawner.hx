package ;


import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;

// Takes an array of integers (enemy types), spawn coordinates, and tent location, and
// will create a public FlxTypedGroup of enemies for playstate to track
class EnemySpawner {
    public var spawn:FlxPoint;
    public var tent:FlxPoint;
    private var map:FlxTilemap;
    private var speed:Float;

    private var enemyHealth:Float;
    private var enemyQueue:Array<Enemy> = [];
    public var spawnedEnemies:FlxTypedGroup<Enemy> = new FlxTypedGroup<Enemy>();

    public function new(map:FlxTilemap, health:Float) {
        this.map = map;
        this.enemyHealth = health;
    }

    public function setSpawnCoords(x:Int, y:Int) {
        this.spawn = new FlxPoint(x, y);
    }

    public function setTentCoords(x:Int, y:Int) {
        this.tent = new FlxPoint(x, y);
    }

    public function setSpeed(speed:Float) {
        this.speed = speed;
    }

    // Takes a int representing enemy type and an int representing count and adds it to enemyQueue
    public function addToQueue(enemyType:Int, count:Int):Void {
        for (i in 0...count) {
            if (enemyType == 0) enemyQueue.push(new Enemy(spawn.x, spawn.y, enemyHealth, speed));
            if (enemyType == 1) enemyQueue.push(new AggressiveEnemy(spawn.x, spawn.y, enemyHealth, speed));
            if (enemyType == 2) enemyQueue.push(new SneakyEnemy(spawn.x, spawn.y, enemyHealth, speed));
        }
    }

    // Spawns the next enemy in the list if there are any
    // Returns a reference to the spawned enemy if any
    public function spawnEnemy():Enemy {
        if (enemyQueue.length == 0) return null;

        var enemy:Enemy = enemyQueue.shift();
        spawnedEnemies.add(enemy);
        enemy.followPath(map.findPath(spawn, tent), null);
        return enemy;
    }
}
