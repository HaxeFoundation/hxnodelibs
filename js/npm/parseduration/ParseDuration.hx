package js.npm.parseduration;

import haxe.extern.EitherType;

// https://www.npmjs.com/package/parse-duration
@:jsRequire("parse-duration")
extern class ParseDuration
{
	@:selfCall
	static function parse(t :String) :EitherType<Float,Int>;
}
