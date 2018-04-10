package js.npm.bullarena;

typedef BullArenaOptions = {
	var queues :Array<BullArenaQueueConfiguration>;
}
typedef BullArenaQueueConfiguration = {
	var name :String;
	@:optional var port :Int;
	@:optional var host :String;
	var hostId :String;
	@:optional var db :String;
	@:optional var password :String;
	@:optional var prefix :String;
	@:optional var url :String;
}

typedef BullArenaListenOptions = {
	@:optional var port :Int;
	@:optional var basePath :String;
	@:optional var disableListen :Bool;
}

@:jsRequire("bull-arena")
extern class BullArena
{
	@:selfCall
	public function new(queueOpts :BullArenaOptions, ?listenOpts :BullArenaListenOptions) :Void;
}