package js.npm.redis;

import js.Node;
import js.node.events.EventEmitter;
import js.Error;

typedef Channel = String;
typedef ChannelCount = Int;
typedef IntegerReply = Error->Int->Void;
typedef BooleanReply = Error->Bool->Void;
typedef StatusReply = Error->String->Void;
typedef SubscribeReply = Channel->ChannelCount->Void;
typedef MessageReply = Channel->String->Void;
typedef BulkReply = Error->Dynamic->Void;
typedef MultiReply = Error->Array<Dynamic>->Void;
typedef MultiCommand = Array<Dynamic>;

typedef Multi = {
  function exec(cb :MultiReply) :Void;
}

@:enum abstract RedisEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
  var Ready : RedisEvent<Void->Void> = "ready";
  var Connect : RedisEvent<Void->Void> = "connect";
  var Reconnecting : RedisEvent<{delay:Int,attempt:Int}->Void> = "reconnecting";
  var Error : RedisEvent<Error->Void> = "error";
  var End : RedisEvent<Void->Void> = "end";
  var Drain : RedisEvent<Bool->Void> = "drain";
  var Warning : RedisEvent<String->Void> = "warning";
  var Idle : RedisEvent<Bool->Void> = "idle";
  var Message : RedisEvent<MessageReply> = "message";
  var PMessage : RedisEvent<MessageReply> = "pmessage";
  var Subscribe : RedisEvent<SubscribeReply> = "subscribe";
  var PSubscribe : RedisEvent<SubscribeReply> = "psubscribe";
  var Unsubscribe : RedisEvent<SubscribeReply> = "unsubscribe";
  var PUnsubscribe : RedisEvent<SubscribeReply> = "punsubscribe";
}

@:jsRequire('redis')
extern class RedisClient extends js.node.events.EventEmitter<Dynamic>
{
  public static function createClient(?port :Int, ?address :String, ?options :Dynamic):RedisClient;
  public static function print(?arg1 :Dynamic, ?arg2 :Dynamic, ?arg3 :Dynamic, ?arg4 :Dynamic):Void;

  public var connection_options :{host:String, port:Int};

  /** Forcibly close the connection to the Redis server. Note that this does not wait until all replies have been parsed. */
  public function end(flush :Bool):Void;
  /** Exit cleanly. */
  public function quit():Void;
  public function info(cb:BulkReply):Void;
  public function save(cb:StatusReply):Void;
  public function bgsave(cb:StatusReply):Void;
  public function lastsave(cb:IntegerReply):Void;
  public function unref():Void;

  // all
  public function exists(k:String,cb:IntegerReply):Void;
  public function del(k:String,cb:IntegerReply):Void;
  public function type(k:String,cb:StatusReply):Void;
  public function keys(pattern:String,cb:MultiReply):Void;
  public function randomkey(k:String,cb:StatusReply):Void;
  public function rename(k:String,nk:String,cb:StatusReply):Void;
  public function renamenx(k:String,nk:String,cb:StatusReply):Void;
  public function dbsize(cb:IntegerReply):Void;
  public function expire(k:String,secs:Int,cb:IntegerReply):Void;
  public function ttl(k:String,cb:IntegerReply):Void;
  public function select(index:Int,cb:StatusReply):Void;
  public function move(k:String,index:Int,cb:IntegerReply):Void;
  public function flushdb(cb:StatusReply):Void;
  public function flushall(cb:StatusReply):Void;

  // strings
  public function set(k:String,v:String,cb:BooleanReply):Void;
  public function get(k:String,cb:StatusReply):Void;
  public function incr(k:String,cb:IntegerReply):Void;
  public function incrby(k:String,by:Int,cb:IntegerReply):Void;
  public function decr(k:String,cb:IntegerReply):Void;
  public function decrby(k:String,by:Int,cb:IntegerReply):Void;
  public function setnx(k:String,v:String,cb:BooleanReply):Void;
  public function mset(ks:Array<Dynamic>,cb:BooleanReply):Void;
  public function msetnx(ks:Array<Dynamic>,cb:BooleanReply):Void;
  public function mget(ks:Array<String>,cb:Error->Array<String>->Void):Void;
  public function getset(k:String,v:String,cb:StatusReply):Void;
  public function append(k:String,v:String,cb:IntegerReply):Void;
  public function substr(k:String,s:Int,e:Int,cb:StatusReply):Void;
  public function setex(k:String,t:Int,v:Dynamic,cb:StatusReply):Void;

  // lists
  @:overload(function(args:Array<String>, cb:IntegerReply):Void {})
  public function lpush(k:String,v:String,cb:IntegerReply):Void;
  public function rpush(k:String,v:String,cb:IntegerReply):Void;
  public function llen(k:String,cb:IntegerReply):Void;
  public function lrange(k:String,s:Int,e:Int,cb:MultiReply):Void;
  public function ltrim(k:String,s:Int,e:Int,cb:StatusReply):Void;
  public function lindex(l:String,i:Int,cb:BulkReply):Void;
  public function lset(k:String,i:Int,v:String,cb:StatusReply):Void;
  public function lrem(k:String,c:Int,v:String,cb:IntegerReply):Void;
  public function lpop(k:String,cb:MultiReply):Void;
  public function rpop(k:String,cb:MultiReply):Void;
  public function blpop(k:String,s:Int,cb:MultiReply):Void;
  public function brpop(k:String,s:Int,cb:MultiReply):Void;
  public function rpoplpush(sk:String,dk:String,cb:BulkReply):Void;

  // sets
  @:overload(function(args:Array<String>, cb:IntegerReply):Void {})
  public function sadd(k:String,v:String,cb:IntegerReply):Void;
  public function srem(k:String,v:String,cb:IntegerReply):Void;
  @:overload(function(k:String,count:Int,cb:BulkReply):Void {})
  public function spop(k:String,cb:BulkReply):Void;
  public function smove(sk:String,dk:String,member:String,cb:IntegerReply):Void;
  public function scard(k:String,cb:IntegerReply):Void;
  public function sismember(k:String,m:String,cb:IntegerReply):Void;
  public function sinter(k1:String,k2:String,cb:MultiReply):Void;
  public function sinterstore(dst:String,k1:String,k2:String,cb:StatusReply):Void;
  public function sunion(k1:String,k2:String,cb:MultiReply):Void;
  public function sunionstore(dst:String,k1:String,k2:String,cb:StatusReply):Void;
  public function sdiff(k1:String,k2:String,cb:MultiReply):Void;
  public function sdiffstore(dst:String,k1:String,k2:String,cb:StatusReply):Void;
  public function smembers(k:String,cb:MultiReply):Void;
  public function srandmember(k:String,cb:BulkReply):Void;

  // hash
  @:overload(function(args:Array<String>, cb:IntegerReply):Void {})
  public function hset(k:String,f:String,v:String,cb:IntegerReply):Void;
  public function hget(k:String,f:String,cb:BulkReply):Void;
  public function hsetnx(k:String,f:String,v:String,cb:IntegerReply):Void;
  @:overload(function(k:String,f:Dynamic<String>,cb:StatusReply):Void {})
  public function hmset(k:String, f:Array<String>,cb:StatusReply):Void;
  public function hmget(k:Array<String>,cb:MultiReply):Void;
  public function hincrby(k:String,f:String,v:Int,cb:IntegerReply):Void;
  public function hexists(k:String,f:String,cb:IntegerReply):Void;
  public function hdel(k:String,f:String,cb:IntegerReply):Void;
  public function hlen(k:String,cb:IntegerReply):Void;
  public function hkeys(k:String,cb:MultiReply):Void;
  public function hvals(k:String,cb:MultiReply):Void;
  public function hgetall(k:String,cb:MultiReply):Void;

  // sorted sets
  public function zadd(k:String,s:Int,m:String,cb:IntegerReply):Void;
  public function zrem(k:String,m:String,cb:IntegerReply):Void;
  public function zincrby(k:String,i:Int,m:String,cb:IntegerReply):Void;
  public function zrank(k:String,m:String,cb:BulkReply):Void;
  public function zrankrev(k:String,m:String,cb:BulkReply):Void;
  public function zrange(k:String,s:Int,e:Int,cb:MultiReply):Void;
  public function zrevrange(k:String,s:Int,e:Int,cb:MultiReply):Void;
  public function zrangebyscore(k:String,min:Int,max:Int,cb:MultiReply):Void;
  public function zremrangebyrank(k:String,s:Int,e:Int,cb:IntegerReply):Void;
  public function zremrangebyscore(k:String,min:Int,max:Int,cb:IntegerReply):Void;
  public function zcard(k:String,cb:IntegerReply):Void;
  public function zscore(k:String,e:String,cb:BulkReply):Void;
  public function zunionstore(prms:Array<Dynamic>,cb:IntegerReply):Void;
  public function zinterstore(prms:Array<Dynamic>,cb:IntegerReply):Void;
  public function sort(prms:Array<Dynamic>,cb:MultiReply):Void;

  // pubsub
  public function subscribe(c:Channel):Void;
  public function unsubscribe(c:Channel):Void;
  public function psubscribe(c:Channel):Void;
  public function punsubscribe(c:Channel):Void;
  public function publish(c:Channel,m:String):Void;

  // Misc
  public function multi(?prms:Array<MultiCommand>):Multi;
  public function eval(prms:MultiCommand,cb:Error->Dynamic->Void):Void;
  public function evalsha(prms:MultiCommand,cb:Error->Dynamic->Void):Void;

  private function new();
}
