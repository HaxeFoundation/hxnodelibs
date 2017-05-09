package js.npm;

import js.node.stream.Duplex;

@:jsRequire("base64-stream")
extern class Base64Stream extends js.node.events.EventEmitter<Dynamic>
{
	public static function encode() :IDuplex;
	public static function decode() :IDuplex;
}
