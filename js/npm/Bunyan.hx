package js.npm;

typedef Logger = {
	function debug(arg1 :Dynamic, ?arg2 :Dynamic, ?arg3 :Dynamic, ?arg4 :Dynamic, ?arg5 :Dynamic) :Void;
	function info(arg1 :Dynamic, ?arg2 :Dynamic, ?arg3 :Dynamic, ?arg4 :Dynamic, ?arg5 :Dynamic) :Void;
	function warn(arg1 :Dynamic, ?arg2 :Dynamic, ?arg3 :Dynamic, ?arg4 :Dynamic, ?arg5 :Dynamic) :Void;
	function error(arg1 :Dynamic, ?arg2 :Dynamic, ?arg3 :Dynamic, ?arg4 :Dynamic, ?arg5 :Dynamic) :Void;
	function fatal(arg1 :Dynamic, ?arg2 :Dynamic, ?arg3 :Dynamic, ?arg4 :Dynamic, ?arg5 :Dynamic) :Void;
	function child(fields :Dynamic) :Logger;
}

@:jsRequire("bunyan")
extern class Bunyan extends js.node.events.EventEmitter<Dynamic>
{
	public static function createLogger(args :Dynamic) :Logger;
}
