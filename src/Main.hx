package;

import const.Config;
import haxe.Json;
import inkscape.InkscapeSettings;
import scribus.ScData;
import sys.FileSystem;
import utils.SaveFile;

class Main {
	var json:AST.HxSettingsObj;

	public function new(?args:Array<String>) {
		info('Start project: "${Project.NAME}"');

		init();
		initArgs(args);
		setup();
		infoGen();
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
			var content = sys.io.File.getContent(Config.PATH);
			json = Json.parse(content);
		}
	}

	function useSettings(path:String) {
		// var scribusSettings = new ScSettings(path);
		var inkscapeSettings = new InkscapeSettings(path);
	}

	function infoGen() {
		var numberPages = [8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64];
		var maxValue = 0;
		var minValue = 0;
		for (i in 0...numberPages.length) {
			var _numberPages = numberPages[i];
			if (_numberPages >= ScData.TOTAL_PAGES) {
				maxValue = i;
				minValue = i - 1;
				if (minValue <= 0)
					minValue = 0;
				break;
			}
		}
		if (Config.IS_DEBUG) {
			info('------------------- Scribus data ------------------------');
			info('Document:', 1);
			info('width: ${json.document.width.value}${json.document.width.unit}', 2);
			info('height: ${json.document.height.value}${json.document.height.unit}', 2);
			info('author: ${json.document.author}', 2);
			info('title: ${json.document.title}', 2);
			info('description: ${json.document.description}', 2);
			info('language: ${json.document.language}', 2);
			info('pageName: ${json.document.pageName}', 2);
			info('guideSnap: ${json.document.guideSnap}', 2);
			info('guideLocked: ${json.document.guideLocked}', 2);

			info('Margins:', 1);
			info('margins-${json.document.margins[0].dir}: ${json.document.margins[0].value}${json.document.margins[0].unit}', 2);
			info('margins-${json.document.margins[1].dir}: ${json.document.margins[1].value}${json.document.margins[1].unit}', 2);
			info('margins-${json.document.margins[2].dir}: ${json.document.margins[2].value}${json.document.margins[2].unit}', 2);
			info('margins-${json.document.margins[3].dir}: ${json.document.margins[3].value}${json.document.margins[3].unit}', 2);

			info('Guides:', 1);
			info('guides-${json.document.guides[0].dir}: ${json.document.guides[0].value}${json.document.guides[0].unit}', 2);
			info('guides-${json.document.guides[1].dir}: ${json.document.guides[1].value}${json.document.guides[1].unit}', 2);
			info('guides-${json.document.guides[2].dir}: ${json.document.guides[2].value}${json.document.guides[2].unit}', 2);
			info('guides-${json.document.guides[3].dir}: ${json.document.guides[3].value}${json.document.guides[3].unit}', 2);

			info('Bleeds:', 1);
			info('bleeds-${json.document.bleeds[0].dir}: ${json.document.bleeds[0].value}${json.document.bleeds[0].unit}', 2);
			info('bleeds-${json.document.bleeds[1].dir}: ${json.document.bleeds[1].value}${json.document.bleeds[1].unit}', 2);
			info('bleeds-${json.document.bleeds[2].dir}: ${json.document.bleeds[2].value}${json.document.bleeds[2].unit}', 2);
			info('bleeds-${json.document.bleeds[3].dir}: ${json.document.bleeds[3].value}${json.document.bleeds[3].unit}', 2);

			info('Total pages: ' + ScData.TOTAL_PAGES + ' (${numberPages[minValue]}-${numberPages[maxValue]})', 1);
			info('Total images: ' + ScData.TOTAL_IMAGES, 1);
			info('Total text: ' + ScData.TOTAL_TEXT, 1);
			info('Total errors: ' + ScData.TOTAL_ERRORS, 1);
			for (i in 0...ScData.errorArray.length) {
				var _errorArray = ScData.errorArray[i];
				info(' - ' + _errorArray, 2);
			}
			info('----------------------------------------------------------');
		}

		var md = '# Scribus data\n\n';

		md += '- Document:\n';
		md += '\t- width: ${json.document.width.value}${json.document.width.unit}\n';
		md += '\t- height: ${json.document.height.value}${json.document.height.unit}\n';
		md += '\t- author: ${json.document.author}\n';
		md += '\t- title: ${json.document.title}\n';
		md += '\t- description: ${json.document.description}\n';
		md += '\t- language: ${json.document.language}\n';
		md += '\t- pageName: ${json.document.pageName}\n';
		md += '\t- guideSnap: ${json.document.guideSnap}\n';
		md += '\t- guideLocked: ${json.document.guideLocked}\n';

		md += '- Margins:\n';
		md += '\t- margins-${json.document.margins[0].dir}: ${json.document.margins[0].value}${json.document.margins[0].unit}\n';
		md += '\t- margins-${json.document.margins[1].dir}: ${json.document.margins[1].value}${json.document.margins[1].unit}\n';
		md += '\t- margins-${json.document.margins[2].dir}: ${json.document.margins[2].value}${json.document.margins[2].unit}\n';
		md += '\t- margins-${json.document.margins[3].dir}: ${json.document.margins[3].value}${json.document.margins[3].unit}\n';

		md += '- Guides:\n';
		md += '\t- guides-${json.document.guides[0].dir}: ${json.document.guides[0].value}${json.document.guides[0].unit}\n';
		md += '\t- guides-${json.document.guides[1].dir}: ${json.document.guides[1].value}${json.document.guides[1].unit}\n';
		md += '\t- guides-${json.document.guides[2].dir}: ${json.document.guides[2].value}${json.document.guides[2].unit}\n';
		md += '\t- guides-${json.document.guides[3].dir}: ${json.document.guides[3].value}${json.document.guides[3].unit}\n';

		md += '- Bleeds:\n';
		md += '\t- bleeds-${json.document.bleeds[0].dir}: ${json.document.bleeds[0].value}${json.document.bleeds[0].unit}\n';
		md += '\t- bleeds-${json.document.bleeds[1].dir}: ${json.document.bleeds[1].value}${json.document.bleeds[1].unit}\n';
		md += '\t- bleeds-${json.document.bleeds[2].dir}: ${json.document.bleeds[2].value}${json.document.bleeds[2].unit}\n';
		md += '\t- bleeds-${json.document.bleeds[3].dir}: ${json.document.bleeds[3].value}${json.document.bleeds[3].unit}\n';

		md += '- Total pages: ' + ScData.TOTAL_PAGES + ' (${numberPages[minValue]}-${numberPages[maxValue]})' + '\n';
		md += '- Total images: ' + ScData.TOTAL_IMAGES + '\n';
		md += '- Total text: ' + ScData.TOTAL_TEXT + '\n';
		md += '- Total errors: ' + ScData.TOTAL_ERRORS + '\n';
		for (i in 0...ScData.errorArray.length) {
			var _errorArray = ScData.errorArray[i];
			md += '\t- ' + _errorArray + '\n';
		}
		var arr = Config.PATH.split('/');
		var fileName = arr[arr.length - 1].replace('.json', '.md');
		var _p = Path.normalize(Config.PATH).replace('.json', '.md');

		// warn('Config.PATH: ' + Config.PATH);
		// warn('Config.ROOT: ' + Config.ROOT);
		// warn('filename: ' + fileName);
		// warn('path: ' + _p);

		SaveFile.out(_p, md);
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
