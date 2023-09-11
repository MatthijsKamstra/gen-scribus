import haxe.display.JsonModuleTypes.JsonDoc;
import haxe.Json;
import scribus.ScPage;
import scribus.PageSize;
import scribus.Locale;
import scribus.Scribus;
import utils.SaveFile;
import scribus.Scribus;

class Main {
	public function new() {
		info('Start project: "${Project.NAME}"');

		init();

		// create Scibus document, with adjustments
		// createScribus();
		// createScribusA4NL();
		// createScribusA5EN();
		createScribusCustomNL();

		// test();

		useSettings('scribus_148x148mm.json');
	}

	function init() {
		info('init');

		Folder.ROOT_FOLDER = Sys.getCwd();
		Folder.DOCS = Path.join([Sys.getCwd(), 'docs']);
		Folder.BIN = Path.join([Sys.getCwd(), 'bin']);

		info('Folder.ROOT_FOLDER: ${Folder.ROOT_FOLDER}');
		info('Folder.DOCS: ${Folder.DOCS}');
		info('Folder.BIN: ${Folder.BIN}');
	}

	function useSettings(path:String) {
		// read the file
		var content = sys.io.File.getContent(path);
		var json:AST.HxSettingsObj = Json.parse(content);
		// log(json.document.author);

		var _pageSize = json.document.pageName;
		var _pageLanguage = json.document.language;
		var _pageWidth = PageSize.MM2POINTS * json.document.width.value;
		var _pageHeight = PageSize.MM2POINTS * json.document.height.value;

		// var mt = json.document.margins.

		var scribus = new Scribus();
		scribus.setLanguage(_pageLanguage);
		scribus.setPageSize(_pageSize);
		scribus.isSnapToGuides(json.document.guideSnap);
		scribus.isGuideLocked(json.document.guideLocked);
		scribus.setMarginInMM(14, 14, 14, 14);
		scribus.setBleedInMM(3, 3, 3, 3);
		scribus.setHorizontalGuidesInMM([14, 148 - 14]);
		scribus.setVerticalGuidesInMM([14, 148 - 14]);

		scribus.pageWidth = _pageWidth;
		scribus.pageHeight = _pageHeight;

		scribus.removeStyle();

		// scribus.defaultFont('Titillium Web Regular', 11);
		// scribus.addDefaultStyle('Titillium Web Regular', 11);
		// scribus.addStyle('Text3_Heading 1', 24);
		// scribus.addStyle('Text3_Heading 2', 20);
		// scribus.addStyle('Text3_Heading 3', 18);
		// scribus.addStyle('Text3_Heading 4', 16);
		// scribus.addStyle('Text3_Heading 5', 14);
		// scribus.addStyle('Text3_Heading 6', 12);

		scribus.dumpStyle();

		// scribus.removeMasterPages();
		scribus.removePages();

		var page:ScPage = scribus.addPage('cover (right)');
		scribus.addImage(page, '../assets/svg/snippets_piramide van Lencioni.png');
		// scribus.addText(page, '../assets/markdown/simple.md');

		page = scribus.addPage('inner side cover (left)');
		// scribus.addImage(page, '../assets/png/a4_colors_Layer 1_copy_5.png');
		// scribus.addText(page, '../assets/markdown/simple.md');

		page = scribus.addPage('inhoud (right)');
		scribus.addImage(page, '../assets/png/a4_gray.png');

		page = scribus.addPage('text (left)');
		scribus.addText(page, '../assets/markdown/test_heading.md');
		page = scribus.addPage('image (right)');
		scribus.addImage(page, '../assets/png/a4_green.png');

		page = scribus.addPage('text (left)');
		scribus.addText(page, '../assets/markdown/maslow.md');
		page = scribus.addPage('image (right)');
		scribus.addImage(page, '../assets/png/a4_pink.png');

		page = scribus.addPage('text (left)');
		scribus.addText(page, '../assets/markdown/test_simple.md');
		page = scribus.addPage('image (right)');
		scribus.addImage(page, '../assets/png/a4_red.png');

		page = scribus.addPage();
		scribus.addImage(page, '../assets/svg/snippets_piramide van Lencioni.svg');

		SaveFile.out(Folder.BIN + '/_gen_scribus_${_pageSize}_${_language}.sla', scribus.toString());
	}

	function createScribus() {
		var pagesize = PageSize.A3;
		var language = Locale.EN_US;

		var scribus = new Scribus();

		scribus.setPageSize(pagesize);
		scribus.setLanguage(language);

		scribus.addColorRGB('test_mck_rgb', 0, 10, 20);
		scribus.addColorCMYK('test_mck_cmyk', 0, 10, 20, 30);

		SaveFile.out(Folder.BIN + '/_gen_scribus_${pagesize}_${language}_combo.sla', scribus.toString());
	}

	function createScribusA4NL() {
		var pagesize = PageSize.A4;
		var language = Locale.NL;
		var scribus = new Scribus();

		scribus.setPageSize(pagesize);
		scribus.setLanguage(language);

		SaveFile.out(Folder.BIN + '/_gen_scribus_${pagesize}_${language}.sla', scribus.toString());
	}

	function createScribusA5EN() {
		var pagesize = PageSize.A5;
		var language = Locale.EN_GB;
		var scribus = new Scribus();

		scribus.setPageSize(pagesize);
		scribus.setLanguage(language);

		SaveFile.out(Folder.BIN + '/_gen_scribus_${pagesize}_${language}.sla', scribus.toString());
	}

	function createScribusCustomNL() {
		var _pageSize = 'Custom 148x148mm';
		var _pageWidth = PageSize.MM2POINTS * 148;
		var _pageHeight = PageSize.MM2POINTS * 148;

		var _language = Locale.NL;

		var scribus = new Scribus();
		scribus.setLanguage(_language);
		scribus.setPageSize(_pageSize);
		scribus.setMarginInMM(14, 14, 14, 14);
		scribus.setBleedInMM(3, 3, 3, 3);
		scribus.setHorizontalGuidesInMM([14, 148 - 14]);
		scribus.setVerticalGuidesInMM([14, 148 - 14]);
		scribus.isSnapToGuides(true);
		scribus.isGuideLocked(true);

		scribus.pageWidth = _pageWidth;
		scribus.pageHeight = _pageHeight;

		scribus.removeStyle();

		// scribus.defaultFont('Titillium Web Regular', 11);
		// scribus.addDefaultStyle('Titillium Web Regular', 11);
		// scribus.addStyle('Text3_Heading 1', 24);
		// scribus.addStyle('Text3_Heading 2', 20);
		// scribus.addStyle('Text3_Heading 3', 18);
		// scribus.addStyle('Text3_Heading 4', 16);
		// scribus.addStyle('Text3_Heading 5', 14);
		// scribus.addStyle('Text3_Heading 6', 12);

		scribus.dumpStyle();

		// scribus.removeMasterPages();
		scribus.removePages();

		var page:ScPage = scribus.addPage('cover (right)');
		scribus.addImage(page, '../assets/svg/snippets_piramide van Lencioni.png');
		// scribus.addText(page, '../assets/markdown/simple.md');

		page = scribus.addPage('inner side cover (left)');
		// scribus.addImage(page, '../assets/png/a4_colors_Layer 1_copy_5.png');
		// scribus.addText(page, '../assets/markdown/simple.md');

		page = scribus.addPage('inhoud (right)');
		scribus.addImage(page, '../assets/png/a4_gray.png');

		page = scribus.addPage('text (left)');
		scribus.addText(page, '../assets/markdown/test_heading.md');
		page = scribus.addPage('image (right)');
		scribus.addImage(page, '../assets/png/a4_green.png');

		page = scribus.addPage('text (left)');
		scribus.addText(page, '../assets/markdown/maslow.md');
		page = scribus.addPage('image (right)');
		scribus.addImage(page, '../assets/png/a4_pink.png');

		page = scribus.addPage('text (left)');
		scribus.addText(page, '../assets/markdown/test_simple.md');
		page = scribus.addPage('image (right)');
		scribus.addImage(page, '../assets/png/a4_red.png');

		page = scribus.addPage();
		scribus.addImage(page, '../assets/svg/snippets_piramide van Lencioni.svg');

		SaveFile.out(Folder.BIN + '/_gen_scribus_${_pageSize}_${_language}.sla', scribus.toString());
	}

	// https://regexr.com/
	function test() {
		var page = '<PAGE Size="A4" PAGEXPOS="695.276590551181" PAGEWIDTH="595.275590551181" PAGEHEIGHT="841.889763779528" />';

		var newValue:String = '123';
		var str = page;
		var regex = ~/PAGEWIDTH="[\d.]+"/g;
		// public static var getVars = ~/(this.).+/g;
		var replacedString = regex.replace(str, 'PAGEWIDTH="' + newValue + '"');

		log(str);
		log(replacedString);
	}

	static public function main() {
		var app = new Main();
	}
}
