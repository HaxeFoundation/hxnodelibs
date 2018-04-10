package js.npm.md5file;

import js.Error;

@:jsRequire("md5-file")
extern class Md5File
{
	@:selfCall
	public static function md5(path :String, cb :Null<Error>->String->Void) :Void;
}
