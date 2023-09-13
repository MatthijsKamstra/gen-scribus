package scribus;

import AST.PageObj;
import sys.FileSystem;
import haxe.Json;
import utils.SaveFile;

class ScSettings {
	public function new(path:String) {
		trace('ScSettings');

		init(path);
	}

	function init(path:String) {
		// read the file
		var content = sys.io.File.getContent(path);
		var json:AST.HxSettingsObj = Json.parse(content);
		// log(json.document.author);

		var _pageSize = json.document.pageName;
		var _pageLanguage = json.document.language;
		// var _pageWidth = PageSize.MM2POINTS * json.document.width.value;
		// var _pageHeight = PageSize.MM2POINTS * json.document.height.value;

		var bleedMap = convertBleed(json.document.bleeds);
		var marginMap = convertMargin(json.document.margins);

		// log(bleedMap);
		// log(marginMap);

		var scribus = new Scribus();
		scribus.setLanguage(_pageLanguage);
		scribus.setPageName(_pageSize);
		scribus.isSnapToGuides(json.document.guideSnap);
		scribus.isGuideLocked(json.document.guideLocked);
		scribus.setPageSizeInMM(json.document.width.value, json.document.height.value);
		scribus.setMarginInMM(marginMap.get('left'), marginMap.get('right'), marginMap.get('top'), marginMap.get('bottom'));
		scribus.setBleedInMM(bleedMap.get('left'), bleedMap.get('right'), bleedMap.get('top'), bleedMap.get('bottom'));
		scribus.setHorizontalGuidesInMM([marginMap.get('top')]);
		scribus.setVerticalGuidesInMM([marginMap.get('left')]);

		// scribus.removeStyle();

		// // scribus.defaultFont('Titillium Web Regular', 11);
		// // scribus.addDefaultStyle('Titillium Web Regular', 11);
		// // scribus.addStyle('Text3_Heading 1', 24);
		// // scribus.addStyle('Text3_Heading 2', 20);
		// // scribus.addStyle('Text3_Heading 3', 18);
		// // scribus.addStyle('Text3_Heading 4', 16);
		// // scribus.addStyle('Text3_Heading 5', 14);
		// // scribus.addStyle('Text3_Heading 6', 12);

		scribus.dumpStyle();

		// // scribus.removeMasterPages();
		// scribus.removePages();

		var pages:Array<AST.Pages> = json.pages;
		for (i in 0...pages.length) {
			var _page = pages[i];
			if (_page.left._alias != null) {
				trace('[l]   : ' + _page.left._alias);
				createPage(scribus, _page.left);
			}
			if (_page.right._alias != null) {
				trace('   [r]: ' + _page.right._alias);
				createPage(scribus, _page.right);
			}
		}

		SaveFile.out(Folder.BIN + '/_gen_scribus_${_pageSize.replace(' ', '_')}_${_pageLanguage}.sla', scribus.toString());

		Sys.command('open ./bin/_gen_scribus_Custom_boo_nl.sla');
	}

	function createPage(scribus:Scribus, pageObj:AST.PageObj) {
		var page:ScPage = scribus.addPage(pageObj._alias);
		if (pageObj.images != null) {
			// info('image');
			for (i in 0...pageObj.images.length) {
				var _image = pageObj.images[i];
				scribus.addImage(page, Path.normalize(Sys.getCwd() + _image.path));
			}
		}
		if (pageObj.texts != null) {
			// info('text');
			for (i in 0...pageObj.texts.length) {
				var _text = pageObj.texts[i];
				scribus.addText(page, Path.normalize(Sys.getCwd() + _text.path));
			}
		}
	}

	function convertBleed(bleeds:Array<AST.DirValueObj>):Map<String, Float> {
		// left, right, top, bottom
		var map:Map<String, Float> = ['left' => 0, 'right' => 0, 'top' => 0, 'bottom' => 0];
		for (i in 0...bleeds.length) {
			var b:AST.DirValueObj = bleeds[i];
			map.set(b.dir, b.value);
		}
		return map;
	}

	function convertMargin(margins:Array<AST.DirValueObj>):Map<String, Float> {
		// left, right, top, bottom
		var map:Map<String, Float> = ['left' => 0, 'right' => 0, 'top' => 0, 'bottom' => 0];
		for (i in 0...margins.length) {
			var m:AST.DirValueObj = margins[i];
			map.set(m.dir, m.value);
		}
		return map;
	}
}
