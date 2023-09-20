package scribus;

/**

	<CHARSTYLE CNAME="Default Character Style" DefaultStyle="1" FONT="Titillium Web Regular" FONTSIZE="11" FONTFEATURES="" FEATURES="inherit" FCOLOR="Black" FSHADE="100" HyphenWordMin="3" SCOLOR="Black" BGCOLOR="None" BGSHADE="100" SSHADE="100" TXTSHX="5" TXTSHY="-5" TXTOUT="1" TXTULP="-0.1" TXTULW="-0.1" TXTSTP="-0.1" TXTSTW="-0.1" SCALEH="100" SCALEV="100" BASEO="0" KERN="0" LANGUAGE="en_GB"/>
	<CHARSTYLE CNAME="Bold_GenByMck" CPARENT="Default Character Style" FONT="Titillium Web Bold"/>
	<CHARSTYLE CNAME="BoldItalic_GenByMck" CPARENT="Default Character Style" FONT="Titillium Web Bold Italic"/>
	<CHARSTYLE CNAME="Italic_GenByMck" CPARENT="Default Character Style" FONT="Titillium Web Italic"/>
	<CHARSTYLE CNAME="red" CPARENT="Default Character Style"/>
 */
class ScStyleDefault {
	var name:String = '';

	public function new(name:String) {
		this.name = name;
	}

	public function toString() {
		return '<STYLE
			NAME="${name}"
			DefaultStyle="1"
			ALIGN="0"
			DIRECTION="0"
			LINESPMode="0"
			LINESP="15"
			INDENT="0"
			RMARGIN="0"
			FIRST="0"
			VOR="0"
			NACH="0"
			ParagraphEffectOffset="0"
			DROP="0"
			DROPLIN="2"
			Bullet="0"
			Numeration="0"
			HyphenConsecutiveLines="2"
			BCOLOR="None"
			BSHADE="100"
			CPARENT="Default Character Style"/>\n';
	}
}
