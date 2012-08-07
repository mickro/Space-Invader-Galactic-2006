import classes.*;

class classes.Game {
	private var marging:Number;
	private var padding:Number;
	private var __heigth:Number;
	private var __width:Number;
	
	private var layer:MovieClip;
	private var player:Player;
	private var computer:Computer;
	private var screen:Screen;
	private var size:Number;
	
	public function Game(layer:MovieClip) {
		var music:Music = new Music();
		this.layer = layer;
		size = 32;
		initInterfaceUser();
		initScreen();
		initPlayer();
		initComputer();
		player.weapon.addListener(computer);
		computer.weapon.addListener(player);
		computer.addListener(player.weapon);
		//var maClasse:TestClasse = new TestClasse();
	}
	
	private function initInterfaceUser():Void {
		marging = 8;
		padding = 8;
		__width = 550;
		__heigth = 400;
		layer.createEmptyMovieClip("userInterface", 10);
		draw(layer.userInterface);
		write(layer, 100);
	}
	
	private function initScreen():Void {
		layer.createEmptyMovieClip("screen", 20);
		screen = new Screen(layer.screen, size,  __width, __heigth);
	}
	
	private function initPlayer():Void {
		var weapon:Weapon = new Weapon(
			layer.createEmptyMovieClip("shot", 60),
			marging + padding,
			-8);
		weapon.addListener(screen);
		
		layer.createEmptyMovieClip("player", 50);
		var border:Number = marging + padding;
		var zoneGame:Object = {
			rightLimit :  __width - border,
			leftLimit : border,
			vPos : __heigth - border
		};
		player = new Player(layer.player, 
					zoneGame.rightLimit,
					zoneGame.leftLimit,
					zoneGame.vPos,
					weapon,
					size);
	}
	
	private function initComputer():Void {
		var weapon:Weapon = new Weapon(
			layer.createEmptyMovieClip("shot", 70),
			marging + padding,
			8);
		weapon.addListener(screen);
		
		layer.createEmptyMovieClip("computer", 80);
		var border:Number = marging + padding;
		var zoneGame:Object = {
			rightLimit : __width - border,
			leftLimit : border,
			vPos :  border
		};
		
		computer = new Computer(layer.computer, 
					zoneGame.rightLimit,
					zoneGame.leftLimit,
					zoneGame.vPos,
					weapon,
					size);
	}
	
	public function draw(target:MovieClip):Void {
		setBackground(target, 0);
		drawBorder(target, 10);
		
	}
	
	public function setBackground(target:MovieClip, level:Number):Void {
		target.createEmptyMovieClip("background", level);
		target.background.beginFill(0x202020, 100);
		target.background.moveTo(0,0);
		target.background.lineTo(__width, 0);
		target.background.lineTo(__width, __heigth);
		target.background.lineTo(0, __heigth);
		target.background.lineTo(0, 0);
		target.background.endFill();
	}
	
	public function drawBorder(target:MovieClip, level:Number):Void {
		target.createEmptyMovieClip("border", level);
		target.border.lineStyle(1, 0x80FF40, 100);
		target.border.moveTo(marging,marging);
		target.border.lineTo(marging, __heigth - marging);
		target.border.lineTo(__width - marging, __heigth - marging);
		target.border.lineTo(__width - marging, marging);
		target.border.lineTo(marging, marging);
	}
	
	public function write(target:MovieClip, level:Number):Void {
		target.createEmptyMovieClip("console", level);
		var border:Number = marging + padding;
		target.console.createTextField("log", 10, border, border, __heigth - border, __width - border);
		var textField:TextField = target.console.log;
		textField.embedFonts = true;
		textField.selectable = false;
		
		var font:TextFormat = new TextFormat();
		font.font = "Computer";
		font.size = 8;
		font.color = 0x80FF40;
		
		textField.setNewTextFormat(font);
		
		puts(textField, "Space invaders galatic - 2006");
	}
	
	public function puts(textField:TextField, text:String):Void {
		textField.text = [text, textField.text].join("\n");
	}
}
