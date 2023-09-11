package scribus;

import utils.RegEx;

class ScMarkdownConverter {
	var content:String;

	public var itextArr(default, null):Array<String> = [];

	public function new(content:String) {
		// trace('ScMarkdownConverter');
		this.content = content;
		this.itextArr = [];
		convert();
	}

	function convert() {
		var arr = this.content.split('\n');

		for (i in 0...arr.length) {
			var _arr = arr[i];
			// trace(_arr);
			if (_arr == '')
				continue; // block empty line
			var str = extractHeading(_arr);
			str = extractBold(str);
			str = extractItalic(str);
			itextArr.push(str);
		}
	}

	function extractBold(str:String) {
		var matches = RegEx.getMatches(RegEx.boldPattern, content);
		if (matches.length > 0) {
			for (i in 0...matches.length) {
				var match = matches[i];
				str = str.replace(match, '"/>\n<ITEXT CPARENT="Text5_Bold" CH="${match.replace('**', '')}"/>\n<ITEXT CH="');
			}
		}
		return str;
	}

	function extractItalic(str:String) {
		var matches = RegEx.getMatches(RegEx.italicPattern, content);
		if (matches.length > 0) {
			for (i in 0...matches.length) {
				var match = matches[i];
				str = str.replace(match, '"/>\n<ITEXT CPARENT="Text5_Italic" CH="${match.replace('_', '')}"/>\n<ITEXT CH="');
			}
		}
		return str;
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
		var hashLevels = ['######', '#####', '####', '###', '##', '#'];
		var styleLevels = [
			'Text3_Heading 6',
			'Text3_Heading 5',
			'Text3_Heading 4',
			'Text3_Heading 3',
			'Text3_Heading 2',
			'Text3_Heading 1'
		];

		for (hash in hashLevels) {
			if (str.startsWith(hash)) {
				para = "Text3_Heading " + (hash.length);
				text = text.replace(hash, '').trim();
				break; // Stop processing after the first heading is found
			}
		}

		return '<ITEXT CH="${text}"/>\n<para PARENT="${para}"/>';
	}
}
