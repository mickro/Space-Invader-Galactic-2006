import classes.*;

class Main {
	private static var console:TextField;
	private static var history:Array;
		
	function Main() {
		_root.createEmptyMovieClip("game", 10);
		var game = new Game(_root.game);
	}
	
	static function main():Void {
		createConsole();
		var application = new Main();
	}
	
	private static function createConsole():Void
	{
		history = new Array();
		_root.createTextField("console", 100, 0, 350, 540, 50);
		var textField:TextField = console = _root.console;;
		textField.embedFonts = true;
		textField.selectable = false;
		var font:TextFormat = new TextFormat();
		font.font = "Computer";
		font.size = 6;
		font.color = 0xA0A0A0;
		textField.setNewTextFormat(font);
	}
	
	
	public static function log(text:String):Void {
		history.unshift(text);
		history= history.slice(0, 7);
		console.text = history.join("\n");
	}
}
