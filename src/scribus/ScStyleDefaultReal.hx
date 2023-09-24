package scribus;

/**
 * hmmm made a mistake with the other default style.. fix later
 */
class ScStyleDefaultReal {
	var name:String = '';

	public function new(name:String = 'Default Paragraph Style') {
		this.name = name;
	}

	public function toString() {
		return '<DefaultStyle
		PARENT="${this.name}"
		LINESPMode="1"
		CPARENT="Default Character Style"
		/>\n';
	}
}
