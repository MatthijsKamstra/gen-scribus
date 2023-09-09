package scribus;

class ScPage {
	var pageWidth:Float = Default.PAGEWIDTH;
	var pageHeight:Float = Default.PAGEHEIGHT;
	var pageSize:String = Default.PAGESIZE;

	static var pageNumber:Int = -1; // want to start at zero (@see toString)

	@:isVar public var size(get, set):String;
	@:isVar public var width(get, set):Float;
	@:isVar public var height(get, set):Float;

	public var marginLeft:Float;
	public var marginRight:Float;
	public var marginTop:Float;
	public var marginBottom:Float;

	public function new() {
		// trace('Page');
	}

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

	public function toString():String {
		pageNumber++;

		var _MNAM = 'Normal Right';
		// 'Normal Left'
		// 'Normal Right'
		if (pageNumber % 2 == 0) {
			// row = "-even";
			_MNAM = 'Normal Right';
		} else {
			// row = "--odd";
			_MNAM = 'Normal Left';
		}

		return '<PAGE
			PAGEXPOS="695.276590551181"
			PAGEYPOS="20.001"
			PAGEWIDTH="${width}"
			PAGEHEIGHT="${height}"
			BORDERLEFT="${marginLeft}"
			BORDERRIGHT="${marginRight}"
			BORDERTOP="${marginTop}"
			BORDERBOTTOM="${marginBottom}"
			NUM="${pageNumber}"
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
}
