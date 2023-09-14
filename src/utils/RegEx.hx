package utils;

// - https://regexr.com/
// - https://haxe.org/manual/std-regex.html
class RegEx {
	public static var boldItalicPattern:EReg = ~/(\*\*_.*?_\*\*)/g;
	public static var italicBoldPattern:EReg = ~/(_\*\*.*?\*\*_)/g;

	public static final italicPattern:EReg = ~/(_.*?_)/g;
	public static final boldPattern = ~/(\*\*.*?\*\*)/g;

	// ____________________________________ comment ____________________________________
	public static final commentHTML = ~/<!--[\S\s]*?-->/g;
	public static final commentJS = ~/(\/\*)(.|\r|\n)*?(\*\/)/g;
	public static final commentJSLine = ~/(\/\/)[\S\s]*?/g;
	public static final commentJSLine3 = ~/(\/\/).*/g;
	public static final commentJSLine2 = ~/\/\*[\s\S]*?\*\/|\/\/.*/g;

	/**
		* search for specific regex
		*
		* @example
		* ```js
			var matches = RegEx.getMatches(RegEx.getVars, content);
			if (matches.length > 0) {
				// log(matches);
				for (i in 0...matches.length) {
					var match = matches[i];
					trace(match);
				}
			}
		* ```
		*
		* @param ereg
		* @param input
		* @param index
		* @return Array<String>
	 */
	static public function getMatches(ereg:EReg, input:String, index:Int = 0):Array<String> {
		var matches = [];
		while (ereg.match(input)) {
			matches.push(ereg.matched(index));
			input = ereg.matchedRight();
		}
		return matches;
	}
}
