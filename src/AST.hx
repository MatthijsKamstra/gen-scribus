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
	var author:String;
	var language:String;
	var pageName:String;
	var width:Width;
	var height:Height;
	var margins:Array<Margins>;
	var guides:Array<Guides>;
	var bleeds:Array<Bleeds>;
	var guideSnap:Bool;
	var guideLocked:Bool;
};

typedef Width = {
	var unit:String;
	var value:Int;
};

typedef Height = {
	var unit:String;
	var value:Int;
};

typedef Margins = {
	var dir:String;
	var unit:String;
	var value:Int;
};

typedef Guides = {
	var dir:String;
	var unit:String;
	var value:Int;
};

typedef Bleeds = {
	var dir:String;
	var unit:String;
	var value:Int;
};

typedef Pages = {
	var left:Left;
	var right:Right;
};

typedef Left = {
	var _alias:String;
	var texts:Array<Texts>;
};

typedef Texts = {
	var path:String;
	var x:X;
	var y:Y;
	var width:Width;
	var height:Height;
};

typedef X = {
	var unit:String;
	var value:Int;
};

typedef Y = {
	var unit:String;
	var value:Int;
};

typedef Right = {
	var _alias:String;
	var images:Array<Images>;
};

typedef Images = {
	var path:String;
	var x:X;
	var y:Y;
	var width:Width;
	var height:Height;
};
