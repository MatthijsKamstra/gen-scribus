package scribus;

class Page {
	var pageWidth:Float = Default.PAGEWIDTH;
	var pageHeight:Float = Default.PAGEHEIGHT;
	var pageSize:String = Default.PAGESIZE;

	static var pageNumber:Int = 0;

	@:isVar public var size(get, set):String;
	@:isVar public var width(get, set):Float;
	@:isVar public var height(get, set):Float;

	public function new() {
		trace('Page');
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
		return '<PAGE
			PAGEXPOS="695.276590551181"
			PAGEYPOS="20.001"
			PAGEWIDTH="${width}"
			PAGEHEIGHT="${height}"
			BORDERLEFT="40"
			BORDERRIGHT="40"
			BORDERTOP="40"
			BORDERBOTTOM="40"
			NUM="${pageNumber}"
			NAM=""
			MNAM="Normal"
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
