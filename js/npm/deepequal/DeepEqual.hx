package js.npm.deepequal;

@:jsRequire("deep-equal")
extern class DeepEqual
{
	@:selfCall
	public static function equal(a :Dynamic, b :Dynamic) :Bool;
}

