import classes.*;

class classes.Player {
	private var sprite2006:MovieClip;
	private var sprite1978:MovieClip;
	private var layer:MovieClip;
	
	private var rightLimit:Number;
	private var leftLimit:Number;
		
	private var size:Number;
	public  var weapon:Weapon;
		
	public function Player(layer:MovieClip, rightLimit:Number, leftLimit:Number, y:Number, weapon:Weapon, size:Number) {
		this.layer = layer;
		this.weapon = weapon;
		this.size = size;
		sprite1978 = layer.createEmptyMovieClip("sprite1978", 20);
		sprite2006 = layer.createEmptyMovieClip("sprite2006", 10);
		setBounds(rightLimit, leftLimit, y);
		draw2006(sprite2006);
		draw1978(sprite1978);
		Mouse.addListener(this);
		Key.addListener(this);
	}
	
	public function onMouseMove():Void {
		moveTo(layer._xmouse);
	}
	
	public function onMouseDown():Void {
		shot();
	}
	
	public function onKeyDown() {
		if (Key.isDown(Key.LEFT)) {
			moveLeft();
		}
		if (Key.isDown(Key.RIGHT)) {
			moveRight();
		}
		if (Key.isDown(Key.SPACE)) {
			shot();
		}
	}
	
	private function draw2006(target:MovieClip):Void {
		target.createEmptyMovieClip("contener", 10);
		target.contener._x = - size / 2;
		target.contener.clear();
		target.contener.lineStyle(0.1, 0x80FF40, 9);
		target.contener.moveTo(0,0);
		target.contener.lineTo(0, size);
		target.contener.lineTo(size,size);
		target.contener.lineTo(size, 0);
		target.contener.lineTo(0,0);
	}
	
	private function draw1978(target:MovieClip):Void {
		target.createTextField("contener", 0, 0, 0, size, size);
		target.contener._x = size / 8;
		target.contener._y = size / 3;
		
		var textField:TextField = target.contener;
		textField.embedFonts = true;
		textField.selectable = false;
		
		var font:TextFormat = new TextFormat();
		font.font = "Invaders";
		font.size = size / 2;
		font.color = 0x4080FF;
		
		textField.setNewTextFormat(font);
		
		textField.text = "-";
	}
	
	private function setBounds(rightLimit:Number, leftLimit:Number, y:Number):Void {
		this.rightLimit = rightLimit - size;
		this.leftLimit = leftLimit;
		
		sprite1978._y  = sprite2006._y = y - size;
		sprite1978._x = sprite2006._x = leftLimit;
	}
	
	private function inBounds(x:Number, rightLimit:Number):Number {
		if (x > rightLimit) {
			x = rightLimit;
		}
		
		if (x < leftLimit) {
			x = leftLimit;
		}
		return x;
	}
	
	private function shot():Void {
		weapon.shot(sprite1978._x + size / 2, sprite1978._y);
	}
	
	private function moveTo(x:Number):Void {
		x = inBounds(x, rightLimit);
		sprite2006._x = x;
		
		var decalage:Number = (x - leftLimit) % size;
		sprite1978._x = Math.floor(x - decalage);
		Main.log(decalage.toString());
	}
	
	private function moveLeft():Void {
		sprite1978._x = inBounds(sprite1978._x - size, rightLimit);
	}
	
	private function moveRight():Void {
		sprite1978._x = inBounds(sprite1978._x + size, rightLimit);
	}
}
