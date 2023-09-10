package scribus;

import utils.ID;

class ScImage {
	var id(default, null):Int;

	@:isVar public var height(get, set):Float;
	@:isVar public var width(get, set):Float;
	public var path:String;

	var scaletype(default, null):Int = 0; // 0 = "fit to frame"

	public var xpos = 100.001;
	public var ypos = 20.001;

	public function new(page:ScPage, path:String) {
		// trace('ScImage');
		this.id = page.id;

		// log(page.xpos);
		this.xpos = page.xpos;
		this.ypos = page.ypos;

		// ScImage.itemId++;
	}

	public function toString():String {
		return '<PAGEOBJECT
			XPOS="${xpos}"
			YPOS="${ypos}"
			OwnPage="${id}"
			ItemID="${ID.getItemId()}"
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
			gXpos=""
			gYpos=""
			gWidth="0"
			gHeight="0"
			LAYER="0"
			NEXTITEM="-1"
			BACKITEM="-1"
			/>\n';
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
