package js.npm.filenamify;

/**
 * https://www.npmjs.com/package/filenamify
 */

@:jsRequire("filenamify")
extern class Filenamify
{
	@:selfCall
	public static function filenamify(s :String, ?opts :{replacement:String}) :String;
}
