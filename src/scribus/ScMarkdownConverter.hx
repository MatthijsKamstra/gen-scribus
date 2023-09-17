package scribus;

import const.StyleName;
import utils.RegEx;

class ScMarkdownConverter {
	var content:String;

	var previous:String = ''; // is the previos value

	public var PARAGRAPH = 'paragraph';
	public var HEADING = 'heading';
	public var BLOCKQUOTE:String = 'blockquote';
	public var LIST:String = 'list';
	public var LIST_NUMBERED:String = 'list_numbered';

	// public var itextArr(default, null):Array<String> = [];
	public var out:String = '';

	public function new(content:String) {
		// trace('ScMarkdownConverter');
		this.content = content;
		// this.itextArr = [];
		this.out = '';
		convert();
	}

	function convert() {
		var arr = this.content.split('\n');
		for (i in 0...arr.length) {
			var _arr = arr[i];
			// trace(_arr);

			info('previous line: ' + this.previous);

			if (_arr == '' && this.previous == HEADING)
				continue; // block empty line

			// log(_arr);

			var str = _arr.htmlEscape(true);
			str = extractDefault(str); // <p>
			str = extractBoldItalic(str);
			str = extractBold(str);
			str = extractItalic(str);
			str = extractBlockquote(str); // <blockquote>
			str = extractHeading(str); // <h1>
			str = extractList(str); // <li>
			str = extractNumberedList(str); // <ul>
			// itextArr.push(str);
			this.out += str;
		}
	}

	function extractDefault(str:String) {
		var para = '';
		var text = str;
		this.previous = PARAGRAPH;
		return '<ITEXT CH="${text}"/>\n<para PARENT="${para}"/>';
	}

	function extractBold(str:String) {
		var para = StyleName.BOLD;
		var matches = RegEx.getMatches(RegEx.boldPattern, content);
		if (matches.length > 0) {
			for (i in 0...matches.length) {
				var match = matches[i];
				str = str.replace(match, '"/>\n<ITEXT CPARENT="${para}" CH="${match.replace('**', '')}"/>\n<ITEXT CH="');
			}
		}
		return str;
	}

	function extractItalic(str:String):String {
		var para = StyleName.ITALIC;
		var matches = RegEx.getMatches(RegEx.italicPattern, content);
		if (matches.length > 0) {
			for (i in 0...matches.length) {
				var match = matches[i];
				str = str.replace(match, '"/>\n<ITEXT CPARENT="${para}" CH="${match.replace('_', '')}"/>\n<ITEXT CH="');
			}
		}
		return str;
	}

	function extractBoldItalic(str:String):String {
		// trace('extractBoldItalic ("${str}")');
		var para = StyleName.BOLD_ITALIC;
		var matches = RegEx.getMatches(RegEx.boldItalicPattern, content);
		if (matches.length <= 0) {
			// trace('not bold-italic');
			matches = RegEx.getMatches(RegEx.italicBoldPattern, content);
		}
		if (matches.length <= 0) {
			// trace('not italic-bold');
		}
		if (matches.length > 0) {
			for (i in 0...matches.length) {
				var match = matches[i];
				var tt = match;
				// trace('${i} --------------------');
				// trace(tt);
				tt = tt.replace('**', '');
				// trace(tt);
				tt = tt.replace('_', '');
				// trace(tt);
				str = str.replace(match, '"/>\n<ITEXT CPARENT="${para}" CH="${tt}"/>\n<ITEXT CH="');
			}
		}
		return str;
	}

	function extractBlockquote(str:String) {
		var para = StyleName.BLOCKQUOTES;
		var text = str;
		if (str.startsWith('<ITEXT CH="&gt;')) {
			text = text.replace('&gt; ', '').replace('para PARENT=""', 'para PARENT="${para}"');
			// var xml = Xml.parse(text);
			// trace(xml.firstChild());
			// return '<ITEXT CH="${text}"/>\n<para PARENT="${para}"/>';
			this.previous = BLOCKQUOTE;
			return text;
		}
		return str;
	}

	function extractList(str:String) {
		warn('WIP extract List');
		var para = StyleName.LIST;
		var text = str;
		// this.previous = LIST;
		return str;
	}

	function extractNumberedList(str:String) {
		warn('WIP extract Numbered list');
		var para = StyleName.LIST_NUMBERED;
		var text = str;
		// this.previous = LIST_NUMBERED;
		return str;
	}

	function extractHeading(str:String):String {
		var para = '';
		var text = str;
		var hashLevels = ['######', '#####', '####', '###', '##', '#'];
		var styleLevels = [
			StyleName.H6,
			StyleName.H5,
			StyleName.H4,
			StyleName.H3,
			StyleName.H2,
			StyleName.H1,
		];

		for (i in 0...hashLevels.length) {
			var _hashLevels = hashLevels[i];
			if (str.startsWith('<ITEXT CH="' + _hashLevels)) {
				// para = "Text3_Heading " + (_hashLevels.length);
				para = styleLevels[i];
				text = text.replace(_hashLevels + ' ', '');
				text = text.replace(_hashLevels, '').replace('para PARENT=""', 'para PARENT="${para}"');
				// var xml = Xml.parse(text);
				// trace(xml.firstChild());
				// return '<ITEXT CH="${text}"/>\n<para PARENT="${para}"/>';

				this.previous = HEADING;

				return text;

				// return '<ITEXT CH="${text}"/>\n<para PARENT="${para}"/>';
				break; // Stop processing after the first heading is found
			}
		}
		return str;
	}
}
