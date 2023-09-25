package inkscape;

import utils.Counter;

class InkscapeLayer {
	@:isVar public var id(default, null):Int = -1;
	public var title:String;

	public function new() {
		// info('InkscapeLayer');
	}

	public function toString() {
		if (Counter.ID <= -1) {
			// reset();
		}
		Counter.ID++;
		this.id = Counter.ID;
		return '<g
			inkscape:groupmode="layer"
			id="${this.id}"
			inkscape:label="LAYER: ${this.title}" />\n';
	}
}
