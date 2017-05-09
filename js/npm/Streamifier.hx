package js.npm;

import js.node.stream.Readable;

@:jsRequire('streamifier')
extern class Streamifier
{
	public static function createReadStream(obj :Dynamic, ?options :ReadableNewOptions) :IReadable;
}