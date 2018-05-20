package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
using flixel.util.FlxSpriteUtil;

class Pre_HUD extends FlxTypedGroup<FlxSprite> {
    // Top
    var _sprBack:FlxSprite;
    var _txtShop:FlxText;
    var _txtAuto:FlxText;
    var _txtManual:FlxText;
    public var _btnPurchaseBasicTower:FlxButton;
    public var _btnPurchaseDartTower:FlxButton;
    var _txtMoney:FlxText;
    public var money:Int;
    var _txtMoneyHeader:FlxText;

    // Bottom
    var _sprBack2:FlxSprite;
    var _txtTowerSelect:FlxText;
    var _sprTowerSelect:FlxSprite;

    var _sprSelectedTower:FlxSprite;
    var _selectedTowerRef:Tower;
    var _selectedTowerType:Int;

    // Upgrades
    public var _upgradeButtons:List<FlxButton>;
    var _txtUpgrade:FlxText;
    var _txtUpRange:FlxText;
    var _txtUpDamage:FlxText;
    var _txtUpFrequency:FlxText;
    var _txtUpgradeCost:FlxText;

    var _btnDestroy:FlxButton;
    var bottomY:Int = FlxG.height - 48;
    var bottomX:Int = -64;

    var levelNum:Int = -1;
    public function new(levelNum:Int) {
        super();
        this.levelNum = levelNum;
        // Shop menu
        var width:Int = FlxG.width + 128;
        _sprBack = new FlxSprite(-64, -48).makeGraphic(FlxG.width + 128, 80, FlxColor.BROWN);
        _sprBack.drawRect(0, 0, width, 1, FlxColor.WHITE);
        _sprBack.drawRect(0, 79, width, 1, FlxColor.WHITE);
        _sprBack.drawRect(0, 0, 1, width, FlxColor.WHITE);
        _sprBack.drawRect(width-1, 0, 1, width, FlxColor.WHITE);

        _txtMoney = new OpenFlxText(486, -26, 0, "$", 20);
        _txtMoney.color = FlxColor.YELLOW;
        _txtMoney.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtMoneyHeader = new OpenFlxText(470, -40, 0, "Money", 16);
        _txtMoneyHeader.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtShop = new OpenFlxText(-48, -25, 0, "Shop", 24);
        _txtShop.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);

        _txtAuto = new OpenFlxText(42, -26, 0, "Auto Towers:", 10);
        _txtAuto.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtManual = new OpenFlxText(42, 8, 0, "Manual Towers:", 10);
        _txtManual.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);

        add(_sprBack);
        add(_txtMoney);
        add(_txtMoneyHeader);
        add(_txtShop);
        add(_txtAuto);
        add(_txtManual);

        setBasicTower(levelNum);
        //setDartTower(levelNum);

        // ==============================================================
        // Upgrade menu
        // ==============================================================
        _sprBack2 = new FlxSprite(-64, bottomY).makeGraphic(FlxG.width + 128, 96, FlxColor.BROWN);
        _sprBack2.drawRect(0, 0, width, 1, FlxColor.WHITE);
        _sprBack2.drawRect(0, 95, width, 1, FlxColor.WHITE);
        _sprBack2.drawRect(0, 0, 1, width, FlxColor.WHITE);
        _sprBack2.drawRect(width-1, 0, 1, width, FlxColor.WHITE);
        add(_sprBack2);

        _sprTowerSelect = new FlxSprite(bottomX + 20, bottomY + 8, "assets/images/tower_select_outline.png");
        add(_sprTowerSelect);

        _txtTowerSelect = new OpenFlxText(bottomX + 8, bottomY + 76, 0, "Selected Tower", 10);
        _txtTowerSelect.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        add(_txtTowerSelect);

        _upgradeButtons = new List<FlxButton>();
        var _range:FlxButton = new FlxButton(bottomX + 205, FlxG.height - 8, "Range Up", upgradeRange);
        var _damage:FlxButton = new FlxButton(bottomX + 305, FlxG.height- 8, "Damage Up", upgradeDamage);
        var _frequency:FlxButton = new FlxButton(bottomX + 405, FlxG.height- 8, "Fire-Rate Up", upgradeFrequency);
        _upgradeButtons.add(_range); _upgradeButtons.add(_damage); _upgradeButtons.add(_frequency);

        _txtUpgrade = new OpenFlxText(bottomX + 108, FlxG.height - 16, 0, "Upgrade Cost:", 10);
        _txtUpgrade.color = FlxColor.YELLOW;
        _txtUpgrade.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtUpRange = new OpenFlxText(bottomX + 205, FlxG.height + 16, 0, "Level:", 10);
        _txtUpRange.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtUpDamage = new OpenFlxText(bottomX + 305, FlxG.height + 16, 0, "Level:", 10);
        _txtUpDamage.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtUpFrequency = new OpenFlxText(bottomX + 405, FlxG.height + 16, 0, "Level:", 10);
        _txtUpFrequency.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtUpgradeCost = new OpenFlxText(bottomX + 124, FlxG.height + 8, 0, "$10", 16);
        _txtUpgradeCost.setBorderStyle(OUTLINE, FlxColor.RED, 1);

        add(_txtUpgrade);
        add(_txtUpRange);
        add(_txtUpDamage);
        add(_txtUpFrequency);
        add(_txtUpgradeCost);

        add(_range);
        add(_damage);
        add(_frequency);
        killButtons();

        forEach(function(spr:FlxSprite) {
            spr.scrollFactor.set(0, 0);
        });
    }

    public function setupButtons() {
        if (levelNum >= -5) return;
        for(i in _upgradeButtons) {
            i.revive();
        }
        _txtUpgrade.revive();
        setUpgradeText();
    }
    public function killButtons() {
        for(i in _upgradeButtons) {
            i.kill();
        }
        _txtUpgrade.kill();
        _txtUpFrequency.kill();
        _txtUpRange.kill();
        _txtUpDamage.kill();
        _txtUpgradeCost.kill();

    }

    public function setUpgradeText() {
        _txtUpRange.destroy(); _txtUpDamage.destroy(); _txtUpFrequency.destroy(); _txtUpgradeCost.destroy();
        _txtUpRange = new OpenFlxText(bottomX + 280, FlxG.height + 80, 0, "Level: " + _selectedTowerRef.rangeLvl, 10);
        _txtUpRange.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtUpDamage = new OpenFlxText(bottomX + 380, FlxG.height + 80, 0, "Level: " + _selectedTowerRef.damageLvl, 10);
        _txtUpDamage.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtUpFrequency = new OpenFlxText(bottomX + 480, FlxG.height + 80, 0, "Level: " + _selectedTowerRef.frequencyLvl, 10);
        _txtUpFrequency.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        _txtUpgradeCost = new OpenFlxText(bottomX + 200, FlxG.height + 72, 0, "$" + _selectedTowerRef.getUpgradeCost(), 16);
        _txtUpgradeCost.setBorderStyle(OUTLINE, FlxColor.RED, 1);
        add(_txtUpRange); add(_txtUpFrequency); add(_txtUpDamage); add(_txtUpgradeCost);
    }

    private function upgradeRange() {
        if (money >= _selectedTowerRef.getUpgradeCost()) {
            money -= _selectedTowerRef.getUpgradeCost();
            setMoney(money);
            _selectedTowerRef.upgradeRange();
            setUpgradeText();
        }
    }

    private function upgradeDamage() {
        if (money >= _selectedTowerRef.getUpgradeCost()) {
            money -= _selectedTowerRef.getUpgradeCost();
            setMoney(money);
            _selectedTowerRef.upgradeDamage();
            setUpgradeText();
        }
    }

    private function upgradeFrequency() {
        if (money >= _selectedTowerRef.getUpgradeCost()) {
            money -= _selectedTowerRef.getUpgradeCost();
            setMoney(money);
            _selectedTowerRef.upgradeFrequency();
            setUpgradeText();
        }
    }

    // Sets tower image
    public function setSelectedTower(type:Int) {
        if (_sprSelectedTower != null) _sprSelectedTower.destroy();
        //trace("Selected tower" + type);
        _selectedTowerType = type;
        _sprSelectedTower = new FlxSprite(bottomX + 20, bottomY + 8, "assets/images/tower_icon_" + type + ".png");
        add(_sprSelectedTower);
        _sprSelectedTower.scrollFactor.set(0, 0);
    }

    public function getSelectedTowerType() {
        return _selectedTowerType;
    }

    public function getTowerRange() {
        return _selectedTowerRef.range;
    }

    public function setSelectedTowerReference(t:Tower) {
        _selectedTowerRef = t;
        setSelectedTower(t.type);
        setupButtons();
        //_btnDestroy = new FlxButton()
    }

    public function deselectTower() {
        _selectedTowerRef = null;
        if (_sprSelectedTower != null) _sprSelectedTower.kill();
        _selectedTowerType = null;
    }

    public function setMoney(amount:Int) {
        _txtMoney.destroy();
        _txtMoney = new OpenFlxText(470, -8, 0, "$" + amount, 20);
        _txtMoney.color = FlxColor.YELLOW;
        _txtMoney.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
        add(_txtMoney);
        _txtMoney.scrollFactor.set(0, 0);
        money = amount;
    }

    public function setBasicTower(levelNum:Int) {
        // Only set up if on stage with towers available
        if (!(levelNum < 0 && levelNum > -4)) {
            _btnPurchaseBasicTower = new FlxButton(144, -36, "$50");
            _btnPurchaseBasicTower.loadGraphic("assets/images/tower_0_btn.png", true, 32, 32);
            _btnPurchaseBasicTower.label.offset.x -= 32;
            _btnPurchaseBasicTower.label.offset.y -= 4;
            _btnPurchaseBasicTower.label.color = 0xd3d3d3;
            _btnPurchaseBasicTower.label.size = 10;
            add(_btnPurchaseBasicTower);
        }
    }

    public function setDartTower(levelNum:Int) {
        // Only set up if on stage with towers available
        if (levelNum <= -7) {
            _btnPurchaseDartTower = new FlxButton(216, -36, "$100");
            _btnPurchaseDartTower.loadGraphic("assets/images/tower_1_btn.png", true, 32, 32);
            _btnPurchaseDartTower.label.offset.x -= 32;
            _btnPurchaseDartTower.label.offset.y -= 4;
            _btnPurchaseDartTower.label.color = 0xd3d3d3;
            _btnPurchaseDartTower.label.size = 10;
            add(_btnPurchaseDartTower);
        }
    }
}