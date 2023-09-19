import const.Config;
import scribus.Locale;
import scribus.PageSize;
import scribus.ScData;
import scribus.ScPage;
import scribus.ScSettings;
import scribus.Scribus;
import sys.FileSystem;
import utils.SaveFile;

class Main {
	public function new(?args:Array<String>) {
		info('Start project: "${Project.NAME}"');

		init();
		initArgs(args);
		setup();

		// create Scibus document, with adjustments
		// createScribus();
		// createScribusA4NL();
		// createScribusA5EN();

		// // snippets of knownledge
		// createScribusCustomNL();

		// // use settings
		// useSettings('scribus_148x148mm.json');

		info('Scribus data');
		info('-------------------------------------------');
		info('Total pages: ' + ScData.TOTAL_PAGES, 1);
		info('Total images: ' + ScData.TOTAL_IMAGES, 1);
		info('Total text: ' + ScData.TOTAL_TEXT, 1);
		info('Total errors: ' + ScData.TOTAL_ERRORS, 1);
		info('-------------------------------------------');
	}

	function init() {
		// info('init');

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

	function initArgs(?args:Array<String>) {
		var args:Array<String> = args;
		info('SETTINGS');

		if (args == null) {
			args = [];
			args.push('-h');
		}
		if (args == null || args.length == 0) {
			args.push('-h');
		}

		for (i in 0...args.length) {
			var temp = args[i];
			switch (temp) {
				case '-v', '--version':
					Sys.println('Version: ' + Config.VERSION);
				// case '-cd', '--folder': // isFolderSet = true;
				// case '-f', '--force':
				// 	mute('Config.IS_OVERWRITE = true', 1);
				// 	Config.IS_OVERWRITE = true;
				// case '-d', '--dryrun':
				// 	mute('Config.IS_DRYRUN = true', 1);
				// 	Config.IS_DRYRUN = true;
				// case '-b', '--basic':
				// 	mute('Config.IS_BASIC = true', 1);
				// 	Config.IS_BASIC = true;
				case '--openFile', '--open':
					mute('Config.OPEN_FILE = true', 1);
					Config.OPEN_FILE = true;
				case '--debug':
					mute('Config.IS_DEBUG = true', 1);
					Config.IS_DEBUG = true;
				case '--help', '-h':
					// mute('HELP', 1);
					showHelp();
				// case '--out', '-o':
				// 	// log(args[i + 1]);
				// 	var str = '# README\n\n**Generated on:** ${Date.now()}\n**Target:**';
				// 	SaveFile.writeFile(Sys.getCwd(), 'TESTME.MD', str);
				case '--in', '-i':
					mute('Config.PATH: "${args[i + 1]}"', 1);
					Config.PATH = args[i + 1];
					mute('is path absolute: ' + Path.isAbsolute(Config.PATH));
					if (Path.isAbsolute(Config.PATH)) {
						Folder.ROOT_FOLDER = Path.normalize('${Config.PATH}/../');
						Folder.EXPORT = Path.normalize('${Config.PATH}/../export');
					} else {
						Folder.EXPORT = Folder.ROOT_FOLDER + 'export';
					}
					mute(Folder.EXPORT);

				default:
					// trace("case '" + temp + "': trace ('" + temp + "');");
			}
		}
	}

	function setup() {
		//
		info('SETUP');
		mute(Folder.EXPORT, 1);

		log('Export folder exists: ' + FileSystem.exists(Folder.EXPORT));
		if (!FileSystem.exists(Folder.EXPORT)) {
			FileSystem.createDirectory(Folder.EXPORT);
			mute('folder created');
		}

		// Sys.println("Enter your name:");
		// var ans = Sys.stdin().readLine();
		// // `ans` is just the text --- no newline

		// trace('text');

		// var content = Sys.stdin().readAll().toString();

		if (Config.PATH != '') {
			useSettings(Config.PATH);
		}
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

	/**
	 * test custom loggin
	 */
	function initLog() {
		Sys.println('this is the default sys.println');
		// logging via Haxe
		log("this is a log message");
		warn("this is a warn message");
		info("this is a info message");
		progress("this is a progress message");
	}

	function showHelp():Void {
		Sys.println('
----------------------------------------------------
${Project.NAME} (${Config.VERSION})

  --version / -v	: version number
  --help / -h		: show this help
  --in / -i		: path to project folder
  --debug		: write test with some extra debug information
----------------------------------------------------
');

	}

	static public function main() {
		var app = new Main(Sys.args());
	}
}
