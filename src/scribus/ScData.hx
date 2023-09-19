package scribus;

class ScData {
	public static var TOTAL_PAGES:Int = 0;
	public static var TOTAL_IMAGES:Int = 0;
	public static var TOTAL_TEXT:Int = 0;
	public static var TOTAL_ERRORS:Int = 0;

	public function new() {
		trace('ScData');
	}

	static public function main() {
		var app = new ScData();
	}
}
