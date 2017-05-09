package js.npm.bodyparser;

import js.node.Buffer;
import js.node.http.*;

typedef UrlencodedOptions = {
	extended : Bool,
	?inflate : Bool,
	?limit : Int,
	?parameterLimit : Int,
	?type : String,
	?verify : IncomingMessage -> ServerResponse -> Buffer -> String -> Void
}

@:jsRequire('body-parser')
extern class BodyParser
{
	public static function json(?options : {}) : BodyParser;
	public static function raw(?options : {}) : BodyParser;
	public static function text(?options : {}) : BodyParser;
	public static function urlencoded(?options : UrlencodedOptions) : BodyParser;

	public inline static function body(req : IncomingMessage) : Dynamic {
		return untyped req.body;
	}
}
