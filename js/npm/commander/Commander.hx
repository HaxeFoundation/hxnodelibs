package js.npm.commander;

import haxe.extern.Rest;

@:jsRequire("commander")
extern class Commander
{
	public var args :Array<String>;
	public var rawArgs :Array<String>;
	public var commands :Array<Command>;

	public function version (s :String) :Commander;
	public function command (s :String, ?description :String, r:Rest<Dynamic>) :Command;
	public function option(optionString :String, description :String, r:Rest<Dynamic>) :Commander;
	public function parse (args :Array<String>) :Void;
	public function help(?f :Void->Void) :Void;
	public function outputHelp() :Void;
}

extern class Command
{
	public var _name :String;
	public var parent :Commander;
	public function description(s :String) :Command;

	@:overload(function (flags :String, description :String, coercion :Dynamic, ?defaultValue :Dynamic) :Command {})
	@:overload(function (flags :String, description :String) :Command {})
	public function option(flags :String) :Command;

	public function alias(s :String) :Command;

	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Dynamic->Void) :Command {})
	@:overload(function(f :Dynamic->Dynamic->Void) :Command {})
	public function action(f :Dynamic->Void) :Command;

	public function on(arg :String, f :Void->Void) :Command;

	public function addImplicitHelpCommand() :Void;
	public function optionHelp() :String;
	public function helpInformation() :String;
}