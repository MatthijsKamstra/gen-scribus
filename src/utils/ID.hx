package utils;

class ID {
	static var itemId:Int = Std.random(700000000) + 700000000;

	public static function getItemId():Int {
		itemId++;
		return itemId;
	}
}
