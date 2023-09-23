package scribus;

import AST.Texts;
import sys.FileSystem;
import utils.ID;
import utils.UUID;

class ScText {
	var id(default, null):Int;

	public var path:String;
	public var DEFAULT_X = 100.001; // in points
	public var DEFAULT_Y = 20.001; // in points

	// public var xpos = 100.001;
	// public var ypos = 20.001;
	@:isVar public var xpos(get, set):Float; // in points
	@:isVar public var ypos(get, set):Float; // in points
	@:isVar public var width(get, set):Float = 100; // in points
	@:isVar public var height(get, set):Float = 100; // in points

	var ITEXT:Array<String> = [];
	var ITEXT_STR:String = '';
	var DEFAULT_STYLE = '<DefaultStyle PARENT="Default Paragraph Style" LINESPMode="1" CPARENT="Default Character Style"/>';

	@:isVar public var xposInMM(get, set):Float; // in mm
	@:isVar public var yposInMM(get, set):Float; // in mm
	@:isVar public var widthInMM(get, set):Float; // in mm
	@:isVar public var heightInMM(get, set):Float; // in mm

	public var offsetx:Float = 0.0;
	public var offsety:Float = 0.0;

	public function new(page:ScPage, path:String) {
		// trace('ScText');
		this.id = page.id;

		var _path = path.replace('../', '');

		if (!FileSystem.exists(_path)) {
			ScData.TOTAL_ERRORS++;
			ScData.errorArray.push('Text file doesnt exist (${_path})');
			var convert = new ScMarkdownConverter('# File does not exist\n\nCheck path: `${_path}`');
			// ITEXT = convert.itextArr;
			ITEXT_STR = convert.out;
		} else {
			// file exists
			// read the file
			var content = sys.io.File.getContent(_path);
			// trace(content);
			var convert = new ScMarkdownConverter(content);
			// ITEXT = convert.itextArr;
			ITEXT_STR = convert.out;
		}

		// log('page.xpos: ' + page.xpos);
		// log('page.ypos: ' + page.ypos);
		// log(offsetx);

		// [mck] if page is left, the margins are reversed
		// @example: 	rightpage: left:10, right:50
		//  			left-page: left:50, right:10

		this.xpos = page.xpos + page.marginLeft;
		this.ypos = page.ypos + page.marginTop;
		// this.xposInMM = page.xpos * PageSize.POINTS2MM;
		// this.yposInMM = page.ypos * PageSize.POINTS2MM;

		this.width = page.width - page.marginLeft - page.marginRight;
		this.height = page.height - page.marginTop - page.marginBottom;
		// this.widthInMM = page.width * PageSize.POINTS2MM;
		// this.heightInMM = page.height * PageSize.POINTS2MM;

		if (Config.IS_DEBUG)
			info('x: ${this.xpos}, y: ${this.ypos}, w: ${this.width}, h: ${this.height}', 1);
	}

	public function settings(text:Texts) {
		// warn(text);
		if (text.x != null && text.x.unit.toLowerCase() == 'mm') {
			if (Config.IS_DEBUG) {
				log('x: ${text.x.value}${text.x.unit}, ${PageSize.MM2POINTS * text.x.value} points, xpos: ${xpos}', 1);
				info(PageSize.MM2POINTS);
				info('${text.x.value}');
				info(PageSize.MM2POINTS * text.x.value);
				info(xpos);
				info(xpos + (PageSize.MM2POINTS * text.x.value));
			}
			xpos = xpos + (PageSize.MM2POINTS * text.x.value);
			// xposInMM = text.x.value;
			if (Config.IS_DEBUG)
				log('x: ${text.x.value}${text.x.unit}, ${PageSize.MM2POINTS * text.x.value} points, xpos: ${xpos}', 2);
		}
		if (text.y != null && text.y.unit.toLowerCase() == 'mm') {
			if (Config.IS_DEBUG)
				log('y: ${text.y.value}${text.y.unit}, ${PageSize.MM2POINTS * text.y.value} points, ypos: ${ypos}', 1);
			ypos = ypos + (PageSize.MM2POINTS * text.y.value);
			// yposInMM = text.y.value;
			if (Config.IS_DEBUG)
				log('y: ${text.y.value}${text.y.unit}, ${PageSize.MM2POINTS * text.y.value} points, ypos: ${ypos}', 2);
		}
		if (text.width != null && text.width.unit.toLowerCase() == 'mm') {
			if (Config.IS_DEBUG)
				log('w', 1);
			width = PageSize.MM2POINTS * text.width.value;
			// widthInMM = text.width.value;
		}
		if (text.height != null && text.height.unit.toLowerCase() == 'mm') {
			if (Config.IS_DEBUG)
				log('h', 1);
			height = PageSize.MM2POINTS * text.height.value;
			// heightInMM = text.height.value;
		}
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

	function get_width():Float {
		return width;
	}

	function set_width(value:Float):Float {
		return width = value;
	}

	function get_height():Float {
		return height;
	}

	function set_height(value:Float):Float {
		return height = value;
	}

	function get_xpos():Float {
		return xpos;
	}

	function set_xpos(value:Float):Float {
		return xpos = value;
	}

	function get_ypos():Float {
		return ypos;
	}

	function set_ypos(value:Float):Float {
		return ypos = value;
	}

	function set_xposInMM(value:Float):Float {
		this.xpos = PageSize.MM2POINTS * value;
		return xposInMM = value;
	}

	function get_xposInMM():Float {
		return xposInMM;
	}

	function set_yposInMM(value:Float):Float {
		this.ypos = PageSize.MM2POINTS * value;
		return xposInMM = value;
	}

	function get_yposInMM():Float {
		return yposInMM;
	}

	function set_widthInMM(value:Float):Float {
		this.width = PageSize.MM2POINTS * value;
		return widthInMM = value;
	}

	function get_widthInMM():Float {
		return widthInMM;
	}

	function set_heightInMM(value:Float):Float {
		this.height = PageSize.MM2POINTS * value;
		return heightInMM = value;
	}

	function get_heightInMM():Float {
		return heightInMM;
	}
}
