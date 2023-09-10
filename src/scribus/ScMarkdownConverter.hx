package scribus;

class ScMarkdownConverter {
	var content:String;

	public var itextArr(default, null):Array<String> = [];

	public function new(content:String) {
		trace('ScMarkdownConverter');
		this.content = content;
		this.itextArr = [];
		convert();
	}

	function convert() {
		var arr = this.content.split('\n');

		for (i in 0...arr.length) {
			var _arr = arr[i];
			// trace(_arr);
			var str = '<ITEXT CH="${_arr}"/>\n<para/>';
			itextArr.push(str);
		}
	}
}
