package js.npm.fetch;

import haxe.extern.EitherType;

#if (haxe_ver >= 4)
import js.lib.Promise;
#else
import js.lib.Promise;
#end

@:enum
abstract RedirectOption(String) {
  var Follow = 'follow';
  var Manual = 'manual';
  var Error = 'error';
}

typedef FetchOptions = {
	@:optional var method :String;
#if nodejs
	@:optional var body :EitherType<String, js.node.stream.Readable.IReadable>;
#else
	@:optional var body :EitherType<String, Dynamic>;
#end
	@:optional var headers :Dynamic<String>;
	@:optional var redirect :RedirectOption;
	@:optional var follow :Int;
	@:optional var timeout :Int;
	@:optional var compress :Bool;
	@:optional var size :Int;
	@:optional var agent :Dynamic;
}

#if nodejs
	@:jsRequire("node-fetch")
#else
	@:jsRequire("whatwg-fetch")
#end
extern class Fetch
{
	@:selfCall
	public static function fetch(url :String, ?options :FetchOptions) :Promise<FetchResponse>;
}

extern class FetchResponse
{
	var type(default,null) : String;
	var url(default,null) : String;
	var redirected(default,null) : Bool;
	var status(default,null) : Int;
	var ok(default,null) : Bool;
	var statusText(default,null) : String;

	public function json() :Promise<Dynamic>;
	public function text() :Promise<String>;
#if nodejs
	public function buffer() :Promise<js.node.Buffer>;
	public var body :js.node.stream.Readable.IReadable;
#else
	public var bodyUsed :Bool;
	public function blob() :Promise<js.html.Blob>;
	public function arrayBuffer() :Promise<js.html.ArrayBuffer>;
	public function formData() :Promise<js.html.FormData>;
#end
}