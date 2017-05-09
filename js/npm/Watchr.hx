package js.npm;

//https://github.com/bevry/watchr

import js.Error;

typedef WatchErr=Dynamic;

typedef FilePath=String;
typedef FileCurrentStat=Dynamic;
typedef FilePreviousStat=FileCurrentStat;

@:enum
abstract ChangeType(String) {
	var Update = 'update';
	var Create = 'create';
	var Delete = 'delete';
}

typedef WatcherInstance = {
	var path :String;
}

typedef Watcher = {
	function close () :Void;
}

typedef Listeners = {
	@:optional var log :Int->Void;
	@:optional var error :WatchErr->Void;
	@:optional var watching :WatchErr->WatcherInstance->Bool->Void;
	@:optional var change :ChangeType->FilePath->FileCurrentStat->FilePreviousStat->Void;
}

typedef WatchrConfig = {
	@:optional var path :String;
	@:optional var paths :Array<String>;
	@:optional var listener :Void->Void;
	@:optional var listeners :Listeners;
	@:optional var next :WatchErr->Array<Watcher>->Void;
	@:optional var stat :Dynamic;
	@:optional var interval :Int;
	@:optional var persistent :Bool;
	@:optional var catchupDelay :Int;
	@:optional var preferredMethods :Array<String>;
	@:optional var followLinks :Bool;
	@:optional var ignorePaths :Bool;
	@:optional var ignoreHiddenFiles :Bool;
	@:optional var ignoreCustomPatterns :Bool;
}

@:jsRequire("watchr")
extern class Watchr extends js.node.events.EventEmitter<Dynamic>
{
	public static function watch(config :WatchrConfig):Void;
}

class WatchrEvents
{
	inline public static var LOG = 'log';
	inline public static var ERROR = 'error';
	inline public static var WATCHING = 'watching';
	inline public static var CHANGE = 'change';
}