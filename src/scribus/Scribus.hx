package scribus;

import const.Config;
import const.StyleName;
import haxe.xml.Access;
import utils.Counter;

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

		Counter.reset(); // start all new Scribus document from zero

		var path = Config.ROOT + '/assets/template_scribus_a4.sla';
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

	// ____________________________________ document ____________________________________

	public function setDocumentAuthor(arg:Null<String>) {
		doc.att.AUTHOR = arg;
	}

	public function setDocumentTitle(arg:Null<String>) {
		doc.att.TITLE = arg;
	}

	public function setDocumentDescription(arg:Null<String>) {
		doc.att.COMMENTS = arg;
	}

	public function setLanguage(s:String) {
		doc.att.LANGUAGE = s;
	}

	// ____________________________________ comment ____________________________________

	public function addComment(comment:String) {
		add2document('<!-- ${comment} -->\n');
	}

	// ____________________________________ color ____________________________________

	public function addColorRGB(name:String, r:Int, g:Int, b:Int) {
		add2document('<COLOR SPACE="RGB" NAME="${name}"R="${r}" G="${g}" B="${b}"/>\n');
	}

	public function addColorCMYK(name:String, c:Int, m:Int, y:Int, k:Int) {
		add2document('<COLOR SPACE="CMYK" NAME="${name}" C="${c}" M="${m}" Y="${y}" K="${k}"/>\n');
	}

	// ____________________________________ page size ____________________________________

	public function setPageName(pagesize:String) {
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

	public function setPageSizeInMM(width:Float, height:Float) {
		this.pageWidth = PageSize.MM2POINTS * width;
		this.pageHeight = PageSize.MM2POINTS * height;
		// this.pageWidthMM = PageSize.MM2POINTS * width;
		// this.pageHeightMM = PageSize.MM2POINTS * height;
	}

	// ____________________________________ booleans ____________________________________

	public function isSnapToGuides(bool:Bool) {
		doc.att.SnapToGuides = '${(bool) ? '1' : '0'}';
	}

	public function isGuideLocked(bool:Bool) {
		doc.att.GUIDELOCK = '${(bool) ? '1' : '0'}';
	}

	// ____________________________________ add image/text ____________________________________

	public function addImage(page:ScPage, path:String) {
		var el = new ScImage(page, path);
		el.width = pageWidth;
		el.height = pageHeight;
		el.path = path;

		add2document(el.toString());
	}

	public function addText(page:ScPage, path:String) {
		var el = new ScText(page, path);

		el.offsetx = marginLeft;
		el.offsety = marginTop;
		el.width = pageWidth - marginLeft - marginRight;
		el.height = pageHeight - marginTop - marginBottom;
		el.path = path;

		add2document(el.toString());
	}

	// function setPageWidth(pagesize:String) {
	// 	doc.att.PAGEWIDTH = PageSize.setValueInPoints(pagesize).width;
	// }
	// ____________________________________ guides ____________________________________

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
		// log(arr);

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

	// ____________________________________ bleeds ____________________________________

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

	// ____________________________________ margins ____________________________________

	public function setMarginInMM(left:Float = 14.111, right:Float = 14.111, top:Float = 14.111, bottom:Float = 14.111) {
		// log('$left, $right, $top, $bottom');

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

		add2document(page.toString());

		return page;
	}

	// ____________________________________ style ____________________________________

	public function addStyleToParent(parent:String, name:String) {
		var el = new ScStyleToParent(parent, name);
		add2document(el.toString());
	}

	public function addCharacter(name:String) {
		var el = new ScStyleChar(name);
		add2document(el.toString());
	}

	public function addDefaultStyle(name:String) {
		var style = new ScStyleDefault(name);
		add2document(style.toString());
		return style;
	}

	public function addStyle(name:String, fontsize:Int = 11) {
		var style = new ScStyle(name, fontsize);
		add2document(style.toString());
		return style;
	}

	public function defaultFont(name:String, fontsize:Int) {
		var font = new ScFont(name, fontsize);
		add2document(font.toString());
		return font;
	}

	public function dumpStyle() {
		var dump = '';

		// var dump = '<CHARSTYLE CNAME="Default Character Style" DefaultStyle="1" FONT="Titillium Web Regular" FONTSIZE="11" FONTFEATURES="" FEATURES="inherit" FCOLOR="Black" FSHADE="100" HyphenWordMin="3" SCOLOR="Black" BGCOLOR="None" BGSHADE="100" SSHADE="100" TXTSHX="5" TXTSHY="-5" TXTOUT="1" TXTULP="-0.1" TXTULW="-0.1" TXTSTP="-0.1" TXTSTW="-0.1" SCALEH="100" SCALEV="100" BASEO="0" KERN="0" LANGUAGE="en_GB"/>\n<CHARSTYLE CNAME="Text5_Bold" CPARENT="Default Character Style" FONT="Titillium Web Bold"/>\n<CHARSTYLE CNAME="Text5_BoldItalic" CPARENT="Default Character Style" FONT="Titillium Web Bold Italic"/>\n<STYLE NAME="Default Paragraph Style" DefaultStyle="1" ALIGN="0" DIRECTION="0" LINESPMode="0" LINESP="15" INDENT="0" RMARGIN="0" FIRST="0" VOR="0" NACH="0" ParagraphEffectOffset="0" DROP="0" DROPLIN="2" Bullet="0" Numeration="0" HyphenConsecutiveLines="2" BCOLOR="None" BSHADE="100" CPARENT="Default Character Style"/>\n<STYLE NAME="Text3_Heading 1" PARENT="Default Paragraph Style" LINESPMode="1" LINESP="21" FIRST="0" VOR="0" NACH="5" OpticalMargins="0" FONT="Dosis Regular" FONTSIZE="24" FONTFEATURES="-clig" BASEO="15" LANGUAGE="nl"/>\n<STYLE NAME="Text3_Heading 2" PARENT="Default Paragraph Style" LINESPMode="1" VOR="7" FONT="Dosis Regular" FONTSIZE="20" FONTFEATURES="-clig"/>\n<STYLE NAME="Text3_Heading 3" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="18" FONTFEATURES="-clig"/>\n<STYLE NAME="Text3_Heading 4" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="16" FONTFEATURES="-clig"/>\n<STYLE NAME="Text3_Heading 5" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="14" FONTFEATURES="-clig"/>\n<STYLE NAME="Text3_Heading 6" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="12" FONTFEATURES="-clig"/>\n<STYLE NAME="Text5_Numbered List 1" PARENT="Default Paragraph Style" LINESPMode="1" Numeration="1"/>';

		// var dump = '<CHARSTYLE CNAME="Default Character Style" DefaultStyle="1" FONT="Titillium Web Regular" FONTSIZE="11" FONTFEATURES="" FEATURES="inherit" FCOLOR="Black" FSHADE="100" HyphenWordMin="3" SCOLOR="Black" BGCOLOR="None" BGSHADE="100" SSHADE="100" TXTSHX="5" TXTSHY="-5" TXTOUT="1" TXTULP="-0.1" TXTULW="-0.1" TXTSTP="-0.1" TXTSTW="-0.1" SCALEH="100" SCALEV="100" BASEO="0" KERN="0" LANGUAGE="en_GB"/>
		// <CHARSTYLE CNAME="Text5_Bold" CPARENT="Default Character Style" FONT="Titillium Web Bold"/>
		// <CHARSTYLE CNAME="Text5_BoldItalic" CPARENT="Default Character Style" FONT="Titillium Web Bold Italic"/>
		// <STYLE NAME="Default Paragraph Style" DefaultStyle="1" ALIGN="0" DIRECTION="0" LINESPMode="0" LINESP="15" INDENT="0" RMARGIN="0" FIRST="0" VOR="0" NACH="0" ParagraphEffectOffset="0" DROP="0" DROPLIN="2" Bullet="0" Numeration="0" HyphenConsecutiveLines="2" BCOLOR="None" BSHADE="100" CPARENT="Default Character Style"/>
		// <STYLE NAME="Text3_Heading 1" PARENT="Default Paragraph Style" LINESPMode="1" LINESP="21" FIRST="0" VOR="0" NACH="5" OpticalMargins="0" FONT="Dosis Regular" FONTSIZE="24" FONTFEATURES="-clig" BASEO="15" LANGUAGE="nl"/>
		// <STYLE NAME="Text3_Heading 2" PARENT="Default Paragraph Style" LINESPMode="1" VOR="7" FONT="Dosis Regular" FONTSIZE="20" FONTFEATURES="-clig"/>
		// <STYLE NAME="Text3_Heading 3" PARENT="Default Paragraph Style" LINESPMode="1" VOR="7" FONT="Dosis Regular" FONTSIZE="18" FONTFEATURES="-clig"/>
		// <STYLE NAME="Text3_Heading 4" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="16" FONTFEATURES="-clig"/>
		// <STYLE NAME="Text3_Heading 5" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="14" FONTFEATURES="-clig"/>
		// <STYLE NAME="Text3_Heading 6" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="12" FONTFEATURES="-clig"/>
		// <STYLE NAME="Text5_Numbered List 1" PARENT="Default Paragraph Style" LINESPMode="1" Numeration="1"/>';

		dump = '<CHARSTYLE CNAME="Default Character Style" DefaultStyle="1" FONT="Titillium Web Regular" FONTSIZE="11" FONTFEATURES="" FEATURES="inherit" FCOLOR="Black" FSHADE="100" HyphenWordMin="3" SCOLOR="Black" BGCOLOR="None" BGSHADE="100" SSHADE="100" TXTSHX="5" TXTSHY="-5" TXTOUT="1" TXTULP="-0.1" TXTULW="-0.1" TXTSTP="-0.1" TXTSTW="-0.1" SCALEH="100" SCALEV="100" BASEO="0" KERN="0" LANGUAGE="en_GB"/>
        <CHARSTYLE CNAME="${StyleName.BOLD}" CPARENT="Default Character Style" FONT="Titillium Web Bold"/>
        <CHARSTYLE CNAME="${StyleName.BOLD_ITALIC}" CPARENT="Default Character Style" FONT="Titillium Web Bold Italic"/>
        <CHARSTYLE CNAME="${StyleName.ITALIC}" CPARENT="Default Character Style" FONT="Titillium Web Italic" />
		<STYLE NAME="Default Paragraph Style" DefaultStyle="1" ALIGN="0" DIRECTION="0" LINESPMode="0" LINESP="15" INDENT="0" RMARGIN="0" FIRST="0" VOR="0" NACH="0" ParagraphEffectOffset="0" DROP="0" DROPLIN="2" Bullet="0" Numeration="0" HyphenConsecutiveLines="2" BCOLOR="None" BSHADE="100" CPARENT="Default Character Style"/>
        <STYLE NAME="${StyleName.H1}" PARENT="Default Paragraph Style" LINESPMode="1" LINESP="21" FIRST="0" VOR="0" NACH="5" OpticalMargins="0" FONT="Dosis Regular" FONTSIZE="24" FONTFEATURES="-clig" BASEO="15" LANGUAGE="nl"/>
        <STYLE NAME="${StyleName.H2}" PARENT="Default Paragraph Style" LINESPMode="1" VOR="7" FONT="Dosis Regular" FONTSIZE="20" FONTFEATURES="-clig"/>
        <STYLE NAME="${StyleName.H3}" PARENT="Default Paragraph Style" LINESPMode="1" VOR="7" FONT="Dosis Regular" FONTSIZE="18" FONTFEATURES="-clig"/>
        <STYLE NAME="${StyleName.H4}" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="16" FONTFEATURES="-clig"/>
        <STYLE NAME="${StyleName.H5}" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="14" FONTFEATURES="-clig"/>
        <STYLE NAME="${StyleName.H6}" PARENT="Default Paragraph Style" LINESPMode="1" FONT="Dosis Regular" FONTSIZE="12" FONTFEATURES="-clig"/>
        <STYLE NAME="Text5_Numbered List 1" PARENT="Default Paragraph Style" LINESPMode="1" Numeration="1"/>
        <STYLE NAME="Text7_Numbered List 1" PARENT="Default Paragraph Style" LINESPMode="1" Numeration="1"/>
		<STYLE NAME="Text1_List 1" PARENT="Default Paragraph Style" LINESPMode="1" Bullet="1" BulletStr="•"/>
		<STYLE NAME="${StyleName.BLOCKQUOTES}" PARENT="Default Paragraph Style" LINESPMode="1" Numeration="1"/>
		<STYLE NAME="${StyleName.LIST}" PARENT="Default Paragraph Style" DIRECTION="0" LINESPMode="1" INDENT="0" ParagraphEffectOffset="2.83464566929134" ParagraphEffectIndent="0" Bullet="1" BulletStr="»" OpticalMargins="0" HyphenConsecutiveLines="2" MinWordTrack="1"/>
		<STYLE NAME="${StyleName.LIST_NUMBERED}" PARENT="Default Paragraph Style" LINESPMode="1" ParagraphEffectOffset="2.83464566929134" Numeration="1" NumerationOther="1"/>

		';

		add2document(dump.toString());
	}

	// ____________________________________ misc/tools ____________________________________

	public function add2document(str:String) {
		var root = _xml.firstElement();
		var document = root.firstElement();
		document.addChild(Xml.parse(str));
	}

	// ____________________________________ to string ____________________________________

	public function toString():String {
		return _xml.toString();
	}

	// ____________________________________ remove ____________________________________

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

	public function removeStyle() {
		for (c in doc.nodes.STYLE) {
			// log(c.x.firstChild());
			// log(c.x);
			var _parent = c.x.parent;
			// log(_parent);
			// log(_parent.removeChild(c.x));
			_parent.removeChild(c.x);
		}
		for (c in doc.nodes.CHARSTYLE) {
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
