/**
 * https://www.npmjs.com/package/tar-stream
 */
package js.npm;

import js.Error;
import js.node.events.EventEmitter.Event;
import js.node.stream.Readable;
import js.node.stream.Writable;

@:enum
abstract TarPackEntryType(String) {
  var file = 'file';
  var link = 'link';
  var symlink = 'symlink';
  var directory = 'directory';
  var block_device = 'block-device';
  var character_device = 'character-device';
  var fifo = 'fifo';
  var contiguous_file  = 'contiguous-file ';
}

typedef TarPackHeader = {
	var name :String;
	@:optional var size :Int;
	@:optional var mtime :Date;
	@:optional var mode :Int;
	@:optional var type :TarPackEntryType;
	@:optional var linkname :String;
	@:optional var uid :Int;
	@:optional var gid :Int;
	@:optional var uname :String;
	@:optional var gname :String;
	@:optional var devmajor :Int;
	@:optional var devminor :Int;
}

@:enum abstract TarExtractEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var Entry : TarExtractEvent<TarPackHeader->IReadable->(Void->Void)->Void> = "entry";
	var Finish : TarExtractEvent<Void->Void> = "finish";
}

@:jsRequire('tar-stream')
extern class TarStream
{
	public static function pack() :TarPack;
	public static function extract() :IWritable;
}

extern class TarPack extends Readable<Dynamic>
{
	@:overload(function(opts :TarPackHeader, cb :Null<Error>->Void):IWritable {})
	public function entry(opts :TarPackHeader, val :String) :Void;
	public function finalize() :Void;
}