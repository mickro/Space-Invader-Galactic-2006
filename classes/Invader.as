import classes.*;

class classes.Invader {
	public var layer:MovieClip;
	private var sprites:Array;
	public var textField:TextField;
	private var size:Number;
	public var alive:Boolean;
	public var fontName:String;
		
	private var x:Number;
	private var y:Number;
		
	public function Invader(target:MovieClip, x:Number, y:Number, sprites:Array, size:Number) {
		this.layer = target;
		this.sprites = sprites;
		this.size = size;
		this.alive = true;
		this.fontName = "Invaders";
		this.x = x;
		this.y = y;
		draw(x, y);
		move();
	}
	
	private function draw(x:Number, y:Number):Void {
		var name:String = "contener" + x + y;
		var level:Number = 0;
		layer.createTextField(name, level, 0, 0, size, size);
		layer[name]._x = size * x;
		layer[name]._y = size * y;
		
		textField = layer[name];
		textField.embedFonts = true;
		textField.selectable = false;
		
		var font:TextFormat = new TextFormat();
		font.font = this.fontName;
		font.size = size / 2;
		font.color = 0xFF4080;
		
		textField.setNewTextFormat(font);
	}
	
	private function nextSprite():String {
		var n:String = String(this.sprites.shift());
		this.sprites.push(n);
		return n;
	}
	
	public function move():Void {
		this.textField.text = this.nextSprite();
		if (this.textField.text == "g")
		{
			this.draw(this.x, this.y);
			this.textField.text = "g";
			this.alive = false;
		}
	}
	
	public function die():Void {
		Main.log("die");
		this.sprites = new Array();
		this.sprites.push("g");
		this.fontName = "Invaders2";
	}
}