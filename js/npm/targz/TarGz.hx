package js.npm.targz;

/**
 * https://github.com/alanhoff/node-tar.gz
 */

import js.lib.Error;
import js.node.stream.Readable;
import js.node.stream.Writable;

typedef ZLibOptions = {//https://goo.gl/R40wrD
	@:optional var level :Int;
	@:optional var memLevel :Int;
}

typedef TarOptions = {//https://goo.gl/bqklaR
	@:optional var path :String;
	@:optional var strip :Int;
	@:optional var fromBase :Bool;
}

@:jsRequire("tar.gz")
extern class TarGz extends js.node.events.EventEmitter<Dynamic>
{
	public function new(?zlibOptions :ZLibOptions, ?tarOptions :TarOptions);
	public function createReadStream(directory :String) :IReadable;
	public function createWriteStream(directory :String) :IWritable;
	public function createParseStream() :IWritable;
	public function compress(sourceDir :String, targetFilePath :String, ?cb :Null<Error>->Void) :js.lib.Promise<IReadable>;
	public function extract(sourceFilePath :String, targetDir :String,  ?cb :Null<Error>->Void) :js.lib.Promise<IReadable>;
}