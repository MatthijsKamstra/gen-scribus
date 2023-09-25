package inkscape;

import scribus.PageSize;
import suite.Default;
import utils.Counter;
import utils.UUID;

class InkscapePage {
	private static var XPOS:Float = Default.XPOS_ZERO;
	private static var YPOS:Float = Default.YPOS_ZERO;
	private static var XOFFSET:Float = Default.XOFFSET_IN_POINTS;
	private static var YOFFSET:Float = Default.YOFFSET_IN_POINTS;

	@:isVar public var id(default, null):Int = -1;

	@:isVar public var xpos(get, set):Float = 0; // in points
	@:isVar public var ypos(get, set):Float = 0; // in points
	@:isVar public var width(get, set):Float = Default.PAGEWIDTH_IN_POINTS; // in points
	@:isVar public var height(get, set):Float = Default.PAGEHEIGHT_IN_POINTS; // in points

	@:isVar public var xposInMM(get, set):Float; // in mm
	@:isVar public var yposInMM(get, set):Float; // in mm
	@:isVar public var widthInMM(get, set):Float; // in mm
	@:isVar public var heightInMM(get, set):Float; // in mm

	public var marginLeft:Float;
	public var marginRight:Float;
	public var marginTop:Float;
	public var marginBottom:Float;

	public var margin:String = '14mm';
	public var bleed:String = '3mm';
	public var title:String = '';

	public function new() {
		// info('InkscapePage');
	}

	function reset() {
		XPOS = Default.XPOS_ZERO;
		YPOS = Default.YPOS_ZERO;
	}

	public function toString() {
		if (Counter.ID <= -1) {
			reset();
		}
		Counter.ID++;
		this.id = Counter.ID;

		XPOS = Counter.ID * (this.width + XOFFSET);
		// YPOS = Counter.ID * (this.height + YOFFSET);

		this.xpos = XPOS;
		this.ypos = YPOS;

		if (marginLeft != null) {
			this.margin = '${marginLeft}mm ${marginTop}mm ${marginRight}mm ${marginBottom}mm';
		}

		return '<inkscape:page
			x="${XPOS}"
			y="${YPOS}"
			width="${this.width}"
			height="${this.height}"
			id="page${this.id + 1}"
			margin="${this.margin}"
       		bleed="${this.bleed}"
			${(this.title != '') ? 'inkscape:label="${this.title}"' : ''}
			/>\n';
	}

	// ____________________________________ getter/setter ____________________________________

	function set_xpos(value:Float):Float {
		return xpos = value;
	}

	function get_xpos():Float {
		return xpos;
	}

	function set_ypos(value:Float):Float {
		return ypos = value;
	}

	function get_ypos():Float {
		return ypos;
	}

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

	function get_id():Int {
		return id;
	}

	function set_id(value:Int):Int {
		return id = value;
	}

	// ____________________________________ getter/setter in mm ____________________________________

	function set_xposInMM(value:Float):Float {
		this.xpos = PageSize.MM2POINTS * value;
		return xposInMM = value;
	}

	function get_xposInMM():Float {
		return xposInMM;
	}

	function set_yposInMM(value:Float):Float {
		this.ypos = PageSize.MM2POINTS * value;
		return yposInMM = value;
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
