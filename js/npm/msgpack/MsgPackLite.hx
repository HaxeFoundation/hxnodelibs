package js.npm.msgpack;

#if nodejs
	import js.node.Buffer;
	import js.node.stream.Transform;
#end

@:jsRequire("msgpack-lite")
extern class MsgPackLite
{
#if nodejs
	public static function encode(o :Dynamic) :Buffer;
	public static function decode<T>(b :Buffer) :T;
	public static function createEncodeStream() :js.node.stream.Transform<Dynamic>;
#else
	public static function encode(o :Dynamic) :Dynamic;
	public static function decode<T>(b :Dynamic) :T;
#end
}