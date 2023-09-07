package scribus;

// https://www.ibm.com/docs/en/radfws/9.7?topic=overview-locales-code-pages-supported
class Locale {
	public static var EN_US(default, null):String = 'en_US';
	public static var EN_GB(default, null):String = 'en_GB';
	public static var NL(default, null):String = 'nl';

	public function new() {
		trace('Locale');
	}
}
