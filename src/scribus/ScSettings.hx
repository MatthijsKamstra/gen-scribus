package scribus;

import AST.Image;
import const.Config;
import haxe.Json;
import utils.SaveFile;

class ScSettings {
	public function new(path:String) {
		// trace('ScSettings');
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

		if (json.document.author != null) {
			scribus.setDocumentAuthor(json.document.author);
		}
		if (json.document.title != null) {
			scribus.setDocumentTitle(json.document.title);
		}
		if (json.document.description != null) {
			scribus.setDocumentDescription(json.document.description);
		}

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
		scribus.removePages();

		var pages:Array<AST.Pages> = json.pages;
		for (i in 0...pages.length) {
			var _page = pages[i];
			// warn(_page.left._alias);
			// warn(_page.right._alias);
			if (_page.left._alias != null) {
				// trace('[l]   : ' + _page.left._alias);
				createPage(scribus, _page.left);
			}
			if (_page.right._alias != null) {
				// trace('   [r]: ' + _page.right._alias);
				createPage(scribus, _page.right);
			}
		}

		var _title = json.document.title.replace(' ', '_');
		var _size = '${json.document.width.value}${json.document.width.unit}x${json.document.height.value}${json.document.height.unit}'.replace(' ', '_');
		var _fileName = '${_title}__${_size}__${json.document.language}.sla'.toLowerCase();

		var _path = Folder.EXPORT + "/" + _fileName;

		SaveFile.out(_path, scribus.toString());

		if (Config.OPEN_FILE) {
			Sys.command('open ${_path}');
		}
	}

	function createPage(scribus:Scribus, pageObj:AST.PageObj) {
		var page:ScPage = scribus.addPage(pageObj._alias);

		ScData.TOTAL_PAGES++;

		if (pageObj.images != null) {
			// info('image');
			for (i in 0...pageObj.images.length) {
				var _image:Image = pageObj.images[i];
				// scribus.addImage(page, Path.normalize(Folder.ROOT_FOLDER + '/' + _image.path));

				// new methode
				scribus.addComment('Images added by hand');
				var image = new ScImage(page, Path.normalize(Folder.ROOT_FOLDER + '/' + _image.path));
				// var image = new ScImage(page, Path.normalize(Folder.ROOT_FOLDER + '/' + 'assets/png/a4_red.png'));
				image.settings(_image);
				scribus.add2document(image.toString());

				ScData.TOTAL_IMAGES++;
			}
		}
		if (pageObj.texts != null) {
			// info('text');
			for (i in 0...pageObj.texts.length) {
				var _text = pageObj.texts[i];
				scribus.addText(page, Path.normalize(Folder.ROOT_FOLDER + '/' + _text.path));

				ScData.TOTAL_TEXT++;
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
