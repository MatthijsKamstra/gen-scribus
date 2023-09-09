package scribus;

class ScImage {
	var id(default, null):Int;

	static var itemId(default, null):Int = Std.random(700000000) + 700000000;

	@:isVar public var height(get, set):Float;
	@:isVar public var width(get, set):Float;
	public var path:String;

	var scaletype(default, null):Int = 1;

	public var xpos = 100.001;
	public var ypos = 20.001;

	public function new(page:ScPage, path:String) {
		trace('ScImage');
		this.id = page.id;

		// log(page.xpos);
		this.xpos = page.xpos;
		this.ypos = page.ypos;

		ScImage.itemId++;
	}

	public function toString():String {
		return '<PAGEOBJECT
			XPOS="${xpos}"
			YPOS="${ypos}"
			OwnPage="${id}"
			ItemID="${ScImage.itemId}"
			PTYPE="2"
			WIDTH="${width}"
			HEIGHT="${height}"
			FRTYPE="0"
			CLIPEDIT="0"
			PWIDTH="1"
			PLINEART="1"
			LOCALSCX="1"
			LOCALSCY="1"
			LOCALX="0"
			LOCALY="0"
			LOCALROT="0"
			PICART="1"
			SCALETYPE="${scaletype}"
			RATIO="1"
			PFILE="${path}"
			IRENDER="0"
			path="M0 0 L${width} 0 L${width} ${height} L0 ${height} L0 0 Z"
			copath="M0 0 L${width} 0 L${width} ${height} L0 ${height} L0 0 Z"
			gXpos="176.536062992126"
			gYpos="97.5272727272728"
			gWidth="0"
			gHeight="0"
			LAYER="0"
			NEXTITEM="-1"
			BACKITEM="-1"
			/>
		';
	}

	// ____________________________________ getter/setter ____________________________________

	function get_height():Float {
		return height;
	}

	function set_height(value:Float):Float {
		return height = value;
	}

	function get_width():Float {
		return width;
	}

	function set_width(value:Float):Float {
		return width = value;
	}
}
/**
	<PAGEOBJECT XPOS="519.528559055118" YPOS="20.001" OwnPage="0" ItemID="649521479" PTYPE="2" WIDTH="419.527559055118" HEIGHT="419.527559055118" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" LOCALSCX="1" LOCALSCY="1" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="1" RATIO="1" Pagenumber="0" PFILE="assets/png/a4_colors_Layer 1_copy_1.png" IRENDER="0" path="M0 0 L112.267 0 L112.267 75.5449 L0 75.5449 L0 0 Z" copath="M0 0 L112.267 0 L112.267 75.5449 L0 75.5449 L0 0 Z" gXpos="519.528559055118" gYpos="20.001" gWidth="0" gHeight="0" LAYER="0" NEXTITEM="-1" BACKITEM="-1"/>
	// by scribus
	<PAGEOBJECT XPOS="519.528559055118" YPOS="20.001" OwnPage="0" ItemID="635233607" PTYPE="2" WIDTH="419.527559055118" HEIGHT="419.527559055118" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" LOCALSCX="0.938540400570734" LOCALSCY="0.938540400570734" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="0" RATIO="1" Pagenumber="0" PFILE="../assets/svg/snippets_piramide van Lencioni.png" IRENDER="0" EMBEDDED="0" path="M0 0 L419.528 0 L419.528 419.528 L0 419.528 L0 0 Z" copath="M0 0 L419.528 0 L419.528 419.528 L0 419.528 L0 0 Z" gXpos="519.528559055118" gYpos="20.001" gWidth="0" gHeight="0" LAYER="0" NEXTITEM="-1" BACKITEM="-1"/>
	// helaf
	<PAGEOBJECT XPOS="519.528559055118" YPOS="20.001" OwnPage="0" ItemID="1971998534" PTYPE="2" WIDTH="195.590551181103" HEIGHT="419.527559055118" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" LOCALSCX="0.43756275432014" LOCALSCY="0.43756275432014" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="0" RATIO="1" Pagenumber="0" PFILE="../assets/svg/snippets_piramide van Lencioni.png" IRENDER="0" EMBEDDED="0" path="M0 0 L195.591 0 L195.591 419.528 L0 419.528 L0 0 Z" copath="M0 0 L195.591 0 L195.591 419.528 L0 419.528 L0 0 Z" gXpos="176.536062992126" gYpos="97.5272727272728" gWidth="0" gHeight="0" LAYER="0" NEXTITEM="-1" BACKITEM="-1"/>
	// image centerd
	<PAGEOBJECT XPOS="519.528559055118" YPOS="20.001" OwnPage="0" ItemID="650640199" PTYPE="2" WIDTH="419.527559055118" HEIGHT="419.527559055118" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" LOCALSCX="0.938540400570735" LOCALSCY="0.938540400570735" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="0" RATIO="1" Pagenumber="0" PFILE="../assets/svg/snippets_piramide van Lencioni.png" IRENDER="0" EMBEDDED="0" path="M0 0 L419.528 0 L419.528 419.528 L0 419.528 L0 0 Z" copath="M0 0 L419.528 0 L419.528 419.528 L0 419.528 L0 0 Z" gXpos="176.536062992126" gYpos="97.5272727272728" gWidth="0" gHeight="0" LAYER="0" NEXTITEM="-1" BACKITEM="-1"/>
	<PAGEOBJECT XPOS="519.528559055118" YPOS="20.001" OwnPage="0" ItemID="650640199" PTYPE="2" WIDTH="181.417322834646" HEIGHT="262.762636363636" FRTYPE="0" CLIPEDIT="0" PWIDTH="1" PLINEART="1" LOCALSCX="0.405855308354913" LOCALSCY="0.405855308354913" LOCALX="0" LOCALY="0" LOCALROT="0" PICART="1" SCALETYPE="0" RATIO="1" Pagenumber="0" PFILE="../assets/svg/snippets_piramide van Lencioni.png" IRENDER="0" EMBEDDED="0" path="M0 0 L181.417 0 L181.417 262.763 L0 262.763 L0 0 Z" copath="M0 0 L181.417 0 L181.417 262.763 L0 262.763 L0 0 Z" gXpos="176.536062992126" gYpos="97.5272727272728" gWidth="0" gHeight="0" LAYER="0" NEXTITEM="-1" BACKITEM="-1"/>
 */
