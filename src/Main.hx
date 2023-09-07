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
		createScribus();
		createScribusA4NL();
		createScribusA5EN();
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

	function createScribus() {
		var pagesize = PageSize.A3;
		var language = Locale.EN_US;

		var scribus = new Scribus();

		scribus.setPageSize(pagesize);
		scribus.setLanguage(language);

		scribus.addColorRGB('test_mck_rgb', 0, 10, 20);
		scribus.addColorCMYK('test_mck_cmyk', 0, 10, 20, 30);

		SaveFile.out(Folder.BIN + '/_gen_scribus_${pagesize}_${language}_combo.sla', scribus.xml());
	}

	function createScribusA4NL() {
		var pagesize = PageSize.A4;
		var language = Locale.NL;
		var scribus = new Scribus();

		scribus.setPageSize(pagesize);
		scribus.setLanguage(language);

		SaveFile.out(Folder.BIN + '/_gen_scribus_${pagesize}_${language}.sla', scribus.xml());
	}

	function createScribusA5EN() {
		var pagesize = PageSize.A5;
		var language = Locale.EN_GB;
		var scribus = new Scribus();

		scribus.setPageSize(pagesize);
		scribus.setLanguage(language);

		SaveFile.out(Folder.BIN + '/_gen_scribus_${pagesize}_${language}.sla', scribus.xml());
	}

	static public function main() {
		var app = new Main();
	}
}
