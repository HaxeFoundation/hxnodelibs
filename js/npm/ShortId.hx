package js.npm;

@:jsRequire("shortid")
extern class ShortId
{
	public static function generate() :String;
}