package js.npm.prettyms;

@:jsRequire("pretty-ms")
extern class PrettyMs
{
	@:selfCall
	public static function pretty(ms :Float) :String;
}
