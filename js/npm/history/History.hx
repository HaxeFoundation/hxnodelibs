package js.npm.history;


@:enum
abstract HistoryAction(String) {
  var PUSH = 'PUSH';
  var REPLACE = 'REPLACE';
  var POP = 'POP';
}

typedef HistoryLocation = {
	var path :String;
	var search :String;
	var hash :String;
	@:optional var state :Dynamic;
	@:optional var key :String;
};
typedef Unlistener=Void->Void;

typedef BrowserHistoryOpts = {
	var basename :HistoryLocation;
	@:optional var forceRefresh :Bool;
	@:optional var keyLength :Int;
}

typedef MemoryHistoryOpts = Dynamic;
typedef HashHistoryOpts = Dynamic;

@:jsRequire('history')
extern class History
{
	public static function createBrowserHistory(?opts :BrowserHistoryOpts) :HistoryObject;
	public static function createMemoryHistory(?opts :MemoryHistoryOpts) :HistoryObject;
	public static function createHashHistory(?opts :HashHistoryOpts) :HistoryObject;
}

extern class HistoryObject
{
	public var location :HistoryLocation;
	public var length :Int;
	public var action :Int;

	public function listen(cb :HistoryLocation->HistoryAction->Void) :Unlistener;

	public function push(location :String, state :Dynamic) :Void;
	public function replace(location :String, state :Dynamic) :Void;
	public function go(count :Int) :Void;
	public function goBack() :Void;
	public function goForward() :Void;
	public function canGo(count :Int) :Bool;

	public function block(message :String) :Void->Void;
}
