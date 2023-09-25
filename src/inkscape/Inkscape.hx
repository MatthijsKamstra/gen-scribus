package inkscape;

import haxe.xml.Access;
import scribus.PageSize;
import utils.Counter;

class Inkscape {
	var _xml:Xml;
	var _svg:Xml;
	var _namedView:Xml;

	var doc:Access;

	@:isVar public var pageHeight(get, set):Float; // cm / mm
	@:isVar public var pageWidth(get, set):Float; // cm / mm

	@:isVar public var marginLeft(get, set):Float;
	@:isVar public var marginRight(get, set):Float;
	@:isVar public var marginTop(get, set):Float;
	@:isVar public var marginBottom(get, set):Float;



	public function new() {
		info('Inkscape Generator');

		Counter.reset(); // start all new Inkscape document from zero

		var path = Config.ROOT + '/assets/inkscape/template_inkscape_a4.svg';
		if (sys.FileSystem.exists(path)) {
			var str:String = sys.io.File.getContent(path);
			_xml = Xml.parse(str);
			_svg = _xml.firstElement();
			_namedView = _xml.firstElement().firstElement();
			doc = new haxe.xml.Access(_xml.firstElement());
		} else {
			trace('ERROR: there is not file: $path');
		}
		addComment('[mck] start generation document');
	}

	// ____________________________________ comment ____________________________________

	public function addComment(comment:String) {
		add2document('<!-- ${comment} -->\n');
	}

	// ____________________________________ page size ____________________________________

	public function setPageSizeInMM(width:Float, height:Float) {
		// this.pageWidth = width;
		// this.pageHeight = height;
		this.pageWidth = PageSize.MM2POINTS * width;
		this.pageHeight = PageSize.MM2POINTS * height;
		// this.pageWidthMM = PageSize.MM2POINTS * width;
		// this.pageHeightMM = PageSize.MM2POINTS * height;
	}

	// ____________________________________ guides ____________________________________

	public function setVerticalGuidesInMM(arr:Array<Float>) {
		warn('WIP: setVerticalGuidesInMM');
		// var _guides = '';

		// for (i in 0...arr.length) {
		// 	var _arr = arr[i] * PageSize.MM2POINTS;
		// 	_guides += '${_arr} ';
		// }

		// // log(_guides);

		// // iterate over PAGE
		// for (c in doc.nodes.PAGE) {
		// 	// trace(c.att.Size);
		// 	c.att.VerticalGuides = '$_guides';
		// }
		// // iterate over MASTERPAGE
		// for (c in doc.nodes.MASTERPAGE) {
		// 	// trace(c.att.Size);
		// 	c.att.VerticalGuides = '$_guides';
		// }
	}

	public function setHorizontalGuidesInMM(arr:Array<Float>) {
		warn('WIP: setHorizontalGuidesInMM');
		// // log(arr);

		// var _guides = '';

		// for (i in 0...arr.length) {
		// 	var _arr = arr[i] * PageSize.MM2POINTS;
		// 	_guides += '${_arr} ';
		// }

		// // log(_guides);

		// // iterate over PAGE
		// for (c in doc.nodes.PAGE) {
		// 	// trace(c.att.Size);
		// 	c.att.HorizontalGuides = '$_guides';
		// }
		// // iterate over MASTERPAGE
		// for (c in doc.nodes.MASTERPAGE) {
		// 	// trace(c.att.Size);
		// 	c.att.HorizontalGuides = '$_guides';
		// }
	}

	// ____________________________________ bleeds ____________________________________

	public function setBleedInMM(left:Float = 0, right:Float = 0, top:Float = 0, bottom:Float = 0) {
		warn('WIP: setBleedInMM');

		// var _left:Float = left * PageSize.MM2POINTS;
		// var _right:Float = right * PageSize.MM2POINTS;
		// var _top:Float = top * PageSize.MM2POINTS;
		// var _bottom:Float = bottom * PageSize.MM2POINTS;

		// doc.att.BleedLeft = '$_left';
		// doc.att.BleedRight = '$_right';
		// doc.att.BleedTop = '$_top';
		// doc.att.BleedBottom = '$_bottom';
		// doc.att.showBleed = '1';
	}

	// ____________________________________ margins ____________________________________

	public function setMarginInMM(left:Float = 14.111, right:Float = 14.111, top:Float = 14.111, bottom:Float = 14.111) {
		warn('WIP: setMarginInMM');
		// // log('$left, $right, $top, $bottom');

		// var _left:Float = left * PageSize.MM2POINTS;
		// var _right:Float = right * PageSize.MM2POINTS;
		// var _top:Float = top * PageSize.MM2POINTS;
		// var _bottom:Float = bottom * PageSize.MM2POINTS;

		// marginLeft = _left;
		// marginRight = _right;
		// marginTop = _top;
		// marginBottom = _bottom;

		// doc.att.BORDERLEFT = '$_left';
		// doc.att.BORDERRIGHT = '$_right';
		// doc.att.BORDERTOP = '$_top';
		// doc.att.BORDERBOTTOM = '$_bottom';
	}

	// ____________________________________ page ____________________________________

	public function addPage(alias:String = ''):InkscapePage {
		if (alias != '')
			addComment(alias);

		var page = new InkscapePage();
		page.width = pageWidth;
		page.height = pageHeight;

		// page.marginLeft = marginLeft;
		// page.marginRight = marginRight;
		// page.marginTop = marginTop;
		// page.marginBottom = marginBottom;

		add2NamedView(page.toString());

		return page;
	}

	// ____________________________________ add to document ____________________________________

	function add2NamedView(str:String) {
		var namedview = _xml.firstElement().firstElement();
		namedview.addChild(Xml.parse(str));
	}

	public function add2document(str:String) {
		// var root = _xml.firstElement();
		var document = _xml.firstElement();
		document.addChild(Xml.parse(str));
	}

	// ____________________________________ to string ____________________________________

	public function toString():String {
		return _xml.toString();
	}

	// ____________________________________ getter/setter ____________________________________

	function get_pageWidth():Float {
		// var v = Std.parseFloat(doc.att.PAGEWIDTH);
		return pageWidth;
	}

	function set_pageWidth(value:Float):Float {
		return pageWidth = value;
	}

	function get_pageHeight():Float {
		return pageHeight;
	}

	function set_pageHeight(value:Float):Float {
		return pageHeight = value;
	}

	function get_marginBottom():Float {
		return marginBottom;
	}

	function set_marginBottom(value:Float):Float {
		return marginBottom = value;
	}

	function get_marginTop():Float {
		return marginTop;
	}

	function set_marginTop(value:Float):Float {
		return marginTop = value;
	}

	function get_marginRight():Float {
		return marginRight;
	}

	function set_marginRight(value:Float):Float {
		return marginRight = value;
	}

	function get_marginLeft():Float {
		return marginLeft;
	}

	function set_marginLeft(value:Float):Float {
		return marginLeft = value;
	}
}
