package js.npm;

@:jsRequire("redis-mock")
extern class RedisClientMock
{
  public static function createClient():js.npm.RedisClient;
}