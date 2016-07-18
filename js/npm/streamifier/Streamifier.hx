package js.npm.streamifier;

import js.node.stream.Readable;

@:jsRequire('streamifier')
extern class Streamifier
{
	public static function createReadStream(obj :Dynamic, ?options :ReadableNewOptions) :IReadable;
}