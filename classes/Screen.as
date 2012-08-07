import classes.*;

class classes.Screen {
		private var layer:MovieClip;
		private var size:Number;
		private var left:Number;
		private var bottom:Number;

	public function Screen(layer:MovieClip, size:Number, left:Number, bottom:Number) {
		this.layer = layer;
		this.size =size;
		this.left = left;
		this.bottom = bottom;

		this.layer.createEmptyMovieClip("table", 10);
		draw(this.layer.table);
		this.layer.	attachMovie("fond", "bkg", 15);
		this.layer.createEmptyMovieClip("mask", 20);
		var target:MovieClip = layer.mask;
		target.beginFill(0xFF8040, 100);
		target.moveTo(-size / 2,-size / 3);
		target.lineTo(size, - size / 3);
		target.lineTo(size / 2,100);
		target.lineTo(-size / 2, size / 3);
		target.lineTo(-size / 3,-size / 3);
		target.endFill();
		this.layer.table.setMask(this.layer.mask);
		this.layer.bkg._alpha = 5;
		initMaskPos();
	}
	
	private function draw(target:MovieClip):Void {
		target.clear();
		target.lineStyle(1, 0x80FF40, 14);

		for (var x:Number = size; x < left; x += size) {
			var y:Number = 0; 
			target.moveTo(x, y);
			y = bottom;
			target.lineTo(x, y);
		}
		
		for (var y:Number = size; y < bottom; y += size) {
			var x:Number = 0; 
			target.moveTo(x, y);
			x = left;
			target.lineTo(x, y);
		}
	}
	
	public function onShotMove(mcShot:MovieClip):Void {
//		Main.log(x.toString() + " : " + y.toString());
		layer.mask._x =mcShot._x - 10;
		layer.mask._y = mcShot._y - 10;
	}
	
	public function onShotStoped():Void {
		Main.log("stoped!");
		initMaskPos();
	}
	
	private function initMaskPos():Void {
		layer.mask._x = - 100;
		layer.mask._y = - 100;
	}
}