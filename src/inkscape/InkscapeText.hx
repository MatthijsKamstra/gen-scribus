package inkscape;

import AST.Texts;

class InkscapeText {
	public var offsetx:Float;
	public var offsety:Float;
	public var width:Float;
	public var height:Float;
	public var path:String;

	public function new(page:InkscapePage, path:String) {
		info('InkscapeText');
	}

	public function toString() {
		return '<!-- WIP: text -->\n';
	}

	public function settings(_text:Texts) {
		trace('throw new haxe.exceptions.NotImplementedException();');
	}

	public function useStyle(s:String) {
		trace('throw new haxe.exceptions.NotImplementedException();');
	}
}
