package scribus;

import haxe.xml.Access;
import haxe.rtti.XmlParser;

class Scribus {
	private var _xml:Xml;

	var doc:Access;

	@:isVar public var pageHeight(get, set):Float; // cm
	@:isVar public var pageWidth(get, set):Float; // cm

	public function new() {
		info('Scribus');

		var path = Folder.ROOT_FOLDER + '/assets/scribus_a4.sla';
		if (sys.FileSystem.exists(path)) {
			var str:String = sys.io.File.getContent(path);
			_xml = Xml.parse(str);
		} else {
			trace('ERROR: there is not file: $path');
		}
		init();
	}

	function init() {
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
		// // iterate over numbers
		// for (c in doc.nodes.PAGE) {
		// 	trace(c.att.Size);
		// }

		// log(doc.nodes.PAGE[0]);

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
		if (PageSize.setValueInPoints(pagesize).width != 0.0) {
			// setPageWidth(pagesize);
			set_pageWidth(PageSize.setValueInPoints(pagesize).width);
			// setPageHeight(pagesize);
			set_pageHeight(PageSize.setValueInPoints(pagesize).height);
		}
	}

	// function setPageWidth(pagesize:String) {
	// 	doc.att.PAGEWIDTH = PageSize.setValueInPoints(pagesize).width;
	// }
	function get_pageWidth():Float {
		// var v = Std.parseFloat(doc.att.PAGEWIDTH);
		return pageWidth;
	}

	function set_pageWidth(value:Float):Float {
		// doc.att.PAGEWIDTH = '$value';

		var newValue:String = '$value';
		var str = _xml.toString();
		var regex = ~/PAGEWIDTH="[\d.]+"/g;
		var replacedString = regex.replace(str, 'PAGEWIDTH="' + newValue + '"');
		_xml = Xml.parse(replacedString);

		init();
		return pageWidth = value;
	}

	function get_pageHeight():Float {
		// var v = Std.parseFloat(doc.att.PAGEHEIGHT);
		return pageHeight;
	}

	function set_pageHeight(value:Float):Float {
		// doc.att.PAGEHEIGHT = '$value';

		var newValue:String = '$value';
		var str = _xml.toString();
		var regex = ~/PAGEHEIGHT="[\d.]+"/g;
		var replacedString = regex.replace(str, 'PAGEHEIGHT="' + newValue + '"');
		_xml = Xml.parse(replacedString);

		return pageHeight = value;
	}

	public function addPage(pageSize:String, pageWidth:Float, pageHeight:Float) {
		log('addpage');
		// var page = '${doc.nodes.MASTERPAGE[0]}\n' //
		// 	.replace('MASTERPAGE', 'PAGE') //
		// 	.replace('MNAM=""', 'MNAM="Normal"') //
		// 	.replace('NAM="Normal"', 'NAM=""');
		// var root = _xml.firstElement();
		// var document = root.firstElement();
		// document.addChild(Xml.parse(page));
		var page = new Page();
		page.size = pageSize;
		page.width = pageWidth;
		page.height = pageHeight;
		var root = _xml.firstElement();
		var document = root.firstElement();
		document.addChild(Xml.parse(page.toString()));
	}

	public function xml():String {
		return _xml.toString();
	}

	/**
	 *
	 * werkt niet...
	 */
	public function removePages() {
		for (c in doc.nodes.PAGE) {
			// log(c.x.firstChild());
			// log(c.x);
			var _parent = c.x.parent;
			// log(_parent);
			log(_parent.removeChild(c.x));
			// _parent.addChild(c.x);
		}

		log(_xml);
	}
}
