package utils;

class Counter {
	private static final DEFAULT = -1;

	public static var ID:Int = -1;

	public function new() {
		trace('Counter');
	}

	public static function reset() {
		warn('Current Counter.ID: ${Counter.ID}, reset to DEFAULT: ${DEFAULT}');
		Counter.ID = DEFAULT;
	}
}
