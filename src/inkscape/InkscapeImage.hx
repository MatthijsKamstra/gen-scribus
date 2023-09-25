package inkscape;

import AST.Image;

class InkscapeImage {
	public var width:Float;
	public var height:Float;
	public var path:String;

	public function new(page:InkscapePage, path:String) {
		info('InkscapeImage');
	}

	public function toString() {
		return '<!-- WIP: Image -->\n';
	}

	public function settings(_image:Image) {
		trace('throw new haxe.exceptions.NotImplementedException();');
	}
}
