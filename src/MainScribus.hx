import const.Config;
import haxe.Json;
import scribus.Locale;
import scribus.PageSize;
import scribus.ScData;
import scribus.ScPage;
import scribus.ScSettings;
import scribus.Scribus;
import sys.FileSystem;
import utils.SaveFile;

class Main {
	var json:AST.HxSettingsObj;

	public function new(?args:Array<String>) {
		info('Start project: "${Project.NAME}"');

		init();

		// create Scibus document, with adjustments
		createScribus();
		createScribusA4NL();
		createScribusA5EN();

		// snippets of knownledge
		createScribusCustomNL();

		// use settings
		useSettings('scribus_148x148mm.json');
	}

	function init() {
		// info('init');
		ScData.reset();

		Config.ROOT = Sys.getCwd();
		Folder.ROOT_FOLDER = Sys.getCwd();
		Folder.DOCS = Path.join([Sys.getCwd(), 'docs']);
		Folder.BIN = Path.join([Sys.getCwd(), 'bin']);
		Folder.EXPORT = Path.join([Sys.getCwd(), 'export']);

		mute('local docs folder exists: ' + FileSystem.exists(Folder.DOCS));
		mute('local bin folder exists: ' + FileSystem.exists(Folder.BIN));
		mute('local export folder exists: ' + FileSystem.exists(Folder.EXPORT));

		// if (!FileSystem.exists(Folder.EXPORT)) {
		// 	FileSystem.createDirectory(Folder.EXPORT);
		// }

		info('Folder.ROOT_FOLDER: ${Folder.ROOT_FOLDER}');
		info('Folder.DOCS: ${Folder.DOCS}');
		info('Folder.BIN: ${Folder.BIN}');
	}

	function useSettings(path:String) {
		var settings = new ScSettings(path);
	}

	function createScribus() {
		var pagesize = PageSize.A3;
		var language = Locale.EN_US;

		var scribus = new Scribus();

		scribus.setPageName(pagesize);
		scribus.setLanguage(language);

		scribus.addColorRGB('test_mck_rgb', 0, 10, 20);
		scribus.addColorCMYK('test_mck_cmyk', 0, 10, 20, 30);

		SaveFile.out(Folder.BIN + '/_gen_scribus_${pagesize}_${language}_combo.sla', scribus.toString());
	}

	function createScribusA4NL() {
		var pagesize = PageSize.A4;
		var language = Locale.NL;
		var scribus = new Scribus();

		scribus.setPageName(pagesize);
		scribus.setLanguage(language);

		SaveFile.out(Folder.BIN + '/_gen_scribus_${pagesize}_${language}.sla', scribus.toString());
	}

	function createScribusA5EN() {
		var pagesize = PageSize.A5;
		var language = Locale.EN_GB;
		var scribus = new Scribus();

		scribus.setPageName(pagesize);
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
		scribus.setPageName(_pageSize);
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

		SaveFile.out(Folder.BIN + '/_gen_scribus_${_pageSize.replace(' ', '_')}_${_language}.sla', scribus.toString());

		// Sys.command('open ./bin/_gen_scribus_Custom_148x148mm_nl.sla');
	}

	static public function main() {
		var app = new Main(Sys.args());
	}
}
