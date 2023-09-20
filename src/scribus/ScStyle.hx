package scribus;

class ScStyle {
	var name:String = '';
	var fontsize:Int = 12;
	var parent:String = 'Default Paragraph Style';

	public function new(name:String, fontsize:Int, parent:String = "Default Paragraph Style") {
		this.name = name;
		this.fontsize = fontsize;
		this.parent = parent;
	}

	/**
		<CHARSTYLE CNAME="Default Character Style" DefaultStyle="1" FONT="Arial Regular" FONTSIZE="12" FONTFEATURES="" FEATURES="inherit" FCOLOR="Black" FSHADE="100" HyphenWordMin="3" SCOLOR="Black" BGCOLOR="None" BGSHADE="100" SSHADE="100" TXTSHX="5" TXTSHY="-5" TXTOUT="1" TXTULP="-0.1" TXTULW="-0.1" TXTSTP="-0.1" TXTSTW="-0.1" SCALEH="100" SCALEV="100" BASEO="0" KERN="0" LANGUAGE="en_GB"/>
		<STYLE NAME="Default Paragraph Style" DefaultStyle="1" ALIGN="0" DIRECTION="0" LINESPMode="0" LINESP="15" INDENT="0" RMARGIN="0" FIRST="0" VOR="0" NACH="0" ParagraphEffectOffset="0" DROP="0" DROPLIN="2" Bullet="0" Numeration="0" HyphenConsecutiveLines="2" BCOLOR="None" BSHADE="100"/>
		<STYLE NAME="Text3_Heading 1" PARENT="Default Paragraph Style" LINESPMode="1" FONTSIZE="24"/>
		<STYLE NAME="Text3_Heading 2" PARENT="Default Paragraph Style" LINESPMode="1" FONTSIZE="22"/>
		<STYLE NAME="Text3_Heading 3" PARENT="Default Paragraph Style" LINESPMode="1" FONTSIZE="20"/>
		<STYLE NAME="Text3_Heading 4" PARENT="Default Paragraph Style" LINESPMode="1" FONTSIZE="18"/>
		<STYLE NAME="Text3_Heading 5" PARENT="Default Paragraph Style" LINESPMode="1" FONTSIZE="16"/>
		<STYLE NAME="Text3_Heading 6" PARENT="Default Paragraph Style" LINESPMode="1" FONTSIZE="14"/>
	 */
	public function toString():String {
		return '<STYLE
		NAME="${name}"
		PARENT="${parent}"
		LINESPMode="1"
		FONTSIZE="${fontsize}"
		FONT="Dosis Regular"
		FONTFEATURES="-clig"
		/>\n';
	}
}
