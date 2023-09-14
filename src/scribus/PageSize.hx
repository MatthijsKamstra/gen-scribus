package scribus;

class PageSize {
	public static var A1(default, null):String = 'A1';
	public static var A2(default, null):String = 'A2';
	public static var A3(default, null):String = 'A3';
	public static var A4(default, null):String = 'A4';
	public static var A5(default, null):String = 'A5';
	public static var A6(default, null):String = 'A6';

	public function new() {
		trace('PageSize');
	}

	// 1 centimeter =	28.3464567	PostScript	points
	public static var CM2POINTS(default, null):Float = 841.889763779528 / 29.7; // 28.3464567;
	public static var MM2POINTS(default, null):Float = 841.889763779528 / 297; // 28.3464567;

	// static var CM2POINTS(default, null):Float = 28.35; // 28.3464567;

	public static function setValueInPoints(pagesize:String):{width:Float, height:Float} {
		var size:{width:Float, height:Float} = getPageSizeInCm(pagesize);
		return {width: (size.width * CM2POINTS), height: (size.height * CM2POINTS)}
	}

	// Hoe groot is A0 formaat    84,1 cm x 118,9 cm    (841 mm x 1189 mm)
	// Hoe groot is A1 formaat    59,4 cm x 84,1 cm    (594 mm x 841 mm)
	// Hoe groot is A2 formaat    42 cm x 59,4 cm    (420 mm x 594 mm)
	// Hoe groot is A3 formaat    29,7 cm x 42 cm    (297 mm x 420 mm)
	// Hoe groot is A4 formaat    21 cm x 29,7 cm    (210 mm x 297 mm)
	// Hoe groot is A5 formaat    14,8 cm x 21 cm    (148 mm x 210 mm)
	// Hoe groot is A6 formaat    10,5 cm x 14,8 cm    (105 mm x 148 mm)
	// Hoe groot is A7 formaat    7,4 cm x 10,5 cm    (74 mm x 105 mm)
	// Hoe groot is A8 formaat    5,2 cm x 7,4 cm    (52 mm x 74 mm)
	// values in cm
	static function getPageSizeInCm(pagesize:String):{width:Float, height:Float} {
		var value = {width: 0.0, height: 0.0};
		switch (pagesize) {
			case 'A0':
				value = {
					width: 84.1,
					height: 118.9
				}
			case 'A1':
				trace('A1');
			case 'A2':
				trace('A2');
			case 'A3':
				value = {
					width: 29.7,
					height: 42
				}
			case 'A4':
				value = {
					width: 21,
					height: 29.7
				}
			case 'A5':
				value = {
					width: 14.8,
					height: 21
				}
			case 'A6':
				trace('A6');
			default:
				// trace("case '" + pagesize + "': trace ('" + pagesize + "');");
		}
		return value;
	}
}
