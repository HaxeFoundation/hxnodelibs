package js.npm.md5file;

import js.Promise;

@:jsRequire("md5-file/promise")
extern class Md5FilePromise
{
	@:selfCall
	public static function md5(path :String) :Promise<String>;
}
