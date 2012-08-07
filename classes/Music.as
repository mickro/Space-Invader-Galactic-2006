import classes.*;

class classes.Music {
	public function Music(){
		var playlist:Array = ["SPACEinvaders40bpmMp3.mp3", "SPACEinvaders90bpMP3.mp3", "SPACEinvaders61bpm.mp3"];
		/// BUG : file doesn't loading...
		//~ var path:String = "file:///home/mickro/Documents/devel/spaceInvaderGalatic/sound/";
		var path:String = "sound/";
		var i:Number = Math.floor(Math.random() * playlist.length);
		
		var songName:String = playlist[i];
		
		var currentMusic:Sound = new Sound();
		currentMusic.loadSound(path + songName, false);
		currentMusic.onSoundComplete = function ():Void {
			Main.log("music is completed");
			this.start(0, 99);
		}
		currentMusic.onLoad = function (success:Boolean):Void{
			Main.log("success : " + success);
			Main.log("music is loaded : " + this.duration);
			this.start(0, 99);
		}
		
		Main.log("music is launching... : " + path + songName);
	}
}