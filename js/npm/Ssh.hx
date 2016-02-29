package js.npm;

import js.Error;

import js.node.stream.Readable;
import js.node.stream.Writable;

typedef ConnectOptions = {
	var host :String;
	@:optional var port :Int;
	var username :String;
	@:optional var privateKey :String;
	@:optional var password :String;
}

typedef WriteStreamOptions = {
	@:optional var flags :String;
	@:optional var encoding :String;
	@:optional var mode :Int;
}

typedef ReadStreamOptions = {>WriteStreamOptions,
	@:optional var autoclose :Bool;
	@:optional var start :Int;
	@:optional var end :Int;
}

typedef FileAttributes = {
	var mode :Int;
	var uid :Int;
	var gid :Int;
	var size :Int;
	var atime :Int;
	var mtime :Int;
}

typedef SshFile = {
	var filename :String;
	var longname :String;
	var attrs :FileAttributes;
}

@:jsRequire("ssh2")
extern class SshClient extends js.node.events.EventEmitter<Dynamic>
{
	public static inline var EVENT_READY = 'ready';
	public static inline var EVENT_ERROR = 'error';
	public static inline var EVENT_CONTINUE = 'continue';

	public var stderr :js.node.events.EventEmitter<Dynamic>;
	public var stdout :js.node.events.EventEmitter<Dynamic>;
	public function new() :Void;
	public function exec(command :String, cb :Null<Error>->Null<ExecStream>->Void) :Bool;
	public function shell(cb :Null<Error>->Null<ExecStream>->Void) :Void;
	public function connect(options :ConnectOptions) :Void;
	public function sftp(cb :Error->SFTPStream->Void) :Bool;
	public function end() :Void;
}

/* https://github.com/mscdex/ssh2-streams/blob/master/SFTPStream.md */
extern class SFTPStream extends js.node.events.EventEmitter<Dynamic>
{
	public function readdir(dir :String, cb :Null<Error>->Null<Array<SshFile>>->Void) :Bool;
	public function writeFile(path :String, data :IReadable, options :Dynamic, cb :Null<Error>->Null<Dynamic>->Void) :Bool;
	public function fastPut(from :String, to :String, options :Dynamic, cb :Null<Error>->Void) :Bool;
	@:overload(function(remotePath :String):IWritable {})
	public function createWriteStream(remotePath :String, ?options :WriteStreamOptions) :IWritable;
	public function createReadStream(remotePath :String, ?options :ReadStreamOptions) :IReadable;
	@:overload(function(remotePath :String, cb :Null<Error>->Void):Bool {})
	public function mkdir(remotePath :String, ?attr :FileAttributes, cb :Null<Error>->Void) :Bool;
}

extern class ExecStream extends Readable<Dynamic>
{
	public var stderr :IReadable;
}