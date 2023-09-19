package scribus;

class ScData {
	public static var TOTAL_PAGES:Int = 0;
	public static var TOTAL_IMAGES:Int = 0;
	public static var TOTAL_TEXT:Int = 0;
	public static var TOTAL_ERRORS:Int = 0;
	public static var errorArray:Array<String> = [];

	public function new() {
		trace('ScData');
	}

	static public function main() {
		var app = new ScData();
	}

	public static function reset() {
		TOTAL_PAGES = 0;
		TOTAL_IMAGES = 0;
		TOTAL_TEXT = 0;
		TOTAL_ERRORS = 0;
		errorArray = [];
	}
}
