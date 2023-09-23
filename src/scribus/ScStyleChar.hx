package scribus;

/**

	<CHARSTYLE CNAME="Default Character Style" DefaultStyle="1" FONT="Titillium Web Regular" FONTSIZE="11" FONTFEATURES="" FEATURES="inherit" FCOLOR="Black" FSHADE="100" HyphenWordMin="3" SCOLOR="Black" BGCOLOR="None" BGSHADE="100" SSHADE="100" TXTSHX="5" TXTSHY="-5" TXTOUT="1" TXTULP="-0.1" TXTULW="-0.1" TXTSTP="-0.1" TXTSTW="-0.1" SCALEH="100" SCALEV="100" BASEO="0" KERN="0" LANGUAGE="en_GB"/>
	<CHARSTYLE CNAME="Bold_GenByMck" CPARENT="Default Character Style" FONT="Titillium Web Bold"/>
	<CHARSTYLE CNAME="BoldItalic_GenByMck" CPARENT="Default Character Style" FONT="Titillium Web Bold Italic"/>
	<CHARSTYLE CNAME="Italic_GenByMck" CPARENT="Default Character Style" FONT="Titillium Web Italic"/>
	<CHARSTYLE CNAME="red" CPARENT="Default Character Style"/>
 */
class ScStyleChar {
	var name:String = '';
	var parent:String = '';
	var font:String = '';

	public function new(name:String, parent:String = "Default Paragraph Style", font:String = "") {
		this.name = name;
		this.parent = parent;
		this.font = font;
	}

	public function toString() {
		return '<CHARSTYLE
		CNAME="${name}"
		CPARENT="${parent}"
		FONT="${font}"
		/>\n';
	}
}
