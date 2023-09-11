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
			var str = extractHeading(_arr);
			itextArr.push(str);
		}
	}

	function extractHeading(str:String):String {
		/**
			<ITEXT CH="h1 Heading"/>
			<para PARENT="Text3_Heading 1"/>
			<ITEXT CH="h2 Heading"/>
			<para PARENT="Text3_Heading 2"/>
			<ITEXT CH="h3 Heading"/>
			<para PARENT="Text3_Heading 3"/>
			<ITEXT CH="h4 Heading"/>
			<para PARENT="Text3_Heading 4"/>
			<ITEXT CH="h5 Heading"/>
			<para PARENT="Text3_Heading 5"/>
			<ITEXT CH="h6 Heading"/>
			<para PARENT="Text3_Heading 6"/>
		 */
		var para = '';
		var text = str;
		var hash = '######';
		if (str.startsWith(hash)) {
			para = Const.HEADING6;
			text = text.replace(hash, '').trim();
		}
		hash = '#####';
		if (str.startsWith(hash)) {
			para = Const.HEADING5;
			text = text.replace(hash, '').trim();
		}
		hash = '####';
		if (str.startsWith(hash)) {
			para = Const.HEADING4;
			text = text.replace(hash, '').trim();
		}
		hash = '###';
		if (str.startsWith(hash)) {
			para = Const.HEADING3;
			text = text.replace(hash, '').trim();
		}
		hash = '##';
		if (str.startsWith(hash)) {
			para = Const.HEADING2;
			text = text.replace(hash, '').trim();
		}
		hash = '#';
		if (str.startsWith(hash)) {
			para = Const.HEADING1;
			text = text.replace(hash, '').trim();
		}
		return '<ITEXT CH="${text}"/>\n<para PARENT="${para}"/>';
	}
}
