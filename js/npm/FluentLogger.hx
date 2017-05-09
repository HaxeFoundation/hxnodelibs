package js.npm;

/**
 * https://github.com/fluent/fluent-logger-node
 */

import js.Node;
import js.Error;
import js.support.Either;

typedef FluentConfigureOpts = {
	@:optional var host :String;
	@:optional var port :Int;
	@:optional var timeout :Float;
	@:optional var reconnectInterval :Float;
	@:optional var path :String;
}

@:jsRequire("fluent-logger")
extern class FluentLogger //extends js.node.events.EventEmitter<Dynamic>
{
	public static function createFluentSender(tag :String, opts :FluentConfigureOpts) :FluentLogger;
	public function emit(label :String, record :Dynamic, ?time :Either<Date, Float>, ?cb :Void->Void) :Void;
}
