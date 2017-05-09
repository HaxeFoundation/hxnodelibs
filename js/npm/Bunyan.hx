package js.npm;

import haxe.extern.Rest;

typedef BunyanLogger = {
	function trace(args :Rest<Dynamic>) :Void;
	function debug(args :Rest<Dynamic>) :Void;
	function info(args :Rest<Dynamic>) :Void;
	function warn(args :Rest<Dynamic>) :Void;
	function error(args :Rest<Dynamic>) :Void;
	function fatal(args :Rest<Dynamic>) :Void;
	function child(fields :Dynamic) :BunyanLogger;
	function level(?newLevel :Int) :Int;
	function levels() :Array<Int>;
}

@:jsRequire("bunyan")
extern class Bunyan extends js.node.events.EventEmitter<Dynamic>
{
	public static var TRACE :Int;
	public static var DEBUG :Int;
	public static var INFO :Int;
	public static var WARN :Int;
	public static var ERROR :Int;
	public static var FATAL :Int;

	public static function createLogger(args :Dynamic) :BunyanLogger;
}
