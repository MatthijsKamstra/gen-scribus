package;

/**
 * Generated with HxJsonDef (version 0.0.8) on Mon Sep 11 2023 23:59:45 GMT+0200 (Central European Summer Time)
 * from : http://matthijskamstra.github.io/hxjsondef/
 *
 * AST = Abstract Syntax Tree
 *
 * Note:
 * If you provide a .json there should be no null values
 * comments in this document show you the values that need to be changed!
 *
 * Some (backend)-developers choose to hide empty/null values, you can add them:
 * 		@:optional var _id : Int;
 *
 * Name(s) that you possibly need to change:
 * 		FoobarObj
 * 		Document
 * 		Width
 * 		Height
 * 		Margins
 * 		Guides
 * 		Bleeds
 * 		Pages
 * 		Left
 * 		Texts
 * 		X
 * 		Y
 * 		Right
 * 		Images
 */
typedef HxSettingsObj = {
	var document:Document;
	var pages:Array<Pages>;
};

typedef Document = {
	@:optional var author:String;
	@:optional var title:String;
	@:optional var description:String;
	var language:String;
	var pageName:String;
	var width:ValueObj;
	var height:ValueObj;
	var margins:Array<DirValueObj>;
	var guides:Array<DirValueObj>;
	var bleeds:Array<DirValueObj>;
	var guideSnap:Bool;
	var guideLocked:Bool;
};

typedef ValueObj = {
	var unit:String;
	var value:Int;
};

typedef DirValueObj = {
	var dir:String;
	var unit:String;
	var value:Int;
};

typedef Pages = {
	var left:PageObj;
	var right:PageObj;
};

typedef PageObj = {
	var _alias:String;
	var texts:Array<Texts>;
	var images:Array<Image>;
};

typedef Image = {
	var path:String;
	var x:X;
	var y:Y;
	var width:ValueObj;
	var height:ValueObj;
};

typedef Texts = {
	var path:String;
	@:optional var x:X;
	@:optional var y:Y;
	@:optional var width:ValueObj;
	@:optional var height:ValueObj;
	@:optional var style:String;
};

typedef X = {
	var unit:String;
	var value:Int;
};

typedef Y = {
	var unit:String;
	var value:Int;
};
