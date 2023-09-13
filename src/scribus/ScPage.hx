package scribus;

import utils.Counter;
import utils.UUID;

class ScPage {
	final DEFAULT_XPOS = 100.001;
	final DEFAULT_YPOS = 20.001;

	private static var XPOS:Float = 100.001;
	private static var YPOS:Float = 20.001;

	@:isVar public var id(default, null):Int = -1;
	@:isVar public var xpos(default, null):Float = 100.001;
	@:isVar public var ypos(default, null):Float = 20.001;

	@:isVar public var size(get, set):String = Default.PAGESIZE;
	@:isVar public var width(get, set):Float = Default.PAGEWIDTH;
	@:isVar public var height(get, set):Float = Default.PAGEHEIGHT;

	public var marginLeft:Float;
	public var marginRight:Float;
	public var marginTop:Float;
	public var marginBottom:Float;

	public function new() {
		// ScPage.ID = -1;
	}

	function reset() {
		XPOS = DEFAULT_XPOS;
		YPOS = DEFAULT_YPOS;
	}

	public function toString():String {
		if (Counter.ID <= -1) {
			reset();
		}
		Counter.ID++;
		this.id = Counter.ID;

		var _MNAM = 'Normal Right';
		// 'Normal Left'
		// 'Normal Right'
		if (Counter.ID % 2 == 0) {
			// row = "-even";
			_MNAM = 'Normal Right';
			XPOS = DEFAULT_XPOS + width;
		} else {
			// row = "--odd";
			_MNAM = 'Normal Left';
			XPOS = DEFAULT_XPOS;
			YPOS += height + (2 * DEFAULT_YPOS);
		}

		this.xpos = XPOS;
		this.ypos = YPOS;

		log('ScPage | ${Counter.ID} | XPOS: ' + XPOS);
		log('ScPage | ${Counter.ID} | YPOS: ' + YPOS);
		log('ScPage | ${Counter.ID} | this.xpos: ' + this.xpos);
		log('ScPage | ${Counter.ID} | this.ypos: ' + this.ypos);

		return '<PAGE
			UUID="${UUID.uuid()}"
			PAGEXPOS="${XPOS}"
			PAGEYPOS="${YPOS}"
			PAGEWIDTH="${width}"
			PAGEHEIGHT="${height}"
			BORDERLEFT="${marginLeft}"
			BORDERRIGHT="${marginRight}"
			BORDERTOP="${marginTop}"
			BORDERBOTTOM="${marginBottom}"
			NUM="${Counter.ID}"
			NAM=""
			MNAM="${_MNAM}"
			Size="${size}"
			Orientation="0"
			LEFT="0"
			PRESET="0"
			VerticalGuides=""
			HorizontalGuides=""
			AGhorizontalAutoGap="0"
			AGverticalAutoGap="0"
			AGhorizontalAutoCount="0"
			AGverticalAutoCount="0"
			AGhorizontalAutoRefer="0"
			AGverticalAutoRefer="0"
			AGSelection="0 0 0 0"
			pageEffectDuration="1"
			pageViewDuration="1"
			effectType="0"
			Dm="0"
			M="0"
			Di="0"/>
		';
	}

	// ____________________________________ getter/setter ____________________________________

	function get_size():String {
		return size;
	}

	function set_size(value:String):String {
		return size = value;
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
}
