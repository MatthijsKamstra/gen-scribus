package scribus;

import haxe.xml.Access;
import haxe.rtti.XmlParser;

class Scribus {
	private var _xml:Xml;

	var doc:Access;

	public function new() {
		info('Scribus');

		var path = Folder.ROOT_FOLDER + '/assets/scribus_a4.sla';
		if (sys.FileSystem.exists(path)) {
			var str:String = sys.io.File.getContent(path);
			_xml = Xml.parse(str);
		} else {
			trace('ERROR: there is not file: $path');
		}

		// _xml = Xml.createElement('SCRIBUSUTF8NEW')

		// wrap the Xml for Access
		var access = new haxe.xml.Access(_xml.firstElement());

		// log(access);
		// log(access.node.DOCUMENT);

		// // // access the "phone" child, which is wrapped with haxe.xml.Access too
		doc = access.node.DOCUMENT;
		// // iterate over numbers
		// for (c in doc.nodes.COLOR) {
		// 	trace(c.att.SPACE);
		// }

		// // log(doc);
		// log(doc.att.PAGESIZE);
		// log(doc.att.LANGUAGE);
	}

	public function addColorRGB(name:String, r:Int, g:Int, b:Int) {
		var root = _xml.firstElement();
		var document = root.firstElement();
		document.addChild(Xml.parse('<COLOR SPACE="RGB" NAME="${name}"R="${r}" G="${g}" B="${b}"/>\n'));
	}

	public function addColorCMYK(name:String, c:Int, m:Int, y:Int, k:Int) {
		var root = _xml.firstElement();
		var document = root.firstElement();
		document.addChild(Xml.parse('<COLOR SPACE="CMYK" NAME="${name}" C="${c}" M="${m}" Y="${y}" K="${k}"/>\n'));
	}

	public function setLanguage(s:String) {
		doc.att.LANGUAGE = s;
	}

	public function setPageSize(pagesize:String) {
		doc.att.PAGESIZE = pagesize;
		setPageWidth(pagesize);
		setPageHeight(pagesize);
	}

	function setPageWidth(pagesize:String) {
		doc.att.PAGEWIDTH = PageSize.setValueInPoints(pagesize).width;
	}

	function setPageHeight(pagesize:String) {
		doc.att.PAGEHEIGHT = PageSize.setValueInPoints(pagesize).height;
	}

	public function xml():String {
		return _xml.toString();
	}
}
