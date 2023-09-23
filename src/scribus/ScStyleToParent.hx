package scribus;

/**
 */
class ScStyleToParent {
	var name:String = '';
	var parent:String;

	public function new(parent:String, name:String) {
		this.name = name;
		this.parent = parent;
	}

	public function toString() {
		return '<STYLE
		NAME="${this.name}"
		PARENT="${this.parent}"
		/>\n';
	}
}
