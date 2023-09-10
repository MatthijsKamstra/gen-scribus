package scribus;

import haxe.xml.Access;
import haxe.rtti.XmlParser;

class Scribus {
	private var _xml:Xml;

	var doc:Access;

	@:isVar public var pageSizeName(get, set):String; // ''
	@:isVar public var pageHeight(get, set):Float; // cm / mm
	@:isVar public var pageWidth(get, set):Float; // cm / mm

	@:isVar public var marginLeft(get, set):Float;
	@:isVar public var marginRight(get, set):Float;
	@:isVar public var marginTop(get, set):Float;
	@:isVar public var marginBottom(get, set):Float;

	public function new() {
		info('Scribus');

		var path = Folder.ROOT_FOLDER + '/assets/template_scribus_a4.sla';
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

		addComment('[mck] start generation document');
	}

	function addComment(comment:String) {
		var root = _xml.firstElement();
		var document = root.firstElement();
		document.addChild(Xml.parse('<!-- ${comment} -->\n'));
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
		pageSizeName = pagesize;
		doc.att.PAGESIZE = pagesize;

		// iterate over PAGE
		for (c in doc.nodes.PAGE) {
			// trace(c.att.Size);
			c.att.Size = '$pagesize';
		}
		// iterate over MASTERPAGE
		for (c in doc.nodes.MASTERPAGE) {
			// trace(c.att.Size);
			c.att.Size = '$pagesize';
		}

		if (PageSize.setValueInPoints(pagesize).width != 0.0) {
			// setPageWidth(pagesize);
			set_pageWidth(PageSize.setValueInPoints(pagesize).width);
			// setPageHeight(pagesize);
			set_pageHeight(PageSize.setValueInPoints(pagesize).height);
		}
	}

	public function isSnapToGuides(bool:Bool) {
		doc.att.SnapToGuides = '${(bool) ? '1' : '0'}';
	}

	public function isGuideLocked(bool:Bool) {
		doc.att.GUIDELOCK = '${(bool) ? '1' : '0'}';
	}

	public function addImage(page:ScPage, path:String) {
		var el = new ScImage(page, path);
		el.width = pageWidth;
		el.height = pageHeight;
		el.path = path;

		var root = _xml.firstElement();
		var document = root.firstElement();
		document.addChild(Xml.parse(el.toString()));
	}

	public function addText(page:ScPage, path:String) {
		var el = new ScText(page, path);

		el.offsetx = marginLeft;
		el.offsety = marginTop;
		el.width = pageWidth - marginLeft - marginRight;
		el.height = pageHeight - marginTop - marginBottom;
		el.path = path;

		var root = _xml.firstElement();
		var document = root.firstElement();
		document.addChild(Xml.parse(el.toString()));
	}

	// function setPageWidth(pagesize:String) {
	// 	doc.att.PAGEWIDTH = PageSize.setValueInPoints(pagesize).width;
	// }

	public function setVerticalGuidesInMM(arr:Array<Float>) {
		var _guides = '';

		for (i in 0...arr.length) {
			var _arr = arr[i] * PageSize.MM2POINTS;
			_guides += '${_arr} ';
		}

		// log(_guides);

		// iterate over PAGE
		for (c in doc.nodes.PAGE) {
			// trace(c.att.Size);
			c.att.VerticalGuides = '$_guides';
		}
		// iterate over MASTERPAGE
		for (c in doc.nodes.MASTERPAGE) {
			// trace(c.att.Size);
			c.att.VerticalGuides = '$_guides';
		}
	}

	public function setHorizontalGuidesInMM(arr:Array<Float>) {
		var _guides = '';

		for (i in 0...arr.length) {
			var _arr = arr[i] * PageSize.MM2POINTS;
			_guides += '${_arr} ';
		}

		// log(_guides);

		// iterate over PAGE
		for (c in doc.nodes.PAGE) {
			// trace(c.att.Size);
			c.att.HorizontalGuides = '$_guides';
		}
		// iterate over MASTERPAGE
		for (c in doc.nodes.MASTERPAGE) {
			// trace(c.att.Size);
			c.att.HorizontalGuides = '$_guides';
		}
	}

	public function setBleedInMM(left:Float = 0, right:Float = 0, top:Float = 0, bottom:Float = 0) {
		var _left:Float = left * PageSize.MM2POINTS;
		var _right:Float = right * PageSize.MM2POINTS;
		var _top:Float = top * PageSize.MM2POINTS;
		var _bottom:Float = bottom * PageSize.MM2POINTS;

		doc.att.BleedLeft = '$_left';
		doc.att.BleedRight = '$_right';
		doc.att.BleedTop = '$_top';
		doc.att.BleedBottom = '$_bottom';
		doc.att.showBleed = '1';
	}

	public function setMarginInMM(left:Float = 14.111, right:Float = 14.111, top:Float = 14.111, bottom:Float = 14.111) {
		var _left:Float = left * PageSize.MM2POINTS;
		var _right:Float = right * PageSize.MM2POINTS;
		var _top:Float = top * PageSize.MM2POINTS;
		var _bottom:Float = bottom * PageSize.MM2POINTS;

		marginLeft = _left;
		marginRight = _right;
		marginTop = _top;
		marginBottom = _bottom;

		doc.att.BORDERLEFT = '$_left';
		doc.att.BORDERRIGHT = '$_right';
		doc.att.BORDERTOP = '$_top';
		doc.att.BORDERBOTTOM = '$_bottom';
	}

	public function addPage(alias:String = ''):ScPage {
		if (alias != '')
			addComment(alias);

		var page = new ScPage();
		page.size = pageSizeName;
		page.width = pageWidth;
		page.height = pageHeight;

		page.marginLeft = marginLeft;
		page.marginRight = marginRight;
		page.marginTop = marginTop;
		page.marginBottom = marginBottom;

		var root = _xml.firstElement();
		var document = root.firstElement();
		document.addChild(Xml.parse(page.toString()));

		return page;
	}

	public function toString():String {
		return _xml.toString();
	}

	public function removePages() {
		for (c in doc.nodes.PAGE) {
			// log(c.x.firstChild());
			// log(c.x);
			var _parent = c.x.parent;
			// log(_parent);
			// log(_parent.removeChild(c.x));
			_parent.removeChild(c.x);
		}
	}

	public function removeMasterPages() {
		for (c in doc.nodes.MASTERPAGE) {
			// log(c.x.firstChild());
			// log(c.x);
			var _parent = c.x.parent;
			// log(_parent);
			// log(_parent.removeChild(c.x));
			_parent.removeChild(c.x);
		}
	}

	// ____________________________________ getter/setter ____________________________________

	function get_pageSizeName():String {
		return pageSizeName;
	}

	function set_pageSizeName(value:String):String {
		return pageSizeName = value;
	}

	function get_pageWidth():Float {
		// var v = Std.parseFloat(doc.att.PAGEWIDTH);
		return pageWidth;
	}

	function set_pageWidth(value:Float):Float {
		doc.att.PAGEWIDTH = '$value';

		// var newValue:String = '$value';
		// var str = _xml.toString();
		// var regex = ~/PAGEWIDTH="[\d.]+"/g;
		// var replacedString = regex.replace(str, 'PAGEWIDTH="' + newValue + '"');
		// _xml = Xml.parse(replacedString);
		// init();

		// iterate over PAGE
		for (c in doc.nodes.PAGE) {
			// trace(c.att.Size);
			c.att.PAGEWIDTH = '$value';
		}
		// iterate over MASTERPAGE
		for (c in doc.nodes.MASTERPAGE) {
			// trace(c.att.Size);
			c.att.PAGEWIDTH = '$value';
		}

		return pageWidth = value;
	}

	function get_pageHeight():Float {
		// var v = Std.parseFloat(doc.att.PAGEHEIGHT);
		return pageHeight;
	}

	function set_pageHeight(value:Float):Float {
		doc.att.PAGEHEIGHT = '$value';

		// var newValue:String = '$value';
		// var str = _xml.toString();
		// var regex = ~/PAGEHEIGHT="[\d.]+"/g;
		// var replacedString = regex.replace(str, 'PAGEHEIGHT="' + newValue + '"');
		// _xml = Xml.parse(replacedString);

		// iterate over PAGE
		for (c in doc.nodes.PAGE) {
			// trace(c.att.Size);
			c.att.PAGEHEIGHT = '$value';
		}
		// iterate over MASTERPAGE
		for (c in doc.nodes.MASTERPAGE) {
			// trace(c.att.Size);
			c.att.PAGEHEIGHT = '$value';
		}

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
