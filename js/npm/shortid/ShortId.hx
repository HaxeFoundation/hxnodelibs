package js.npm.shortid;

@:jsRequire("shortid")
extern class ShortId
{
	public static function characters(chars: String): Void;
	public static function generate() :String;
	public static function isValid(id: String): Bool;
	public static function seed(value: Int): Void;
	public static function worker(id: Int): Void;
}