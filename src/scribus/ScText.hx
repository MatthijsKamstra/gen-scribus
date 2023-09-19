package scribus;

import sys.FileSystem;
import utils.ID;
import utils.UUID;

class ScText {
	var id(default, null):Int;

	@:isVar public var height(get, set):Float;
	@:isVar public var width(get, set):Float;
	public var path:String;

	public var xpos = 100.001;
	public var ypos = 20.001;
	public var offsetx:Float = 0.0;
	public var offsety:Float = 0.0;

	var ITEXT:Array<String> = [];
	var ITEXT_STR:String = '';
	var DEFAULT_STYLE = '<DefaultStyle PARENT="Default Paragraph Style" LINESPMode="1" CPARENT="Default Character Style"/>';

	public function new(page:ScPage, path:String) {
		// trace('ScText');
		this.id = page.id;

		var _path = path.replace('../', '');

		if (!FileSystem.exists(_path)) {
			ScData.TOTAL_ERRORS++;
		} else {
			// file exists
		}

		// read the file
		var content = sys.io.File.getContent(_path);
		// trace(content);
		var convert = new ScMarkdownConverter(content);
		// ITEXT = convert.itextArr;
		ITEXT_STR = convert.out;

		// log('page.xpos: ' + page.xpos);
		// log('page.ypos: ' + page.ypos);
		// log(offsetx);

		// [mck] if page is left, the margins are reversed
		// @example: 	rightpage: left:10, right:50
		//  			left-page: left:50, right:10

		this.xpos = page.xpos;
		this.ypos = page.ypos;
	}

	public function toString():String {
		this.xpos += offsetx;
		this.ypos += offsety;
		return '<PAGEOBJECT
			uuid="${UUID.uuid()}"
			XPOS="${xpos}"
			YPOS="${ypos}"
			OwnPage="${id}"
			ItemID="${ID.getItemId()}"
			PTYPE="4"
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
			SCALETYPE="1"
			RATIO="1"
			COLUMNS="1"
			COLGAP="0"
			AUTOTEXT="0"
			EXTRA="0"
			TEXTRA="0"
			BEXTRA="0"
			REXTRA="0"
			VAlign="0"
			FLOP="1"
			PLTSHOW="0"
			BASEOF="0"
			textPathType="0"
			textPathFlipped="0"
			path="M0 0 L${width} 0 L${width} ${height} L0 ${height} L0 0 Z"
			copath="M0 0 L${width} 0 L${width} ${height} L0 ${height} L0 0 Z"
			gXpos=""
			gYpos=""
			gWidth="0"
			gHeight="0"
			LAYER="0"
			NEXTITEM="-1"
			BACKITEM="-1">
            <StoryText>
                ${DEFAULT_STYLE}
				${ITEXT_STR}
            </StoryText>
        </PAGEOBJECT>\n';
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
