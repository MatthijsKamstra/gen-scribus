package inkscape;

class InkscapeData {
	public static var TOTAL_PAGES:Int = 0;
	public static var TOTAL_IMAGES:Int = 0;
	public static var TOTAL_TEXT:Int = 0;
	public static var TOTAL_ERRORS:Int = 0;
	public static var errorArray:Array<String> = [];

	public function new() {
		// info('InkscapeData');
	}

	public static function reset() {
		TOTAL_PAGES = 0;
		TOTAL_IMAGES = 0;
		TOTAL_TEXT = 0;
		TOTAL_ERRORS = 0;
		errorArray = [];
	}
}
