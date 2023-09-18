package scribus;

import AST.Image;
import utils.ID;
import utils.UUID;

class ScImage {
	var id(default, null):Int;

	public var path:String; // of image
	public var DEFAULT_X = 100.001; // in points
	public var DEFAULT_Y = 20.001; // in points

	// public var xpos = 100.001;
	// public var ypos = 20.001;
	@:isVar public var xpos(get, set):Float; // in points
	@:isVar public var ypos(get, set):Float; // in points
	@:isVar public var width(get, set):Float = 100; // in points
	@:isVar public var height(get, set):Float = 100; // in points

	var scaletype(default, null):Int = 0; // 0 = "fit to frame"

	@:isVar public var xposInMM(get, set):Float; // in mm
	@:isVar public var yposInMM(get, set):Float; // in mm
	@:isVar public var widthInMM(get, set):Float; // in mm
	@:isVar public var heightInMM(get, set):Float; // in mm

	public function new(page:ScPage, path:String) {
		this.id = page.id;
		this.path = path;

		this.xpos = page.xpos; // top left corner
		this.ypos = page.ypos; // top left corner
		// this.xposInMM = page.xpos * PageSize.POINTS2MM;
		// this.yposInMM = page.ypos * PageSize.POINTS2MM;

		this.width = page.width;
		this.height = page.height;
		// this.widthInMM = page.width * PageSize.POINTS2MM;
		// this.heightInMM = page.height * PageSize.POINTS2MM;

		info('x: ${this.xpos}, y: ${this.ypos}, w: ${this.width}, h: ${this.height}', 1);
	}

	public function settings(image:Image) {
		// warn(image);
		if (image.x != null && image.x.unit.toLowerCase() == 'mm') {
			log('x: ${image.x.value}${image.x.unit}, ${PageSize.MM2POINTS * image.x.value} points, xpos: ${xpos}', 1);
			info(PageSize.MM2POINTS);
			info('${image.x.value}');
			info(PageSize.MM2POINTS * image.x.value);
			info(xpos);
			info(xpos + (PageSize.MM2POINTS * image.x.value));
			xpos = xpos + (PageSize.MM2POINTS * image.x.value);
			// xposInMM = image.x.value;
			log('x: ${image.x.value}${image.x.unit}, ${PageSize.MM2POINTS * image.x.value} points, xpos: ${xpos}', 2);
		}
		if (image.y != null && image.y.unit.toLowerCase() == 'mm') {
			log('y: ${image.y.value}${image.y.unit}, ${PageSize.MM2POINTS * image.y.value} points, ypos: ${ypos}', 1);
			ypos = ypos + (PageSize.MM2POINTS * image.y.value);
			// yposInMM = image.y.value;
			log('y: ${image.y.value}${image.y.unit}, ${PageSize.MM2POINTS * image.y.value} points, ypos: ${ypos}', 2);
		}
		if (image.width != null && image.width.unit.toLowerCase() == 'mm') {
			log('w', 1);
			width = PageSize.MM2POINTS * image.width.value;
			// widthInMM = image.width.value;
		}
		if (image.height != null && image.height.unit.toLowerCase() == 'mm') {
			log('h', 1);
			height = PageSize.MM2POINTS * image.height.value;
			// heightInMM = image.height.value;
		}
	}

	public function toString():String {
		return '<PAGEOBJECT
			uuid="${UUID.uuid()}"
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
