import classes.*;

class classes.Computer {
	private var sprites:Array;
	private var layer:MovieClip;
	
	private var rightLimit:Number;
	private var leftLimit:Number;
		
	private var size:Number;
	public var weapon:Weapon;
		
	private var tempo:Number;
	public var freashInvert:Boolean;
	public var time:Number;
		
	private var increment:Function;
	private var outOfBound:Function;
		
	private var shotLayer:MovieClip;
	private var listeners:Array;
		
	public function Computer(layer:MovieClip, rightLimit:Number, leftLimit:Number, y:Number, weapon:Weapon, size:Number) {
		this.layer = layer;
		this.weapon = weapon;
		this.size = size;
		
		this.time = 0;
		
		var columnsCount:Number = 5;
		var linesCount:Number = 3;
		
		listeners = new Array();
		
		sprites = new Array();
		var digit:Array =
		[
			["A", "B"],
			["C", "D"],
			["E", "F"]
		];
		var level:Number= 0;
		for (var line:Number = 0; line < linesCount; line ++) {
			for (var col:Number = 0; col < columnsCount; col ++) {
				level ++;
				var mc:MovieClip = layer.createEmptyMovieClip("invader" + level, level);
				/// NOTE : essayer de ne plus utiliser le concat()
				sprites.push(new Invader(mc, col, line, digit[line].concat(), size));
			}
		}
		
		setBounds(rightLimit, leftLimit, y);
		
		increment = moveRight;
		outOfBound = rightWall;
		
		start();
	}
	
	public function start() : Void
	{
		clearInterval(tempo);
		/// TODO : utiliser la forme : setInterval(this, "move", 1000);
		
		
		tempo = setInterval(this.play, 500, this);
		Main.log("tempo : " + tempo);
	}

	public function stop() : Void
	{
		clearInterval(tempo);
	}
	
	private function setBounds(rightLimit:Number, leftLimit:Number, y:Number):Void {
		
		this.rightLimit = rightLimit - size;
		this.leftLimit = leftLimit + size;
		
		Main.log("right limit : " + this.rightLimit);
		Main.log("leftLimit : " + this.leftLimit);
		
		this.layer._x = leftLimit;
		this.layer._y = y;
	}
	
	private function draw(x:Number, y:Number):MovieClip {
		var name:String = "contener" + x + y;
		var level:Number = layer.getNextHighestDepth()
		layer.createTextField(name, level, 0, 0, size, size);
		layer[name]._x = size * x;
		layer[name]._y = size * y;
		
		var textField:TextField = layer[name];
		textField.embedFonts = true;
		textField.selectable = false;
		
		var font:TextFormat = new TextFormat();
		font.font = "Invaders";
		font.size = size / 2;
		font.color = 0xFF4080;
		
		textField.setNewTextFormat(font);
		
		textField.text = "A";

		return layer[name];
	}
	
	private function play(owner:Computer):Void {
		/// TODO : faire disparaitre owner
		owner.time ++;
		
		owner.updateInvaders();
		
		if (owner.time == 2)
		{
			owner.time = 0;
			owner.move();
		}
	}
	
	public function updateInvaders():Void
	{
		for (var i:String in this.sprites)
		{
			if (this.sprites[i].alive)
			{
				this.sprites[i].move();
			}
			else
			{
				var k:Number = Number(i);
				var myInvader:Invader = this.sprites[i];
				this.sprites.slice(k);
				myInvader.layer.removeMovieClip();
				delete myInvader;
			}
		}
	}
	
	public function move():Void {
		if (this.freashInvert) {
			this.moveDown();
			this.freashInvert = false;
		}
		else
		{
			if (this.outOfBound(this.increment())) {
				this.invertMove();
			}
		}
	}
	
	public function invertMove():Void {
		if (increment == moveRight) {
			increment = moveLeft;
			outOfBound = leftWall;
		} else {
			increment = moveRight;
			outOfBound = rightWall;
		}
		freashInvert = true;
	}
	
	public function moveRight():Number {
		Main.log ("right >>>>");
		layer._x += size;
		return layer._x + layer._width;
	}
	
	public function moveLeft():Number {
		Main.log ("left <<<<<");
		layer._x -= size;
		return layer._x;
	}
	
	public function rightWall(x:Number):Boolean {
		return x > rightLimit;
	}

	public function leftWall(x:Number):Boolean {	
		return x < leftLimit;
	}
	
	public function moveDown():Number {
		Main.log ("down vvvv");
		layer._y += size;
		return layer._y + layer._height;
	}
	
	public function onShotMove(mcShot:MovieClip):Void {
		Main.log("Player attack !");
		if (layer.hitTest(mcShot))
		{
			for (var i:String in this.sprites)
			{
				var myInvader:Invader = this.sprites[i];
				if (myInvader.layer.hitTest(mcShot)) {
					myInvader.die();
					dispatchShotStopped();
					break;
				}
			}
		}
	}
	
	public function addListener(listener:Object):Void {
		this.listeners.push(listener);
	}
	
	public function removeListener(listener:Object):Void {
		for (var i:Number = 0; i <listeners.length; i++) {
			if (listeners[i] === listener) {
				listeners.splice(i, 1);
			}
		}
	}
	
	private function dispatchShotStopped():Void {
		for (var l in listeners) {
			listeners[l].onShotStopped();
		}
	}
}
