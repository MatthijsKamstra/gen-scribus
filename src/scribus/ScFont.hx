package scribus;

class ScFont {
	var name:String;
	var fontsize:Int;

	public function new(name:String, fontsize:Int) {
		trace('ScFont');
		this.name = name;
		this.fontsize = fontsize;
	}

	public function toString():String {
		return '<CHARSTYLE
			CNAME="Default Character Style"
			DefaultStyle="1"
			FONT="${name}"
			FONTSIZE="${fontsize}"
			FONTFEATURES=""
			FEATURES="inherit"
			FCOLOR="Black"
			FSHADE="100"
			HyphenWordMin="3"
			SCOLOR="Black"
			BGCOLOR="None"
			BGSHADE="100"
			SSHADE="100"
			TXTSHX="5"
			TXTSHY="-5"
			TXTOUT="1"
			TXTULP="-0.1"
			TXTULW="-0.1"
			TXTSTP="-0.1"
			TXTSTW="-0.1"
			SCALEH="100"
			SCALEV="100"
			BASEO="0"
			KERN="0"
			LANGUAGE="en_GB"/>\n';
	}
}
