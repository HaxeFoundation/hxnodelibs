package js.npm.ssh2;

import js.lib.Error;
import js.node.events.EventEmitter.Event;
import js.node.stream.Readable;
import js.node.stream.Writable;
import js.node.stream.Duplex;

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

typedef SshSession=Dynamic;

@:enum abstract SshConnectionEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> 
{
	var Authentication : SshConnectionEvent<Dynamic->Void> = 'authentication';
	var Ready : SshConnectionEvent<Void->Void> = 'ready';
	var Session : SshConnectionEvent<(Void->SshSession)->Void->Bool> = 'session';
	var Continue : SshConnectionEvent<Void->Void> = 'continue';
	var Error : SshConnectionEvent<Error->Void> = 'error';
	var End : SshConnectionEvent<Void->Void> = 'end';
	var Close : SshConnectionEvent<Bool->Void> = 'close';
}

@:enum abstract SshClientEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> 
{
	var Banner : SshClientEvent<String->String->Void> = 'banner';
	var Ready : SshClientEvent<Void->Void> = 'ready';
	var TcpConnection : SshClientEvent<Dynamic->Dynamic->Dynamic->Void> = 'tcp connection';
	var X11 : SshClientEvent<Dynamic->Dynamic->Dynamic->Void> = 'x11';
	var Continue : SshClientEvent<Void->Void> = 'continue';
	var Error : SshClientEvent<Error->Void> = 'error';
	var End : SshClientEvent<Void->Void> = 'end';
	var Close : SshClientEvent<Void->Void> = 'close';
}

@:enum abstract SshExecEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> 
{
	var Ready : SshExecEvent<Void->Void> = 'ready';
}

@:enum abstract SshChannelEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> 
{
	var Close : SshChannelEvent<Int->String->Void> = 'close';
}

@:jsRequire("ssh2")
extern class SshClient extends js.node.events.EventEmitter<Dynamic>
{
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

extern class ExecStream extends Duplex<Dynamic>
{
	public var stderr :IReadable;
}