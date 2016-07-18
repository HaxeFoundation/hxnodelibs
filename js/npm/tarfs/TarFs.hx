package js.npm.tarfs;

/**
 * https://github.com/mafintosh/tar-fs
 */

import js.Error;
import js.node.stream.Readable;
import js.node.stream.Writable;

typedef TarFsOptions = {
	@:optional var ignore :String->Bool;
	@:optional var entries :Array<String>;
	@:optional var map :String->String;
	@:optional var mapStream :IReadable->String->IReadable;
	@:optional var dmode :Int;
	@:optional var fmode :Int;
	@:optional var strict :Bool;
	@:optional var dereference :Bool;
}

@:jsRequire('tar-fs')
extern class TarFs extends js.node.events.EventEmitter<Dynamic>
{
	inline public static var EVENT_FINISH = 'finish';

	public static function pack(directory :String, ?options :TarFsOptions) :IReadable;
	public static function extract(directory :String) :IWritable;
}