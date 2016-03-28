package js.npm;

import haxe.extern.Rest;

@:jsRequire("commander")
extern class Commander
{
	public var args :Array<String>;

	public function version (s :String) :Commander;
	public function command (s :String, ?description :String, ?options :Dynamic) :Command;
	public function option(short :String, ?long :String, ?description :String) :Commander;
	public function parse (args :Array<String>) :Void;
	public function help(?f :Void->Void) :Void;
	public function outputHelp() :Void;
}

extern class Command
{
	public function description(s :String) :Command;

	@:overload(function (flags :String, description :String, coercion :Dynamic->Dynamic->Dynamic, defaultValue :Dynamic) :Command {})
	@:overload(function (flags :String, description :String, coercion :Dynamic->Dynamic) :Command {})
	@:overload(function (flags :String, description :String) :Command {})
	public function option(flags :String) :Command;

	public function alias(s :String) :Command;

	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Void) :Command {})
	public function action(f :Dynamic->Void) :Command;

	public function on(arg :String, f :Void->Void) :Command;
}