package js.npm.fluentlogger;

/**
 * https://www.npmjs.com/package/fluent-logger
 */

import js.Node;
import js.lib.Error;
import haxe.extern.EitherType;

typedef FluentConfigureOpts = {
	@:optional var host :String;
	@:optional var port :Int;
	@:optional var timeout :Float;
	@:optional var reconnectInterval :Float;
	@:optional var path :String;
}

@:jsRequire("fluent-logger")
extern class FluentLogger
{
	public static function createFluentSender(tag :String, opts :FluentConfigureOpts) :FluentLogger;

	@:overload(function(record :Dynamic, ?time :EitherType<Date, Float>, ?cb :Void->Void) :Void {})
	public function emit(label :String, record :Dynamic, ?time :EitherType<Date, Float>, ?cb :Void->Void) :Void;
}
