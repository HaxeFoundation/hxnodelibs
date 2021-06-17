package js.npm.pageres;

import js.lib.Promise;
import js.node.stream.Readable;

typedef PageresOpts = {
	?delay :Float,
	?timeout :Float,
	?crop :Bool,
	?filename :String,
	?script :String
}

@:jsRequire('pageres')
extern class Pageres extends js.node.events.EventEmitter<Dynamic>
{
	public function new(?opts :PageresOpts) :Void;

	public function run() :Promise<Array<IReadable>>;
	public function dest(d :String) :Pageres;
	public function src(url :String, ?sizes :Array<String>, ?opts :PageresOpts) :Pageres;
}