import classes.*;

class classes.Weapon extends MovieClip {
	private var verticalLimit:Number;
	private var layer:MovieClip;
	private var inc:Number;

	private var shotLayer:MovieClip;
	private var listeners:Array;

	private var _y;
	private var int_move:Number;
		
	private var outOfBound:Function ;
	
	public function Weapon(layer:MovieClip, verticalLimit:Number, inc:Number) {
		this.layer = layer;
		this.verticalLimit = verticalLimit;
		this.inc = inc;
		if (inc < 0) {
			outOfBound = function(y:Number):Boolean {
				return y <= verticalLimit;
			}
		} else {
			outOfBound = function(y:Number):Boolean {
				return y >= verticalLimit;
			}
		}
		listeners = new Array();
	}

	public function shot(x:Number, y:Number):Void {
		if (!shotLayer._x) {
			var level:Number = layer.getNextHighestDepth();
			shotLayer = layer.createEmptyMovieClip("shot" + level, 10);
			shotLayer._x = x;
			shotLayer._y = y;
			draw(shotLayer);
			int_move = setInterval(this, "move", 25);
		}
	}
	
	private function draw(target:MovieClip):Void {
		target.clear();
		target.lineStyle(1, 0x4080FF, 100);
		target.beginFill(0xFF8040, 100);
		target.moveTo(0,0);
		target.lineTo(0, 8);
		target.lineTo(4,8);
		target.lineTo(4, 0);
		target.lineTo(0,0);
	}
	
	private function move():Void {
		shotLayer._y += inc;
		if (outOfBound(shotLayer._y)) {
			stop();
		}
		dispatchShotMove(shotLayer);
	}
	
	public function stop():Void {
		shotLayer.removeMovieClip();
		clearInterval(int_move);
		dispatchShotStoped();
	}
	
	public function onShotStopped() {
		stop();
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
	
	private function dispatchShotMove(shotLayer:MovieClip):Void {
		for (var l in listeners) {
			listeners[l].onShotMove(shotLayer);
		}
	}
	
	private function dispatchShotStoped():Void {
		for (var l:String in listeners) {
			trace("weapon.listener  : " + listeners[l]);
			listeners[l].onShotStoped();
		}
	}
}