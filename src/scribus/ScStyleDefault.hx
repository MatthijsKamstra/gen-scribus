package scribus;

/**
 */
class ScStyleDefault {
	var name:String = '';

	public function new(name:String = 'New Default Character Style') {
		this.name = name;
	}

	public function toString() {
		return '<STYLE
		NAME="${this.name}"
		LANGUAGE="nl"
		BCOLOR="Red"
		/>\n';
	}
}
