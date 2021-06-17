package js.npm.redisdump;

// https://www.npmjs.com/package/redis-dump
@:jsRequire("redis-dump")
extern class RedisDump
{
	@:selfCall
	public static function dump(query :Dynamic, cb :js.lib.Error->Dynamic->Void) :Void;
}
