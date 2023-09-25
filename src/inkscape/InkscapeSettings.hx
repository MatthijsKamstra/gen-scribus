package inkscape;

import AST.Image;
import haxe.Json;
import utils.SaveFile;

class InkscapeSettings {
	public function new(path:String) {
		info('InkscapeSettings');
		init(path);
	}

	function init(path:String) {
		// read the file
		var content = sys.io.File.getContent(path);
		var json:AST.HxSettingsObj = Json.parse(content);
		// log(json.document.author);

		var bleedMap = convertBleed(json.document.bleeds);
		var marginMap = convertMargin(json.document.margins);

		// log(bleedMap);
		// log(marginMap);

		var inkscape = new Inkscape();
		inkscape.setPageSizeInMM(json.document.width.value, json.document.height.value);
		inkscape.setMarginInMM(marginMap.get('left'), marginMap.get('right'), marginMap.get('top'), marginMap.get('bottom'));
		inkscape.setBleedInMM(bleedMap.get('left'), bleedMap.get('right'), bleedMap.get('top'), bleedMap.get('bottom'));

		if (json.document.title != null) {
			// inkscape.setDocumentTitle(json.document.title);
		}

		var pages:Array<AST.Pages> = json.pages;
		for (i in 0...pages.length) {
			var _page = pages[i];
			// warn(_page.left._alias);
			// warn(_page.right._alias);
			if (_page.left._alias != null) {
				// trace('[l]   : ' + _page.left._alias);
				createPage(inkscape, _page.left);
			}
			if (_page.right._alias != null) {
				// trace('   [r]: ' + _page.right._alias);
				createPage(inkscape, _page.right);
			}
		}

		var _title = json.document.title.replace(' ', '_').replace(',', '_').replace('.', '_');
		var _size = '${json.document.width.value}${json.document.width.unit}x${json.document.height.value}${json.document.height.unit}'.replace(' ', '_');
		var _fileName = '${_title}__${_size}__${json.document.language}.svg'.toLowerCase();

		var _path = Folder.EXPORT + "/" + _fileName;

		SaveFile.out(_path, inkscape.toString());

		if (Config.OPEN_FILE) {
			Sys.command('open ${_path}');
		}
	}

	function createPage(inkscape:Inkscape, pageObj:AST.PageObj) {
		var page:InkscapePage = inkscape.addPage(pageObj._alias);
		inkscape.addLayer(pageObj._alias);

		InkscapeData.TOTAL_PAGES++;

		// if (pageObj.images != null) {
		// 	for (i in 0...pageObj.images.length) {
		// 		var _image:Image = pageObj.images[i];

		// 		// inkscape.addComment('Images added by hand');
		// 		var image = new InkscapeImage(page, Path.normalize(Folder.ROOT_FOLDER + '/' + _image.path));
		// 		image.settings(_image);
		// 		inkscape.add2document(image.toString());

		// 		InkscapeData.TOTAL_IMAGES++;
		// 	}
		// }
		// if (pageObj.texts != null) {
		// 	// info('text');
		// 	for (i in 0...pageObj.texts.length) {
		// 		var _text = pageObj.texts[i];

		// 		// inkscape.addComment('Text added by hand');
		// 		var text = new InkscapeText(page, Path.normalize(Folder.ROOT_FOLDER + '/' + _text.path));
		// 		text.settings(_text);
		// 		// if (_text.style != null) {
		// 		// 	text.useStyle(_text.style + " New Paragraph Style");
		// 		// }
		// 		inkscape.add2document(text.toString());

		// 		InkscapeData.TOTAL_TEXT++;
		// 	}
		// }
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
