import classes.*;

class classes.TestClasse {
	 private var idInterval:Number;
	 public function TestClasse() {
	   start();
	}
	
	public function start():Void {
	  stop();
	  idInterval = setInterval(this.move, 1000);
	  Main.log("he ho ! I'am an " + this);
	}
	
	public function stop():Void {
	  clearInterval(idInterval);
	}
	
	public function move():Void {
	   Main.log("he ho ! I'am an " + this);
	}
}
