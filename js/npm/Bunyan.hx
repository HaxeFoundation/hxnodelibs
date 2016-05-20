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
}

@:jsRequire("bunyan")
extern class Bunyan extends js.node.events.EventEmitter<Dynamic>
{
	public static function createLogger(args :Dynamic) :BunyanLogger;
}
