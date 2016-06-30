package js.npm;

@:jsRequire("source-map-support")
extern class SourceMapSupport
{
	public static function install(?opts :Dynamic) :Void;

	private static function __init__() : Void untyped
	{
		var SourceMapSupport = Node.require('source-map-support');
		//https://github.com/evanw/node-source-map-support/issues/40
		SourceMapSupport.install({handleUncaughtExceptions: false});
		//http://stackoverflow.com/questions/33778714/haxe-nodejs-debugging-source-mapping
		haxe.CallStack.wrapCallSite = untyped __js__("require('source-map-support').wrapCallSite");
	}
}